--Major 5, Minor $Revision$
--[[

	How to Localize this, because it's a pain in the ass.

	/dump UnitName("target")
	/dump GetTitleText()

	The Lines marked NPC must have the EXACT spelling and coding as the above command for UnitName()
	Same applys for the *Quest marked lines, must have the EXACT spelling and coding as given by "GetTitleText()"
	if they are not the same then it will not work.

	all other lines are bissness as usual, being touched every few weeks.

]]--




local L = LibStub("AceLocale-3.0"):NewLocale("SickOfClickingDailies", "frFR")

if L then
--Skettis
	L["Sky Sergeant Doryn"] = "Sergent Doryn de la Garde-ciel"		--*NPC
		L["Fires Over Skettis"] = "Un déluge de feu sur Skettis"	--*Quest
		L["Escape from Skettis"] = "L'évasion de Skettis"			--*Quest

	L["Skyguard Prisoner"] = "Prisonnier de la Garde-ciel"			--*NPC

	L["Skyguard Khatie"] = "Garde-ciel Khatie"											--*NPC
		L["Wrangle More Aether Rays!"] = "Allez dompter d'autres raies de l'éther !"	--*Quest

	L["Sky Sergeant Vanderlip"] = "Sergent Vanderlip de la Garde-ciel"	--*NPC
		L["Bomb Them Again!"] = "Bombardez-les encore !"				--*Quest

--Ogri'la
	L["Chu'a'lor"] = "Chu'a'lor"											--*NPC
		L["The Relic's Emanation"] = "Les émanations des reliques"			--*Quest

	L["Kronk"] = "Kronk" 												--*NPC
		L["Banish More Demons"] = "Bannissez plus de démons"			--*Quest

--Netherwing
	L["Mistress of the Mines"] = "Maîtresse des mines"				--*NPC
		L["Picking Up The Pieces..."] = "Ramasser les morceaux…"	--*Quest

	L["Dragonmaw Foreman"] = "Contremaître Gueule-de-dragon"										--*NPC
		L["Dragons are the Least of Our Problems"] = "Les dragons sont les derniers de nos soucis"	--*Quest

	L["Yarzill the Merc"] = "Yarzill le Mercenaire"						--*NPC
		L["The Not-So-Friendly Skies..."] = "Les cieux pas si cléments…"	--*Quest
		L["A Slow Death"] = "Une mort lente"								--*Quest

	L["Taskmaster Varkule Dragonbreath"] = "Sous-chef Varkule Souffle-de-dragon"	--*NPC
		L["Nethercite Ore"] = "Du minerai de néanticite"							--*Quest
		L["Netherdust Pollen"] = "Du pollen de pruinéante"							--*Quest
		L["Nethermine Flayer Hide"] = "Des peaux d'écorcheurs mine-néant"			--*Quest
		L["Netherwing Crystals"] = "Les cristaux de l'Aile-du-Néant"				--*Quest

	L["Chief Overseer Mudlump"] = "Surveillant-chef Tadboue"																	--*NPC
		L["The Booterang: A Cure For The Common Worthless Peon"] = "Le botterang : un traitement pour les péons bons à rien"	--*Quest

	L["Commander Arcus"] = "Commandant Arcus"										--*NPC
	L["Commander Hobb"] = "Commandant Hobb"											--*NPC
	L["Overlord Mor'ghor"] = "Suzerain Mor'ghor"									--*NPC
		L["Disrupting the Twilight Portal"] = "Perturber la Porte du crépuscule"	--*Quest
		L["The Deadliest Trap Ever Laid"] = "Le plus mortel des pièges"				--*Quest

--Shattered Sun Offensive
	L["Vindicator Xayann"] = "Redresseur de torts Xayann"					--*NPC
		L["Erratic Behavior"] = "Comportement erratique"				--Quest
		--L["Further Conversions"] = true				--Quest
	L["Captain Theris Dawnhearth"] = "Capitaine Theris Âtraurore"
		L["The Sanctum Wards"] = "Les protections du sanctum"
		-- L["Arm the Wards!"] = true
	-- L["Harbinger Haronem"] = true
		-- L["The Multiphase Survey"] = true
	-- L["Lord Torvos"] = true
		-- L["Sunfury Attack Plans"] = true
	-- L["Emissary Mordin"] = true
		-- L["Gaining the Advantage"] = true
	-- L["Magistrix Seyla"] = true
		-- L["Blast the Gateway"] = true
		-- L["Blood for Blood"] = true

