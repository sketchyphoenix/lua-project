// Copyright (c) Athena Dev Teams - Licensed under GNU GPL
// For more information, see LICENCE in the main folder

#include <iostream>
#include "scriptengine.hpp"

/**
 * Create a global Lua thread,
 * Add a parameter named "char_id" as param #1 on the stack
 * Load script commands into the global index
 * 
 * char_id is assigned a value whenever a particular command is executed.
 * If it was triggered by a player, it will be assigned their character ID.
 * If it was triggered by a non-player, it will be -1.
 * 
 * This causes script commands that affect a player to fail if it's not
 * attached to a player.  However, this parameter can be overriden inside
 * the script by passing a value anyway.  In practice, instead of 
 * attaching and unattaching players to an entire script like in the old system,
 * they are passed as objects on a command basis.
**/
ScriptEngine::ScriptEngine()
{
    L = lua_open();
	luaL_openlibs(L);	
	lua_pushliteral(L,"char_id");
	lua_pushnumber(L,0);
	lua_rawset(L,LUA_GLOBALSINDEX);	
	script_buildin_commands_lua();
	return 0;
}
ScriptEngine::~ScriptEngine()
{
    lua_close(L);
}

ScriptEngine Script;