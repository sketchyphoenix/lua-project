--------------------------------------------------------------
--                eAthena Primary Scripts File              --
--------------------------------------------------------------
-- The idea of this new system is to make scripts more organized
-- since the old system was rather messy with all the NPCs in one
-- file. Now scripts are organized in to files arraged by type.
-- Custom scripts are now in script_custom.lua, all other
-- scripts are deemed as 'official'. You should place your NPCs
-- in to script_custom.lua to follow the trend.
--
-- Thanks,
--  Ancyker and the rest of the eAthena Team

--------------------------------------------------------------
------------------- Core Scripts Functions -------------------
-- Simply do NOT touch this !
-- Seriously, only touch it if you know what you're doing.
-- Otherwise you'll just break everything.
dofile "script/core/core.lua"
--------------------------------------------------------------
------------------------ Script Files ------------------------

-- Sample scripts
dofile "script/sample/script_sample.lua"

-- City Scripts
dofile "script/cities/script_cities.lua"

-- Warps
--dofile "script/warps/script_warps.lua"

-- Monster Spawn
dofile "script/spawns/script_spawns.lua"

-- Shops/Merchants
dofile "script/merchants/script_merchants.lua"

-- Guild Siege (War of Emperium)
--dofile "script/guildsiege/script_guildsiege.lua"

-- Your NPCs go in this file!
dofile "script/custom/script_custom.lua"
--------------------------------------------------------------
