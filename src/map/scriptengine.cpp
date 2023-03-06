// Copyright (c) Athena Dev Teams - Licensed under GNU GPL
// For more information, see LICENCE in the main folder

#include <iostream>

#include "clif.hpp"
#include "scriptengine.hpp"
#include "script.hpp"
#include "pc.hpp"
#include "map.hpp"
#include "npc.hpp"

#include <common/showmsg.hpp>
#include <common/db.hpp>

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

BUILDIN_FUNC(addnpc)
{
	struct npc_data* nd;
	char name[NAME_LENGTH], displayed_name[NAME_LENGTH], map_name[MAP_NAME_LENGTH_EXT], lua_function_name[LUAFUNC_MAX_NAME];
	short map_id, x, y, direction, sprite_code;

	std::snprintf(displayed_name, sizeof(displayed_name), "%s", luaL_checkstring(LuaInstance, 1));
	std::snprintf(name, sizeof(name), "%s", luaL_checkstring(LuaInstance, 2));
	std::snprintf(map_name, sizeof(map_name), "%s", luaL_checkstring(LuaInstance, 3));
	map_id = map_mapname2mapid(map_name);
	x = short (luaL_checkinteger(LuaInstance, 4));
	y = short (luaL_checkinteger(LuaInstance, 5));
	direction = short (luaL_checkinteger(LuaInstance, 6));
	sprite_code = short (luaL_checkinteger(LuaInstance, 7));
	std::snprintf(lua_function_name, sizeof(lua_function_name), "%s", luaL_checkstring(LuaInstance, 8));

	CREATE(nd, struct npc_data, 1);
	new (nd) npc_data();
	nd->bl.id = npc_get_new_npc_id();
	nd->bl.prev = nd->bl.next = nullptr;
	nd->bl.m = map_id;
	nd->bl.x = x;
	nd->bl.y = y;
	nd->sc_display = nullptr;
	nd->sc_display_count = 0;
	//nd->vd = npc_viewdb[0];
	nd->dynamicnpc.owner_char_id = 0;
	nd->dynamicnpc.last_interaction = 0;
	nd->dynamicnpc.removal_tid = INVALID_TIMER;
	nd->class_ = sprite_code;
	nd->speed = 200;
	nd->bl.type = BL_NPC;
	nd->subtype = NPCTYPE_SCRIPT;

	map_addnpc(map_id, nd);
	status_change_init(&nd->bl);
	unit_dataset(&nd->bl);
	nd->ud.dir = uint8 (direction);
	npc_setcells(nd);
	if (map_addblock(&nd->bl)) {
		lua_pushnil(LuaInstance);
		return 1;
	}
	map_addiddb(&nd->bl);
	//strdb_put(npcname_db, nd->exname, nd);

	return 0;
}

void LuaEngineBase::RegisterCFunctions(lua_State* LuaInstance)
{
	//lua_register(LuaInstance, "testfunc", testfunc);
	BUILDIN_DEF(testfunc);
	BUILDIN_DEF(mes);
	BUILDIN_DEF(next);
	BUILDIN_DEF(close);
}