--Wintersaber Rep
L["Rivern Frostwind"] = "Rivern Givrevent"							--*NPC
	L["Frostsaber Provisions"] = "Provisions de sabres-de-givre" 	--*Quest
	L["Winterfall Intrusion"] = "L'incursion des Tombe-hiver"		--*Quest
	L["Rampaging Giants"] = "Géants déchaînés"						--*Quest

--Cooking
L["The Rokk"] = "Le Rokk"									--*NPC
	L["Super Hot Stew"] = "Un ragoût très épicé"			--*Quest
	L["Soup for the Soul"] = "Une soupe pour l'âme"			--*Quest
	L["Revenge is Tasty"] = "La vengeance est un plat…"	--*Quest
	L["Manalicious"] = "Manalicieux"						--*Quest

--Fishing
L["Old Man Barlo"] = "Vieux Barlo"								--*NPC
	L["Crocolisks in the City"] = "Les crocilisques sont lâchés"						--*Quest
	-- L["Bait Bandits"] = true						--*Quest
	-- L["Felblood Fillet"] = true					--*Quest
	--L["Shrimpin' Ain't Easy"] = "Les crevettes, c’est pas pour les mauviettes"					--*Quest
	--L["The One That Got Away"] = "Celui qui s’échappa"							--*Quest

--Non-Heroic Instances
L["Nether-Stalker Mah'duun"] = "Traqueur-du-Néant Mah'duun"										--*NPC
	L["Wanted: Arcatraz Sentinels"] = "On recherche : Des sentinelles de l'Arcatraz"			--*Quest
	L["Wanted: Coilfang Myrmidons"] = "On recherche : Des myrmidons de Glissecroc"				--*Quest
	L["Wanted: Malicious Instructors"] = "On recherche : Des instructrices malveillantes"		--*Quest
	L["Wanted: Rift Lords"] = "On recherche : Des seigneurs des failles"						--*Quest
	L["Wanted: Shattered Hand Centurions"] = "On recherche : Des centurions de la Main brisée"	--*Quest
	L["Wanted: Sunseeker Channelers"] = "On recherche : Des canalistes Cherche-soleil"			--*Quest
	L["Wanted: Tempest-Forge Destroyers"] = "On recherche : Des destructeurs Forge-tempête"		--*Quest

--Names...		These lines are used for display in the gui to shorten the idea of what the quest is.
	L["Arcatraz Sentinels"] = "Sentinelles de l'Arcatraz"
	L["Coilfang Myrmidons"] = "Myrmidons de Glissecroc"
	L["Malicious Instructors"] = "Instructrices Malveillantes"
	L["Rift Lords"] = "Seigneurs des Failles"
	L["Shattered Hand Centurions"] = "Centurions de la Main brisée"
	L["Sunseeker Channelers"] = "Canalistes Cherche-soleil"
	L["Tempest-Forge Destroyers"] = "Destructeurs Forge-tempête"

