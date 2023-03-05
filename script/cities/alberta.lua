addnpc("Fabian","albera_fabian","alberta",97,51,0,84,"AlbertaFabian")

function AlbertaFabian(cid,oid)
	local name = "[Fabian]"
	talk(name, "Man... when you travel all over the world, you hear of some crazy things.",
		"/next", name, "Once, I heard that there are Cards which contain the power of monsters. If someone happens to get their hands on a card, they'll be able to use that monster's power.",
		"/next", name, "I'm guessing it's some sort of fad or scam, where they make you collect all the cards or whatever. I mean, how could a card really hold the power of a monster?!",
		"/next", name, "Seriously...", "/close")
end

addnpc("Steiner","alberta_steiner","alberta",53,39,0,100,"AlbertaSteiner")

function AlbertaSteiner(cid,oid)
	local name = "[Steiner]"
	talk(name, "Oh...!", "Welcome to Alberta,", "young adventurer!", "/next", name,
		"Pardon me if I seem distracted. I'm milling about, trying to make a plan. You see, I hear that there is a store in Geffen that sells armor that is resistant to magic.",
		"/next", name, "If I buy a lot of them in bulk, and then resell them here for a higher price...", "/close")
end

addnpc("Chad","alberta_chad","alberta",20,183,0,49,"AlbertaChad")

function AlbertaChad(cid,oid)
	local name = "[Chad]"
	talk(name, "People say the legendary weapon Gungnir never misses its target. I wonder if it's possibly true...",
		"/next", name, "People also say that babies are assembled by storks before delivery, girls dig guys who act like jerks, and Santa Claus exists! But only in Lutie.",
		"/next", name, "I wonder...", "If any of that", "is possibly", "true...", "/close")
end

addnpc("Drunken Old Man","alberta_drunkman","alberta",131,139,2,54,"AlbertaDrunkMan")

function AlbertaDrunkMan(cid,oid)
	local name = "[Deagle]"
	talk(name, "^666666*Hiccup*^000000", "Wh-what are you", "staring at? Get lost!!", "/next")
	if menu("Say Nothing.","Leave him alone.") == 1 then
		talk(name, "Hahahaha ^666666*hiccup*^000000... You've got some nerve. I may look worthless now, but I used to be a sailor on the 'Going Mary.'", "/next")
			if menu("Never heard of it.","Really? No kidding!") == 1 then
				talk(name, "Never heard of it?! Everybody knows th'notorious pirate ship 'Going Mary!' ^666666*Hiccup~*^000000", "/next", name,
				"Ah~ The ol'days. If only... If only we hadn't run into that STORM...^666666*hiccup*^000000", "/next", name,
				"AH~ Captain. I miss our cap'n more than anything... No foe survived before cap'n's sword.", "/close")
			else
				talk(name, "That's right! NOBODY meshes with the crew of 'Going Mary!' And nobody can beat our cap'n in a sword fight!", "/next", name,
				"CAPTAIN~!!! ^666666*HICCUP~*^000000 He would swing his sword like this, then... THEN!!", "/next", name,
				"The bastard the captain was fighting, and anyone of his friends near him, were surrounded in flame!", "/next", name,
				"Man, that sword must have had some sort of mysterious power, or the captain was just that good...!", "/next", name,
				"Phew~~ ^666666*Sob* *Sob...*000000 God, I miss everyone! Now I'm depressed! Please, go away now.", "/close")
			end
	else
		talk(name, "That's right!", "Go AWAY~", "/close")
	end
end

addnpc("Shakir","alberta_shakir","alberta",58,80,2,99,"AlbertaShakir")

function AlbertaShakir(cid,oid)
	local name = "[Shakir]"
	mes(name)
	if math.random(2) == 2 then
		talk("We Merchants have our own negotiating skill when we sell goods. This skill can get us more money than when other people sell goods.", "/next", name,
		"It's more than just yelling 'You'll have to give more money please!' You need to have charisma and master rhetoric!", "/next", name,
		"We can get up to 24 % more zeny with this incredible skill. But remember to train hard to acquire it!!")
	else
		talk("We Merchants can", "open roadside stands", "to do business.", "/next", name,
		"With the Discount skill, we can buy goods really cheap from the stores in towns and load them into the cart we rent.", "/next", name,
		"Then afterwards, we can travel anywhere, and sell our goods to make a profit!", "/next", name,
		"This way, business is more convenient and safe. Don't fall asleep, although it's too easy to do that.")
	end
	close()
