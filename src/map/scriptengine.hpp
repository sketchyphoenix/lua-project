// Copyright (c) Athena Dev Teams - Licensed under GNU GPL
// For more information, see LICENCE in the main folder

#ifndef _SCRIPTENGINE_H
#define _SCRIPTENGINE_H

extern "C" {
    #include <lua.h>
    #include <lualib.h>
    #include <lauxlib.h>
}

lua_State *L;

class ScriptEngine {
    private:

    public:
        struct lua_command_table{
            const char *command;
            lua_CFunction function_name;
        }
        std::vector<lua_command_table> commands;

        ScriptEngine();
        ~ScriptEngine();


}