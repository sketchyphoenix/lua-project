-- Both implementations of temporary and global storage have the same base idea
-- StorageTable[CharID][variablename] = value
-- this is stored like a dictionary so it's rather easy to access variables without
-- having to do a long string of loops to figure it out.

module("storage",package.seeall)
--
-- Temporary Player/NPC Variable Storage
--
local _V = {}

function setv(oid, name, value)
	local buf = "O_" .. oid
	if _V[buf] == nil then _V[buf] = {} end
	_V[buf][name] = value
	return _V[buf][name]
end

function getv(oid, name)
	local buf = "O_" .. oid
	return _V[buf][name]
end

function npcsetv(oid, name, value)
	return setv(oid,name,value)
end

function npcgetv(oid, name, value)
	return getv(oid,name,value)
end


--
-- Permanent Player Variable Storage
--

local _P = {}

function setlocal(cid, name, value)
	if _P[cid] == nil then _P[cid] = {} end
	_P[cid][name] = value
	return _P[cid][name]
end

function getlocal(cid, name)
	return _P[cid][name]
end

--

function Save_P(_db,cid)
	if _db == 1 then --TXT ONLY
		Save_P_TXT(cid)
	else
		Save_P_SQL(cid)
	end
end

-- This one is likely to change. With support for sqlite already implemented, it's
-- likely there won't be a text database for these in the future.
-- Alternatively, I could construct these as lua files in lua format so I don't have to create
-- any routines to load them into memory since lua will do the magic on its own with a simple command :)
function Save_P_TXT(cid)
	local fname = "save/reg/char_" .. cid ..".txt"
	file = io.open(fname,"w")
	if file == nil then return end
	if _P[cid] == nil then return end
	file:write(cid .. "\n\n")
	for k,v in pairs(_P[cid]) do
		file:write(k .. " "..v.. "\n")
	end
	file:write("\n\n")
	file:close()
end

function Save_P_SQL(cid)
end
