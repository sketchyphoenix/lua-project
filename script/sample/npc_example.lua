addnpc("Healer Dog","healer_ald","aldebaran.gat",135,115,4,81,"npc_healer")
addnpc("Healer Dog","healer_gef","geffen.gat",125,95,4,81,"npc_healer")
addnpc("Healer Dog","healer_moc","morocc.gat",160,100,4,81,"npc_healer")
addnpc("Healer Dog","healer_prt","prontera.gat",155,190,4,81,"npc_healer")

function npc_healer()
	mes "[Healer Dog]"
	mes "Would you like a heal?"
	npcnext()
	local r = npcmenu("Sure","I prefer potions","eh",nil)
	if r == 1 then
		mes "[Healer Dog"
		mes "How much HP and SP would you like?"
		npcnext()
		heal(input(),input())
		mes "[Healer Dog]"
		mes "Here you go!"
		close()
	elseif r == 2 then
		mes "[Healer Dog]"
		mes "Oh, right, I have some potions to sell!"
		close()
		npcshop(501,50,502,100)
	elseif r == 3 then
		mes "[Healer Dog]"
		mes "Sorry to hear that..."
		close()
	end
end

addnpc("Healer Dog","healer_nif","niflheim.gat",195,195,4,81,"npc_biter")
addareascript("Bite Area","niflheim.gat",190,190,200,200,"areascript_biter")

function npc_biter()
	mes "[Healer Dog]"
	mes "Come, come closer so I can heal you!"
	npcnext()
	mes "This dog looks ferocious... I should better keep away... How far?"
	npcnext()
	mes("Yes, I think I need to be at least "..input().." "..input(1).." away from him to be safe.")
	close()
end

function areascript_biter()
	percentheal(-50,-50)
end
