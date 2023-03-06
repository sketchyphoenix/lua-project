// Copyright (c) Athena Dev Teams - Licensed under GNU GPL
// For more information, see LICENCE in the main folder

#include <iostream>

#include "clif.hpp"
#include "scriptengine.hpp"
#include "script.hpp"
#include "pc.hpp"

#include <common/showmsg.hpp>

LuaEngineBase LuaEngine;

/**
 * Create a global Lua thread, libraries
 * Defines global variable in the thread named __owner_id__ with a value of 0
 * __owner_id__ is equal to a player's character id if it's in their personal thread
**/
LuaEngineBase::LuaEngineBase()
{
	owner_id = 0;

    LuaInstance = luaL_newstate();
	luaL_openlibs(LuaInstance);	
	lua_pushliteral(LuaInstance, "__owner_id__");
	lua_pushnumber(LuaInstance,owner_id);
	lua_rawset(LuaInstance, LUA_REGISTRYINDEX);
	RegisterCFunctions(LuaInstance);

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

/*
* Attempt to convert a character's id to map_session_data
* If a character id was passed in the function call from Lua, it's given priority
* otherwise the lua thread's owner id is used.
*/
map_session_data* LuaEngineBase::GetCharacter(lua_State* LuaInstance, map_session_data* session_data, int stack_position)
{
	int character_id;

	character_id = int (lua_tointeger(LuaInstance, stack_position));
	if (character_id == 0) {
		lua_pushliteral(LuaInstance, "__owner_id__");
		lua_rawget(LuaInstance, LUA_REGISTRYINDEX);
		character_id = int(lua_tointeger(LuaInstance, -1));
		lua_pop(LuaInstance, 1);
	}

	session_data = map_charid2sd(character_id);
	if (character_id == 0 || session_data == nullptr) {
		ShowError("Target character not found for script command\n");
		return nullptr;
	}

	return session_data;
}

#define BUILDIN_DEF(x) lua_register(LuaInstance, #x, buildin_ ## x)
#define BUILDIN_FUNC(x) static int buildin_ ## x (lua_State* LuaInstance)
#define GET_CHARACTER(x) map_session_data* sd = nullptr; sd = LuaEngine.GetCharacter(LuaInstance, sd, x); if (!sd) { return 0; }

BUILDIN_FUNC(testfunc)
{
	const char* stack1 = luaL_checkstring(LuaEngine.LuaInstance, 1);
	int stack2 = int(luaL_checkinteger(LuaEngine.LuaInstance, 2));
	std::cout << stack1 << " " << stack2 << std::endl;
	return 0;
}

BUILDIN_FUNC(end)
{
	return lua_yield(LuaInstance, 0);
}

BUILDIN_FUNC(mes)
{
	GET_CHARACTER(2);

	clif_scriptmes(*sd, sd->npc_id, luaL_checkstring(LuaInstance, 1));

	return 0;
}

BUILDIN_FUNC(next)
{
	GET_CHARACTER(1);

	clif_scriptnext(*sd, sd->npc_id);
	sd->lua_container.script_state = WINDOW_NEXT;
	return lua_yield(LuaInstance, 0);
}

BUILDIN_FUNC(close)
{
	GET_CHARACTER(1);

	clif_scriptclose(sd, sd->npc_id);
	sd->lua_container.script_state = WINDOW_CLOSE;
	return lua_yield(LuaInstance, 0);
}

void LuaEngineBase::RegisterCFunctions(lua_State* LuaInstance)
{
	//lua_register(LuaInstance, "testfunc", testfunc);
	BUILDIN_DEF(testfunc);
	BUILDIN_DEF(mes);
	BUILDIN_DEF(next);
	BUILDIN_DEF(close);
}