end

addnpc("Sonya","alberta_sonya","alberta",62,156,2,102,"AlbertaSonya")

function AlbertaSonya(cid,oid)
	local name = "[Sonya]"
	local r = math.random(3)
	mes(name)
	if r == 1 then
		talk("Hey, you know this one time I was walking through the forest and I saw this little green stem moving around.", "/next", name,
		"I went to see what it was and when I went to touch it. The stem actually slapped my hand!", "/next", name,
		"It startled me, so I jumped back a bit and realized it wasn't a stem, but a very small animal.", "/next", name,
		"I was lucky I didn't upset it. Even the smallest animal can be dangerous if angered.")
	elseif r == 2 then
		talk("You know those lazy looking bears that live in the forest on the way to Payon?", "/next", name,
		"Just for fun, I threw a rock at it and all of a sudden it rushed at me! I was sooooo scared, I started to run away, then BAM!!!", "/next", name,
		"It ran into a low tree branch and knocked itself out! I swear, I'll never provoke an animal for fun again!")
	elseif r == 3 then
		talk("I once saw a pack of wolves take on one of those huge, lazy bears!", "/next", name, "Wolves are much moer cooperative than they seem. If one is attacked, then any nearby wolves will run to help.",
		"/next", name, "I'd think twice if you ever want to fight one when others of its kind are around. Be careful: don't get ganged up on!")
	end
	close()
end

addnpc("Grandmother Alma","alberta_alma","alberta",93,174,2,103,"AlbertaAlma")

function AlbertaAlma(cid,oid)
	local name = "[Grandmother Alma]"
	talk(name, "Some time ago", "a derelict ship", "drifted into", "Alberta harbour", "/next", name, "Hoping to save any survivors, some of the townspeople ventured into the ship. However, they all ran out terrified, saying that corpses were walking around inside the ship.",
	"/next", name, "The ship was also packed with dangerous marine organisms, and they couldn't get inside, even if they wanted to.", "/next", name,
	"We couldn't do anything about that ominous looking ship, and just left it as it was. Nowadays, exploration teams try to enter that ship and wipe out its monsters.", "/next", name,
	"So it might be a good experience for a young person like yourself to be a recruit. But, it's still not worth risking your life if you're not strong enough.", "/close")
end

addnpc("Fisk","alberta_fisk","alberta",189,151,5,100,"AlbertaFisk")

function AlbertaFisk(cid,oid)
	local name = "[Fisk]"
	talk(name, "Ahoy mate,", "where'd ya", "wanna go?", "/next")
	local r = menu("Sunken Ship -> 250 zeny.", "Izlude Marina -> 500 zeny.", "Never mind.")
	if r == 1 then
		if readparam(Zeny) < 250 then
			talk(name, "Hey now, don't try to cheat me! I said 250 zeny!", "/close")
		else
			addzeny(-250)
			return warp("alb2trea",43,53)
		end
	elseif r == 2 then
		if readparam(Zeny) < 500 then
			talk(name, "Ain't no way yer getting there without 500 zeny first!", "/close")
		else
			addzeny(-500)
			return warp("izlude",176,182)
		end
	elseif r == 3 then
		talk(name, "Alright...", "Landlubber.", "/close")
	end
end

addnpc("Fisk","alb2trea_fisk","alb2trea",39,50,6,100,"Alb2treaFisk")

function Alb2treaFisk(cid,oid)
	talk("[Fisk]", "So you anna head back to the mainland in Alberta, eh?", "/next")
	if menu("Yes please.", "I changed my mind.") == 1 then
		return warp("alberta",192,169)
	else close()
	end
end

addnpc("Paul","alberta_paul","alberta",195,151,2,86,"AlbertaPaul")

