-- Seriously, don't modify anything here
-- If you don't know what you're doing. 
-- You will break A LOT of things if you do.


-- User defined modules should be placed in /script/modules/ 
-- for cleanliness. If you feel that you shouldn't use the
-- pre-defined modules folder, append a new path.
local usermodulepath = "./script/modules/?.lua;"
local usermodulepathc = "./script/modules/?.luac;"
package.path = package.path .. usermodulepath .. usermodulepathc

dofile "script/core/functions.lua"
dofile "script/core/storage.lua"
dofile "script/core/const.lua"
dofile "script/core/events.lua"