--Heroic Instances
L["Wind Trader Zhareem"] = "Marchand des vents Zhareem"												--*NPC
	L["Wanted: A Black Stalker Egg"] = "On recherche : Un œuf de traqueuse noire"					--*Quest
	L["Wanted: A Warp Splinter Clipping"] = "On recherche : Une rognure de Brise-dimension"			--*Quest
	L["Wanted: Aeonus's Hourglass"] = "On recherche : Le sablier d'Aeonus"							--*Quest
	L["Wanted: Bladefist's Seal"] = "On recherche : Le sceau de Lamepoing"							--*Quest
	L["Wanted: Keli'dan's Feathered Stave"] = "On recherche : Le bâton à plumes de Keli'dan"		--*Quest
	L["Wanted: Murmur's Whisper"] = "On recherche : Le murmure de Marmon"							--*Quest
	L["Wanted: Nazan's Riding Crop"] = "On recherche : La cravache de Nazan"						--*Quest
	L["Wanted: Pathaleon's Projector"] = "On recherche : Le projecteur de Pathaleon"				--*Quest
	L["Wanted: Shaffar's Wondrous Pendant"] = "On recherche : L'amulette merveilleuse de Shaffar"	--*Quest
	L["Wanted: The Epoch Hunter's Head"] = "On recherche : La tête du chasseur d'époques"			--*Quest
	L["Wanted: The Exarch's Soul Gem"] = "On recherche : La gemme d'âme de l'exarque"				--*Quest
	L["Wanted: The Headfeathers of Ikiss"] = "On recherche : Le panache d'Ikiss"					--*Quest
	L["Wanted: The Heart of Quagmirran"] = "On recherche : Le cœur de Bourbierreux"				--*Quest
	L["Wanted: The Scroll of Skyriss"] = "On recherche : Le parchemin de Cieuriss"					--*Quest
	L["Wanted: The Warlord's Treatise"] = "On recherche : Le traité du seigneur de guerre"			--*Quest
--Names...		These lines are used for display in the gui to shorten the idea of what the quest is.

	L["A Black Stalker Egg"] = "Un œuf de traqueuse noire"
	L["A Warp Splinter Clipping"] = "Une rognure de Brise-dimension"
	L["Aeonus's Hourglass"] = "Le sablier d'Aeonus"
	L["Bladefist's Seal"] = "Le sceau de Lamepoing"
	L["Keli'dan's Feathered Stave"] = "Le bâton à plumes de Keli'dan"
	L["Murmur's Whisper"] = "Le murmure de Marmon"
	L["Nazan's Riding Crop"] = "La cravache de Nazan"
	L["Pathaleon's Projector"] = "Le projecteur de Pathaleon"
	L["Shaffar's Wondrous Pendant"] = "L'amulette merveilleuse de Shaffar"
	L["The Epoch Hunter's Head"] = "La tête du chasseur d'époques"
	L["The Exarch's Soul Gem"] = "La gemme d'âme de l'exarque"
	L["The Headfeathers of Ikiss"] = "Le panache d'Ikiss"
	L["The Heart of Quagmirran"] = "Le cœur de Bourbierreux"
	L["The Scroll of Skyriss"] = "Le parchemin de Cieuriss"
	L["The Warlord's Treatise"] = "Le traité du seigneur de guerre"

--PvP
L["Alliance Brigadier General"] = "Général de brigade de l'Alliance"				--*NPC
L["Horde Warbringer"] = "Porteguerre de la Horde"									--*NPC
	L["Call to Arms: Alterac Valley"] = "Appel aux armes : vallée d'Alterac"		--*Quest
	L["Call to Arms: Arathi Basin"] = "Appel aux armes : bassin d'Arathi"			--*Quest
	L["Call to Arms: Eye of the Storm"] = "Appel aux armes : Œil du cyclone"		--*Quest
	L["Call to Arms: Warsong Gulch"] = "Appel aux armes : goulet des Chanteguerres"	--*Quest
L["Warrant Officer Tracy Proudwell"] = "Adjudante Tracy Fièrepuits"					--*NPC
L["Battlecryer Blackeye"] = "Crieur-de-guerre Coquard"								--*NPC
	L["Hellfire Fortifications"] = "Les fortifications des Flammes infernales"		--*Quest
-- L["Exorcist Sullivan"] = true						--*NPC
-- L["Exorcist Vaisha"] = true							--*NPC
	-- L["Spirits of Auchindoun"] = true				--Quest
-- L["Karrtog"] = true									--*NPC
	-- L["Enemies, Old and New"] = true				--Quest
-- L["Lakoor"] = true									--*NPC
	-- L["In Defense of Halaa"] = true					--Quest

-- Options Table Locale
--General Titles
L["Sick Of Clicking Dailies?"] = "Sick Of Clicking Dailies?"  ---- Addon Name used for Options table
L["NPC & Quest Options"] = "Options des PNJ et quêtes"
L["NPC Enabled"] = "PNJ actifs"
L["Addon Options"] = "Options de l'addon"
L["Enabled"] = "Activer"
L["Enable Quest"] = "Activer la quête"
L["Quest Reward"] = "Récompense de quête"
L["None"] = "Aucune"

