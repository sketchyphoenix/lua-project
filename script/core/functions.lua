--[[ ===============

   BUILDIN FUNCTIONS

================ --]]

-- Most of these functions are tail calls so that they retain their original names from the old script engine.
function menu(...)
	return npcmenu(arg)
end

function select(...)
	return npcmenu(arg)
end

function shop(...)
	return npcshop(arg)
end

function setmapflag (...)
	return editmapflag(arg)
end

function removemapflag (mapname,flag)
	return editmapflag(mapname,flag,0)
end

function addtoskill(...)
	local va_list = {...}
	return skill(va_list[1],va_list[2], 2)
end

--sleep() command
function sleep(n)  -- seconds
	local clock = os.clock
	local t0 = clock()
	while clock() - t0 <= n do end
end

--Return timer tick in milliseconds
function gettick(n)
	local clock = os.clock
	return clock - n/1000
end

function disablenpc(name)
	return npc_enable(name,0)
end

function enablenpc(name)
	return npc_enable(name,1)
end

function setmapflag (...)
	return editmapflag(arg)
end

function removemapflag (...)
	return editmapflag(arg)
end

function addnpc (name,exname,map,x,y,dir,class_,func)
	local id = _addnpc(name,exname,map,x,y,dir,class_,func)
	return id, name, exname
end

function getiteminfo (itemid,itemtype)
	return iteminfo(itemid,itemtype,0)
end

function setiteminfo (itemid,itemtype,value)
	return iteminfo(itemid,itemtype,1,value)
end

function getinventorylist (inventorylist,charid)
	if charid == "self" then
		charid = nil
	end
	inventorylist.id = _getinventorylist(1,charid)
	inventorylist.amount = _getinventorylist(2,charid)
	inventorylist.equip = _getinventorylist(3,charid)
	inventorylist.refine = _getinventorylist(4,charid)
	inventorylist.identify = _getinventorylist(5,charid)
	inventorylist.attribute = _getinventorylist(6,charid)
	inventorylist.card1 = _getinventorylist(7,charid)
	inventorylist.card2 = _getinventorylist(8,charid)
	inventorylist.card3 = _getinventorylist(9,charid)
	inventorylist.card4 = _getinventorylist(10,charid)
	inventorylist.expire = _getinventorylist(11,charid)
	inventorylist.count = _getinventorylist(12,charid)
	return inventorylist
end

function getskilllist (skilllist,charid)
	if charid == "self" then
		charid = nil
	end
	skilllist.id = _getskilllist(1,charid)
	skilllist.lv = _getskilllist(2,charid)
	skilllist.flag = _getskilllist(3,charid)
	skilllist.count = _getskilllist(4,charid)
	return skilllist
end

function disguise (id,charid)
	if charid == "self" then
		charid = nil
	end

	return _disguise(id,1,charid)
end

function undisguise (id,charid)
	if charid == "self" then
		charid = nil
	end

	return _disguise(id,0,charid)
end

function getmapxy(...)
	return getlocation(arg)
end

function isday()
	return (getnightflag==0) and 1 or nil
end

function isnight()
	return (getnightflag==1) and 1 or nil
end

function day()
	return togglenight()
end

function night()
	return togglenight()
end

--Used internally
function luagettarget()
	return retrcharid
end

function waitingroom2bg(...)
	local buffer = _waitingroom2bg(arg)
	local x = table.getn(buffer)
	buffer.bg_id = buffer[x]
	buffer.arenamembercount = buffer[x-1]
	buffer[x] = nil
	buffer[x-1] = nil
	return buffer
end

function monster(...)
	local tmp = {...}
	if type(tmp[8]) == "number" then
		return _monster(tmp[1],tmp[2],tmp[3],tmp[4],tmp[5],tmp[6],tmp[7],tmp[8])
	elseif type(tmp[8]) ~= nil then
		error("lua:monster : invalid argument #8. expected number or nil value")
	else
		return _monster(tmp[1],tmp[2],tmp[3],tmp[4],tmp[5],tmp[6],tmp[7],0)
	end
end

function areamonster(...)
	local tmp = {...}
	if type(tmp[10]) == "number" then
		return _areamonster(tmp[1],tmp[2],tmp[3],tmp[4],tmp[5],tmp[6],tmp[7],tmp[8],tmp[9],tmp[10])
	elseif type(tmp[8]) ~= nil then
		error("lua:areamonster : invalid argument #10. expected number or nil value")
	else
		return _areamonster(tmp[1],tmp[2],tmp[3],tmp[4],tmp[5],tmp[6],tmp[7],tmp[8],tmp[9],0)
	end
end

--Wrapper for typical NPC conversations.
function talk(...)
	local tmp = {...}
	for i=1, table.getn(tmp) do
		if tmp[i] == "/next" then
			npcnext()
		elseif tmp[i] == "/close" then
			close()
		elseif checktype(tmp[i]) == TYPE_STR then
			mes(tmp[i])
		end
	end
end

-- Scriptable GM commands system.
-- Basic implementation is here. The commands are stored in a dictionary
-- I found this to be a good method of doing this implementation without having
-- to rely on most of the code or the storage itself being in the source. 
local gmcommands = {}
function addgmcommand(name,fname)
	gmcommands[name] = fname
end

function is_scriptedcommand(name)
	buf = string.gsub(name,"@","",1)
	if gmcommands[buf] then scmd_flag(1); return callfunc(gmcommands[buf])
	end
end

-- I'm not sure if I want to keep this or not.
TYPE_NIL = 0
TYPE_NUM = 1
TYPE_STR = 2
TYPE_FUNC = 3
TYPE_TBL = 4
function checktype (var)
	if type(var) == "number" then
		return TYPE_NUM
	elseif type(var) == "string" then
		return TYPE_STR
	elseif type(var) == "function" then
		return TYPE_FUNC
	elseif type(var) == "table" then
		return TYPE_TBL
	else
		return nil
	end
end

