// Copyright (c) Athena Dev Teams - Licensed under GNU GPL
// For more information, see LICENCE in the main folder

#ifndef _SCRIPTENGINE_H
#define _SCRIPTENGINE_H
#endif

#include <vector>
#include <lua.hpp>

#include "pc.hpp"

enum e_engine_version { LUA,ATHENA };
enum e_execution_state { NOT_RUNNING } lua_execution_state;


class ScriptEngine {
public:
	enum e_engine_version version;
	virtual void ExecuteFunction(const char* function_name, const int& character_id, const char* format, ...) {};
};


class LuaEngineBase : ScriptEngine {
public:
	lua_State* LuaInstance;

	LuaEngineBase::LuaEngineBase();

	void ExecuteFunction(const char* function_name, const int& character_id, const char* format, ...) override;

	void GetCharacter(lua_State* LuaInstance, map_session_data* session_data, int stack_position);
};