function AlbertaPaul(cid,oid)
	local name = "[Paul]"
	talk(name, "Good day~", "Would you like", "to join the", "exploration team", "of the Sunken Ship?", "/next",
		name, "Oh! Before you join, I must warn you. If you're not that strong, you may not want to go.", "/next", name,
			"So, want", "to sign up?", "The admission", "fee is only", "200 Zeny.", "/next")
	if menu("Sign me up!", "Uh, no thanks.") == 1 then
		if readparam(Zeny) < 200 then talk(name, "It seems you don't have the money, my friend. But please come back when you're able to pay")
		else
			addzeny(-200)
			warp("alb2trea",62,69)
		end
	else
		talk(name, "Alright, well...", "I'll be around", "if you change", "your mind.")
	end
	close()
end

addnpc("Phelix","alberta_phelix","alberta",190,173,4,85,"AlbertaPhelix")

function AlbertaPhelix(cid,oid)
	local name = "[Phelix]"
	local weight = readparam(MaxWeight) - readparam(Weight)

	mes(name)
	if weight < 10000 then
		talk("Wait a moment!!", "you have brought too many things!", "You cannot accept any more items!", "Please reduce the amount of items,",
			"then come see me again.")
		close(); halt()
	elseif GetV(cid,"event_zelopy") == nil then
		talk("The hell are you doing here?", "There is nothing you can get for free on this ship, if you want somethin', work for it!!", "/next",
			name, "Hmm, so why don't you bring me 10 jellopies and I will give 1 potion. How's that sound?",
			"Or if that's too hard for your pansy ass, 3 jellopies for 1 Carrot.", "/next", name,
			"If you're interested in my offer, give me the stuff I mentioned.")
		SetV(cid,"event_zelopy",1)
		close(); halt()
	end

	mes("Hmm.. you want to exchange jellopies for Red Potions or some Carrots eh? Well.. which one?")
	npcnext()
	local r = menu("Red Potions Please","Carrots please.")
	if r == 1 then
		talk(name, "Alright...", "Let's see", "what'cha got...", "/next", name)
		if countitem(909) < 10 then mes("Hey! Weren't you listening? I said 10 jellopies for 1 Red Potion.. are ya deaf?"); close(); halt()
		local maxp = countitem(909) / 10
		talk("Hmm, not bad...", "How many potions", "do you want to get?", "/next")
		local r = menu("As many as I can, please.", "I want this many.", "Never mind, I like my jellopy.")

		if r == 1 then delitem(909,(maxp*10)); getitem(501,maxp); end
		if r == 2 then talk(name, "I'm not giving you more than 100 at a time so don't bother, OK?", "If you don't want any, just say '0'.",
			"Right now, the most you can get is" .. maxp " but remember, 100 at most, you want to break my back?")
			local in_value = input(0)
			npcnext()
			mes(name)
			if in_value <= 0 then mes("Much obliged, come again anytime."); close(); halt(); end
			if in_value > 100 then mes("Hey, what'd I say? 100 at a time at most, you're trying to kill me aren't you!"); close(); halt(); end
			if countitem(909) < in_value*10 then mes("Hmm, it looks like you don't have enough. Go get more jellopies if you want anything else from me."); end
			delitem(909,in_value*10); getitem(501,in_value); end
		if r == 3 then talk(name,"No problem,", "see you next time.", "/close"); halt(); end
	elseif r == 2 then
		talk(name, "Alright, let's see what ya got...", "/next", name)
		if countitem(909) < 3 then mes("Hmm, look pansy ass, I said 3 jellopies for 1 Carrot.. got it?"); close(); halt();
		else
			local amount = countitem(909)/3
			talk("Not too bad pansy...", "How many do you want?","/next")
			local result = menu("As many as I can get, please","I want this many", "Never mind", "I like my jellopy.")
			if result == 1 then delitem(909,maxc*3); getitem(515,maxc);
			elseif result == 2 then
				talk(name, "Right I'm not giving you more than 100 at a time so don't bother, okay? If you don't want any, just say '0'.")
				local amount = input(0); npcnext(); mes(name)
				if amount == 0 then mes("Alright then, see you next time."); close(); halt(); end
				if amount > 100 then mes("Hey pansy ass, I said 100 at the most, no more than that! I'm not going to break my back for the likes of you!"); close(); halt(); end
				if countitem(909) < amount*10 then mes("Seems you don't have enough. Go get some more if you want anything else."); close(); halt(); end
				delitem(909,amount*3); getitem(515,amount);
			end
		talk(name,"There you go~! As I promised. Try not to stuff yer face.","/close")
			end
		end
	end
end
