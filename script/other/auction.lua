local NPC_ID = {}

--Auction House Warpers
local ahg_name = "Auction Hall Guide"
local ahg_func = "AuctionWarp"

NPC_ID["ahg_moc"] = addnpc(ahg_name,"ahg_moc","moc_ruins",78,173,6,98,ahg_func)
NPC_ID["ahg_prt"] = addnpc(ahg_name,"ahg_prt","prontera",218,120,4,117,ahg_func)
NPC_ID["ahg_yuno"] = addnpc(ahg_name,"ahg_yuno","yuno",129,116,0,90,ahg_func)
NPC_ID["ahg_lhz"] = addnpc(ahg_name,"ahg_lhz","lighthalzen",205,169,6,833,ahg_func)

function AuctionWarp(cid,oid)
	talk("[" .. ahg_name .. "]", "Hello, would you", "like to enter the", "Auction Hall?", "/next")
	r = npcmenu("Yes","No",nil)
	if r == 1 then
		if NPC_ID["ahg_moc"] == oid or NPC_ID["ahg_lhz"] == oid then
			talk("[" .. ahg_name .. "]", "Great! Well then,", "I hope you have fun", "and enjoy the auction~")
			else
				talk("[" .. ahg_name .. "]", "Enjoy your auction.")
		end
			else talk ("[" .. ahg_name .. "]", "Aright then,", "see you later.", "If you change your", "mind, please come", "and enjoy the auctions~")
	end
	close()
	if r == 1 then
		if NPC_ID["ahg_moc"] == oid then warp("auction_01",179,53)
			elseif NPC_ID["ahg_prt"] == oid then warp("auction_01",21,43)
			elseif NPC_ID["ahg_yuno"] == oid then warp("auction_02",151,23)
			elseif NPC_ID["ahg_lhz"] == oid then warp("auction_02",43,24)
		end
	end
end

-- Sign Posts

local asp_name = "Information Post"
local asp_func = "AuctionSign"

NPC_ID["asp_moc"] = addnpc(asp_name,"asp_moc","moc_ruins",76,176,6,837,asp_func)
NPC_ID["asp_prt"] = addnpc(asp_name,"asp_prt","prontera",216,120,4,837,asp_func)
NPC_ID["asp_yuno"] = addnpc(asp_name,"asp_yuno","yuno",131,116,0,837,asp_func)
NPC_ID["asp_lhz"] = addnpc(asp_name,"asp_lhz","lighthalzen",207,169,6,837,asp_func)

function AuctionSign(cid,oid)
	talk("[Information]","Auction Warp Guide","/close")
end

-- Warps

addwarp("auction_entrance_moc","auction_01",180,49,"moc_ruins",78,171,1,1)
addwarp("auction_entrance_prt","auction_01",22,37,"prontera",214,120,1,1)
addwarp("auction_entrance_juno","auction_02",151,17,"yuno",132,119,1,1)
addwarp("auction_entrance_lhz","auction_02",43,17,"lighthalzen",209,169,1,1)

--Auction House NPCs

local ab_name = "Auction Broker"
local ab_func = "AuctionBroker"

NPC_ID["ab_moc1"] = addnpc(ab_name,"ab_moc1","auction_01",182,68,6,98,ab_func)
NPC_ID["ab_moc2"] = addnpc(ab_name,"ab_moc2","auction_01",182,75,0,99,ab_func)
NPC_ID["ab_moc3"] = addnpc(ab_name,"ab_moc3","auction_01",177,75,2,98,ab_func)
NPC_ID["ab_moc4"] = addnpc(ab_name,"ab_moc4","auction_01",177,68,4,99,ab_func)
NPC_ID["ab_prt1"] = addnpc(ab_name,"ab_prt1","auction_01",21,74,4,117,ab_func)
NPC_ID["ab_prt2"] = addnpc(ab_name,"ab_prt2","auction_01",27,78,4,116,ab_func)
NPC_ID["ab_prt3"] = addnpc(ab_name,"ab_prt3","auction_01",16,78,4,115,ab_func)
NPC_ID["ab_yuno1"] = addnpc(ab_name,"ab_yuno1","auction_02",158,47,6,90,ab_func)
NPC_ID["ab_yuno2"] = addnpc(ab_name,"ab_yuno2","auction_02",145,47,2,90,ab_func)
NPC_ID["ab_yuno3"] = addnpc(ab_name,"ab_yuno3","auction_02",151,54,0,90,ab_func)
NPC_ID["ab_yuno4"] = addnpc(ab_name,"ab_yuno4","auction_02",152,41,4,90,ab_func)
NPC_ID["ab_lhz1"] = addnpc(ab_name,"ab_lhz1","auction_02",57,46,2,874,ab_func)
NPC_ID["ab_lhz2"] = addnpc(ab_name,"ab_lhz2","auction_02",31,46,6,874,ab_func)
NPC_ID["ab_lhz3"] = addnpc(ab_name,"ab_lhz3","auction_02",43,65,4,833,ab_func)

function AuctionBroker(cid,oid)
	talk("[" .. ab_name .. "]", "Welcome to the Auction Hall.", "Would you like to view the goods?","/next")
	if menu("Yes","No",nil) == 1 then
		talk("[" .. ab_name .. "]","Very well.","Please take","a look, and see", "What's being offered~")
		OpenAuction()
	else
		talk("[" .. ab_name .. "]","Very well, then.", "If you change your", "mind, then please", "come and check",
			"out the auctions~")
	end
	close()
end