L["Always Loop NPCs"] = "Toujours cycler sur les PNJ"
L["Always Loop on the NPC from one quest to the next forever"] = "Cycle continuellement entre les différentes quêtes d'un PNJ"
L["Enable Gossip window"] = "Activer la fenêtre de bavardage"
L["Enable skipping the opening gossip text"] = "Activer le saut du bavardage"
L["Enable Quest Text window"] = "Activer la fenêtre de description de la quête"
L["Enable skipping the Quest Descriptive text"] = "Activer le saut de la description de la quête"
L["Enable Completion Gossip"] = "Activer l'acquiessement du bavardage"
L["Enable skipping the Quest Completion question text"] = "Activer le saut du texte finalisant la quête"
L["Enable Quest Turn In"] = "Activer le rendu des quêtes"
L["Enable skipping the actual turn in of the quest"] = "Activer le saut du rendu de la quête choisie"

--Titles
L["Faction Grinds"] = "Monter les factions"
	L["Skyguard"] = "Garde-ciel"
		L["Blades Edge Mountains"] = "Les Tranchantes"
		L["Skettis"] = "Skettis"
	L["Ogri'la"] = "Ogri'la"
	L["Netherwing"] = "Aile-du-Néant"
		L["Netherwing - Neutral"] = "Aile-du-Néant - Neutre"
		L["Netherwing - Friendly"] = "Aile-du-Néant - Amical"
		L["Netherwing - Honored"] = "Aile-du-Néant - Honoré"
		L["Netherwing - Revered"] = "Aile-du-Néant - Révéré"
	L["Shattered Sun Offensive"] = "Opération Soleil brisé"
	L["Wintersaber Trainer"] = "Éleveur de sabres-d'hiver"

L["PvP"] = "JcJ"
	L["Horde PvP"] = "JcJ Horde"
	L["Alliance PvP"] = "JcJ Alliance"
	L["Battlegrounds"] = "Champs-de-batailles"
	L["World PvP"] = "JcJ ouvert"

L["Instance"] = "Instance"
	L["Instance - Normal"] = "Instance - Normal"
	L["Instance - Heroic"] = "Instance - Héroïque"
		L["The Eye"] = "L'Oeil - Donjon de la tempête"
		L["Serpentshrine Cavern"] = "Caverne du sanctuaire du serpent"
		L["Hellfire Citadel"] = "Citadelle des flammes infernales"
		L["Caverns of Time"] = "Les Grottes du temps"
		L["Auchindoun"] = "Auchindoun"

L["Cooking"] = "Cuisine"
L["Fishing"] = "Pêche"
L["Profession"] = "Profession"

--Special Tool Tips
L["This will toggle the quest on both Doryn and the Prisoner"] = "Ceci activera les quêtes de Doryn et du prisonnier"
L["|cffFF0000WARNING!!!|r, This Option also toggles both Scryer and Aldor Quests"] = "|cffFF0000ATTENTION !!!|r, Cette option activera aussi les quêtes pour l'Aldor ET les Clairevoyants"  ---Warning Color Code included in this string
L["\nAll Non-Heroic Quests are from |cff00ff00'Nether-Stalker Mah'duun'|r in LowerCity"] = "\nToutes les quêtes non-héroïque se prennent auprès du |cff00ff00'Traqueur-du-Néant Mah'duun'|r dans la Ville-Basse"
L["\nAll Heroic Dailies from |cff00ff00'Wind Trader Zhareem'|r in LowerCity"] = "\nToutes les quêtes héroïques journalières se prennent auprès du |cff00ff00'Marchand des vents Zhareem'|r dans la Ville-Basse"

--Quest Options

L["Select what Potion you want for the 'Escape from Skettis' quest"] = "Sélectionnez le type de potion que vous voulez en récompense de la quête 'L'évasion de Skettis'"
L["Health Potion"] = "Potion de soin"
L["Mana Potion"] = "Poton de Mana"
L["Barrel of Fish"] = "Tonneau de poissons"
L["Crate of Meat"] = "Caisse de viande"

end
