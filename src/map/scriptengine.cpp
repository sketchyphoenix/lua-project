// Copyright (c) Athena Dev Teams - Licensed under GNU GPL
// For more information, see LICENCE in the main folder

#include <iostream>
#include "scriptengine.hpp"
#include "pc.hpp"
#include "script.hpp"

#include <common/showmsg.hpp>

LuaEngineBase LuaEngine;

/**
 * Create a global Lua thread,
 * Add a parameter named "char_id" as param #1 on the stack
 * Load script commands into the global index
 * 
 * char_id is assigned a value whenever a particular command is executed.
 * If it was triggered by a player, it will be assigned their character ID.
 * If it was triggered by a non-player, it will be a non-valid ID.
 * 
 * This causes script commands that affect a player to fail if it's not
 * attached to a player.  However, this parameter can be overriden inside
 * the script by passing a value anyway.  In practice, instead of 
 * attaching and unattaching players to an entire script like in the old system,
 * they are passed as objects on a command basis.
**/

static int testfunc(lua_State* LuaInstance)
{
	const char* stack1 = luaL_checkstring(LuaEngine.LuaInstance, 1);
	int stack2 = luaL_checkinteger(LuaEngine.LuaInstance, 2);
	std::cout << stack1 << " " << stack2 << std::endl;
	return 0;
}

LuaEngineBase::LuaEngineBase()
{
    LuaInstance = luaL_newstate();
	luaL_openlibs(LuaInstance);	
	//lua_pushliteral(LuaInstance,"char_id");
	//lua_pushnumber(LuaInstance,0);
	//lua_rawset(LuaInstance, LUA_REGISTRYINDEX);
	lua_register(LuaInstance, "testfunc", testfunc);

	std::string chunk = "var = \"Hello, World!\"";
	luaL_dostring(LuaInstance, chunk.c_str());
	lua_getglobal(LuaInstance, "var");
	std::cout << "var is: " << (const char*)lua_tostring(LuaInstance, -1) << std::endl;

	luaL_dofile(LuaInstance, "script/test.lua");
}



LuaEngineBase::~LuaEngineBase()
{
	lua_close(LuaInstance);
}

/*
static struct command_table {
	const char* command;
	lua_CFunction function_name;
};
*/


/**
* Runs Lua function from C++
* The Lua function in particular is passed as an argument for addnpc() 
* That Lua function is then triggered from the C++ function npc_click()
*	
* Non-player scripts run on the global thread
* Player scripts run on the player's local thread
*
* Add the player's character ID to their thread's global index
* Perform checking to make sure the arguments are valid in Lua before putting them on the stack
**/
void LuaEngineBase::ExecuteFunction(const char* function_name, const int& character_id, const char* format, ...)
{
	va_list lua_function_argument;
	map_session_data* sd;
	int iter = 0;
	lua_State* lua_state_ref = LuaInstance;

	if (character_id <= 0) {
		return;
	}

	sd = map_charid2sd(character_id);
	if (sd->lua_container.script_state != NOT_RUNNING) {
		return;
	}
	sd->lua_container.LuaInstance = lua_newthread(LuaInstance);
	lua_state_ref = sd->lua_container.LuaInstance;
	lua_pushliteral(lua_state_ref, "character_id");
	lua_pushnumber(lua_state_ref, character_id);
	lua_rawset(lua_state_ref, LUA_REGISTRYINDEX);

	lua_getglobal(lua_state_ref, function_name);

	va_start(lua_function_argument, format);
	while (*format) {
		switch (*format++) {
		case 'd':
			lua_pushnumber(lua_state_ref, va_arg(lua_function_argument, double));
			break;
		case 'i':
			lua_pushinteger(lua_state_ref, va_arg(lua_function_argument, int));
			break;
		case 's':
			lua_pushstring(lua_state_ref, va_arg(lua_function_argument, char*));
			break;
		default:
			ShowError("%c : Invalid argument type code, allowed codes are 'd'/'i'/'s'\n", *(format - 1));
		}
		iter++;
		luaL_checkstack(lua_state_ref, 1, "Too many function arguments.");
	}
	va_end(lua_function_argument);

	if (lua_resume(lua_state_ref, nullptr, iter, &iter) && lua_tostring(lua_state_ref, -1) != nullptr) {
		ShowError("Cannot run function %s : %s\n", function_name, lua_tostring(lua_state_ref, -1));
		return;
	}

	if (sd->lua_container.script_state == NOT_RUNNING) {
		sd->lua_container.LuaInstance = nullptr;
		sd->npc_id = 0;
	}

	return;
}

void LuaEngineBase::GetCharacter(lua_State* LuaInstance, map_session_data* session_data, int stack_position)
{
	int character_id;

	character_id = int (lua_tointeger(LuaInstance, stack_position));
	if (character_id == 0) {
		ShowError("Target character not found for script command\n");
		return;
	}
	session_data = map_charid2sd(character_id);
	lua_pushliteral(LuaInstance, "character_id");
	lua_rawget(LuaInstance, LUA_REGISTRYINDEX);
	lua_pop(LuaInstance, 1);
}


#define BUILDIN_FUNC(x) lua_register(LuaEngine.LuaInstance, #x, ##x); \
			static int buildin_ ## x (LuaEngine.LuaInstance)

