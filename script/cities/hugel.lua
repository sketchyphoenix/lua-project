-- LuAthena Script
--
-- Hugel City

--Hugel
addnpc("Young Man", "hugel_yman", "hugel", 189, 143, 5, 898, "hugel_youngman")
addnpc("Emily", "hugel_emly", "hugel", 126, 151, 3, 90, "hugel_emily")
addnpc("Kayplas", "hugel_kpls", "hugel", 86, 165, 5, 896, "hugel_kayplas")
addnpc("Lisa", "hugel_lisa", "hugel", 71, 197, 3, 90, "hugel_lisa")
addnpc("Old Nikki", "hugel_onki", "hugel", 169, 112, 5, 892, "hugel_nikki")
addnpc("Bismarc", "hugel_bsmrc", "hugel", 168, 183, 5, 118, "hugel_bismarc")
addnpc("Marius", "hugel_mrus", "hugel", 175, 115, 5, 897, "hugel_marius")
--Inside Hugel
addnpc("Chris", "hugel_chris", "hu_in01", 111, 386, 4, 86, "hugel_chris")
addnpc("Party Supplies", "hugel_party", "hu_in01", 23, 311, 4, 898, "hugel_partysupplies")
addnpc("A Part-Timer", "hugel_part1", "hu_in01", 18, 94, 0, 49, "hugel_parttime1")
addnpc("A Part-Timer", "hugel_part2", "hu_in01", 26, 77, 4, 50, "hugel_parttime2")

function hugel_youngman(cid, oid)
	talk("[Young Man]", "Huh. So that giant", "air pouch can make", "people float in midair?", "Would filling my tummy", "with air work the same way?", "/close")
end

function hugel_emily(cid, oid)
	talk("[Emily]", "I feel so blessed to", "live in this quaint, little", "town. It's so beautiful, and", "everyone here is so nice~", "/next", "[Emily]", "For some reason, my older", "sister wants to move out of", "Hugel as soon as she can.", "She", "says that she's getting creeped.", "out by the people that live here.", "Don't you think that sounds weird?", "/close")
end

function hugel_kayplas(cid, oid)
	talk("[Kayplas]", "Ooh, I really want to", "have that red bottle.", "I should ask my mom", "to buy me one. It doesn't", "look too expensive, does it?", "/close")
end

function hugel_lisa(cid, oid)
	talk("[Lisa]", "Hugel is a pretty", "small, homely village.", "Everyone knows everyone,", "everybody knows what", "everybody else is doing.", "It's so suffocating!", "/next",
		"[Lisa]", "There's no privacy in", "small towns.", "Someday,", "I wanna go out and", "live in the big city~", "/close")
end

function hugel_nikki(cid, oid)
	talk("[Old Nikki]", "You must not be from", "around here. Ah, you're", "an adventurer, right? Do", "you know how I could tell?", "/next",
		"[Old Nikki]", "It's because everyone", "who's lived here starts", "to look alike after a while.", "And you certainly don't look", "as old as us. Well, have", "a nice day, adventurer~", "/close")
end

function hugel_bismarc(cid, oid)
	talk("[Bismarc]", "^808080*Ghyklk*", "*Huk Hukk*^000000", "When will my", "o-order arrive...?", "/next", "[Bismarc]", "The poison in", "my body... the pain", "excruciating... L-lord...", "/next", "[Bismarc]", "When is the", "antidote gonna", "get here?!", "/close")
end

function hugel_marius(cid, oid)
	talk("[Marius]", "Yes, I'm an old man, but", "I can lick a whippersnapper", "like you any day of the week!", "You know, Hugel's got a longer", "life expectancy than all the other towns. You wanna know why?", "/next",
		"[Marius]", "It's because the old", "coots in this town refuse", "to just lay down and die!", "Now, c'mon! Lemme show", "you how strong I am! Let's", "wrestle or something, kid~", "/close")
end

function hugel_chris(cid, oid)
	talk("[Chris]", "You know, the people don't", "fight harmful monsters, they", "just protect themselves", "by equipping armor. That's", "just the way they are.", "/next", "[Chris]",
		"If you want to buy", "some nicer armors,", "then I suggest buying", "some in a bigger city.", "/close")
end

function hugel_partysupplies(cid, oid)
	talk("[Shopkeeper]", "Welcome to the party supplies", "shop!", "Why don't you enjoy some", "spectacular fireworks with your", "friends?", "We can provide you with 5 of them", "at 500 zeny.", "/next")
	local result = menu("Buy", "Cancel")
	if result == 1 then
		if readparam(Zeny) < 500 then
			talk("[Shopkeeper]", "I am sorry, but you don't have", "enough money~", "/close")
		else
			addzeny(-500); getitem(12018, 5)
			talk("[Shopkeeper]", "Here you go!", "Have fun with them!", "/close")
		end
	elseif result == 2 then
		talk("[Shopkeeper]", "Thank you, please come again.", "/close")
	end
end

function hugel_parttime1(cid, oid)
	talk("[Luda]", "Welcome to the", "Shrine Expedition Office.", "I'm Luda, a part-time", "assistant. My job is to", "keep this office neat and", "clean, but look at this place!", "/next", "[Luda]", 
		"Still, I think I can", "handle this difficult task~", "This room is the office for", "the Schwaltzvalt Republic team,", "and the other is for Rune-", "Midgarts Kingdom team.", "/next", "[Luda]",
		"I have to clean both rooms,", "so they keep me pretty busy.", "Why don't you volunteer for", "their expedition? I know they", "can't really pay you, but it's", "a great chance to explore~", "/close")
end

function hugel_parttime2(cid, oid)
	talk("^3355FFThis part-timer is", "completely engrossed", "in his task of organizing", "files and books. ^000000", "/close")
end