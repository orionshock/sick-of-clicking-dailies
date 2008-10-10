--
--	General Localizations here
--

local L = LibStub("AceLocale-3.0"):NewLocale("SOCD_Core", "frFR", false)

if L then
	L["Sick Of Clicking Dailies"] = "Sick Of Clicking Dailies"
	L["Module Control"] = "Contrôle des modules"
	L["PvP"] = PVP
	L["World PvP"] = "JcJ Mondial"
	L["Battlegrounds"] = BATTLEFIELDS
	L["Netural"] = FACTION_STANDING_LABEL4
	L["Friendly"] = FACTION_STANDING_LABEL5
	L["Honored"] = FACTION_STANDING_LABEL6
	L["Revered"] = FACTION_STANDING_LABEL7
	L["Faction"] = FACTION
	L["None"] = LFG_TYPE_NONE
	L["Quest Rewards"] = "Récompenses de quêtes"
	L["Quests"] = QUESTS_LABEL
	L["Wanted: "] = "On recherche : "		--Used in Instance quest for dsplay...
	

	--Classic Section
	L["Classic WoW"] = "WoW Classique"
	L["Wintersaber Trainers"] = "Éleveur de sabres-d'hiver"


	--BC Section
	L["Burning Crusade"] = "Burning Crusade"
		--Instances		Might include instance soft names here, but that would break some automagic stuff
	L["Instances"] = "Instances"
	L["Heroic Instances"] = "Instance Héroïque"
		--Factions
	L["Sha'tari Skyguard"] = "Garde-ciel Sha'tari"
	L["Og'rila"] = "Og'rila"
	L["Netherwing"] = "Aile-du-Néant"
			--SSO
	L["Shattered Sun Offensive"] = "Opération Soleil Brisé"
	L["SSO Phase 1"] = "La prise du Sanctum des Confins du Soleil"
	L["SSO Phase 2a"] = "La prise de l'armurerie des Confins du Soleil"
	L["SSO Phase 2b"] = "Portail du Puit du Soleil"
	L["SSO Phase 3a"] = "La prise du Port des Confins du Soleil"
	L["SSO Phase 3b"] = "La prise de la Forge des Confins du Soleil"
	L["SSO Phase 4a"] = "Labo D'alchimie"
	L["SSO Phase 4b"] = "Mémorial"
	L["SSO Phase 4c"] = "Finale"
	L["SSO_MISC"] = "OSB Quêtes diverses"
		--Professions
	L["Professions"] = TRADE_SKILLS
	L["Cooking"] = "Cuisine"
	L["Fishing"] = "Pêche"
end

--All Quests Classified by orgin / content location
--
--	Classic
--
--
local C = LibStub("AceLocale-3.0"):NewLocale("SOCD_Classic", "frFR", false)

if C then
--Wintersaber Trainer
	C["Frostsaber Provisions"] = "Provisions de sabres-de-givre"
	C["Winterfall Intrusion"] = "L'incursion des Tombe-hiver"
	C["Rampaging Giants"] = "Géants déchaînés"

--PvP
	C["Call to Arms: Warsong Gulch"] = "Appel aux armes : goulet des Chanteguerres"
	C["Call to Arms: Arathi Basin"] = "Appel aux armes : bassin d'Arathi"
	C["Call to Arms: Alterac Valley"] = "Appel aux armes : vallée d'Alterac"
end


--
--	TBC
--	

local BC = LibStub("AceLocale-3.0"):NewLocale("SOCD_BC", "frFR", false)

if BC then
--Skettis Dailies
	BC["Fires Over Skettis"] = "Un déluge de feu sur Skettis"
	BC["Escape from Skettis"] = "L'évasion de Skettis"

--Blade's Edge Mountains
	BC["Wrangle More Aether Rays!"] = "Allez dompter d’autres raies de l’éther !"
	BC["Bomb Them Again!"] = "Bombardez-les encore !"
	BC["The Relic's Emanation"] = "Les émanations des reliques"
	BC["Banish More Demons"] = "Bannissez plus de démons"
--Netherwing
	--Netrual
	BC["Nethercite Ore"] = "Du minerai de néanticite"
	BC["Netherdust Pollen"] = "Du pollen de pruinéante"
	BC["Nethermine Flayer Hide"] = "Des peaux d'écorcheurs mine-néant"
	BC["Netherwing Crystals"] = "Les cristaux de l'Aile-du-Néant"
	BC["The Not-So-Friendly Skies..."] = "Les cieux pas si cléments…"
	BC["A Slow Death"] = "Une mort lente"
	--Friendly
	BC["Picking Up The Pieces..."] = "Ramasser les morceaux…"
	BC["Dragons are the Least of Our Problems"] = "Les dragons sont les derniers de nos soucis"
	BC["The Booterang: A Cure For The Common Worthless Peon"] = "Le botterang : un traitement pour les péons bons à rien"
	--Honored
	BC["Disrupting the Twilight Portal"] = "Perturber la Porte du crépuscule"
	--Revered
	BC["The Deadliest Trap Ever Laid"] = "Le plus mortel des pièges"

--Shattered Sun Offensive
	--P1
	BC["Erratic Behavior"] = "Comportement erratique"
	BC["The Sanctum Wards"] = "Les protections du sanctum"
	--P2a
	BC["Further Conversions"] = "Plus de conversions"	--Final for "Erratic Behavior"
	BC["Arm the Wards!"] = "Armez les protections !"		--Final for "The Sanctum Wards"
	BC["The Battle for the Sun's Reach Armory"] = "La bataille pour l'Armurerie des Confins du soleil"
	BC["Distraction at the Dead Scar"] = "Diversion à la Malebrèche"
	BC["Intercepting the Mana Cells"] = "Intercepter des cellules de mana"
	--P2b
	BC["Maintaining the Sunwell Portal"] = "Maintenir le portail du Puits de soleil"		--Final for "Intercepting the Mana Cells"
	BC["Know Your Ley Lines"] = "Les lignes telluriques et vous"
	--P3a
	BC["The Battle Must Go On"] = "La bataille doit continuer"	--Final for "Battle for Sun's Reach Armory"
	BC["The Air Strikes Must Continue"] = "Les frappes aériennes doivent continuer"		--Final for "Distraction at the Dad Scar"
	BC["Intercept the Reinforcements"] = "Intercepter les renforts"
	BC["Taking the Harbor"] = "Prendre le port"
	BC["Making Ready"] = "Préparatifs"
	--P3b
	BC["Don't Stop Now...."] = "Ne vous arrêtez pas…"		--Final for "Making Ready"
	BC["Ata'mal Armaments"] = "Les armes d'Ata'mal"
	--P4a
	BC["Keeping the Enemy at Bay"] = "Tenir l'ennemi à distance"		--Final for "Intercept the Reinforcements"
	BC["Crush the Dawnblade"] = "Écraser la Lame de l'aube"		--Final for "Taking the Harbor"
	BC["Discovering Your Roots"] = "À la découverte de vos racines"
	BC["A Charitable Donation"] = "Un don charitable"
	BC["Disrupt the Greengill Coast"] = "Déstabilisation de la Côte de Verte-branchie"
	--P4b
	BC["Your Continued Support"] = "Votre soutien indéfectible"		--FInal for "A Charitable Donation"
	--P4c
	BC["Rediscovering Your Roots"] = "À la redécouverte de vos racines"		--Final for "Discovering Your Roots"
	BC["Open for Business"] = "On est ouverts"
	---Misc SSO Quests for Outland
	BC["The Multiphase Survey"] = "L’examen multiphase"
	BC["Blood for Blood"] = "Sang pour sang"
	BC["Blast the Gateway"] = "Détruire la porte"
	BC["Sunfury Attack Plans"] = "Les plans d'attaque solfurie"
	BC["Gaining the Advantage"] = "Prendre l'avantage"


--Professions - Cooking
	BC["Super Hot Stew"] = "Un ragoût très épicé"
	BC["Soup for the Soul"] = "Une soupe pour l'âme"
	BC["Revenge is Tasty"] = "La vengeance est un plat…"
	BC["Manalicious"] = "Manalicieux"

--Professions - Fishing
	BC["Crocolisks in the City"] = "Les crocilisques sont lâchés"
	BC["Bait Bandits"] = "Succomber à vos appâts"
	BC["Felblood Fillet"] = "Filet de gangresang"
	BC["Shrimpin' Ain't Easy"] = "Les crevettes, c’est pas pour les mauviettes"
	BC["The One That Got Away"] = "Celui qui s'échappa"

---Non Heroic Instance
	BC["Wanted: Arcatraz Sentinels"] = "On recherche : Des sentinelles de l'Arcatraz"
	BC["Wanted: Coilfang Myrmidons"] = "On recherche : Des myrmidons de Glissecroc"
	BC["Wanted: Malicious Instructors"] = "On recherche : Des instructrices malveillantes"
	BC["Wanted: Rift Lords"] = "On recherche : Des seigneurs des failles"
	BC["Wanted: Shattered Hand Centurions"] = "On recherche : Des centurions de la Main brisée"
	BC["Wanted: Sunseeker Channelers"] = "On recherche : Des canalistes Cherche-soleil"
	BC["Wanted: Tempest-Forge Destroyers"] = "On recherche : Des destructeurs Forge-tempête"
	BC["Wanted: Sisters of Torment"] = "On recherche : les sœurs du tourment"

--Heroic Instance	
	BC["Wanted: A Black Stalker Egg"] = "On recherche : Un œuf de traqueuse noire"
	BC["Wanted: A Warp Splinter Clipping"] = "On recherche : Une rognure de Brise-dimension"
	BC["Wanted: Aeonus's Hourglass"] = "On recherche : Le sablier d'Aeonus"
	BC["Wanted: Bladefist's Seal"] = "On recherche : Le sceau de Lamepoing"
	BC["Wanted: Keli'dan's Feathered Stave"] = "On recherche : Le bâton à plumes de Keli'dan"
	BC["Wanted: Murmur's Whisper"] = "On recherche : Le murmure de Marmon"
	BC["Wanted: Nazan's Riding Crop"] = "On recherche : La cravache de Nazan"
	BC["Wanted: Pathaleon's Projector"] = "On recherche : Le projecteur de Pathaleon"
	BC["Wanted: Shaffar's Wondrous Pendant"] = "On recherche : L'amulette merveilleuse de Shaffar"
	BC["Wanted: The Epoch Hunter's Head"] = "On recherche : La tête du chasseur d'époques"
	BC["Wanted: The Exarch's Soul Gem"] = "On recherche : La gemme d'âme de l'exarque"
	BC["Wanted: The Headfeathers of Ikiss"] = "On recherche : Le panache d'Ikiss"
	BC["Wanted: The Heart of Quagmirran"] = "On recherche : Le cœur de Bourbierreux"
	BC["Wanted: The Scroll of Skyriss"] = "On recherche : Le parchemin de Cieuriss"
	BC["Wanted: The Warlord's Treatise"] = "On recherche : Le traité du seigneur de guerre"
	BC["Wanted: The Signet Ring of Prince Kael'thas"] = "On recherche : La chevalière du prince Kael'thas"
--PvP
	----World PvP
	--HellFire
	BC["Hellfire Fortifications"] = "Les fortifications des Flammes infernales"
	--Auchindoun
	BC["Spirits of Auchindoun"] = "Les esprits d'Auchindoun"
	--Nagrand / Halla
	BC["Enemies, Old and New"] = "Ennemis, anciens et nouveaux"	--Horde
	BC["In Defense of Halaa"] = "La défense de Halaa"	--Alliance
	----Battlegrounds
	BC["Call to Arms: Eye of the Storm"] = "Appel aux armes : Œil du cyclone"
end


--
--	WOTLK
--	
local LK = LibStub("AceLocale-3.0"):NewLocale("SOCD_LK", "frFR", false)

if LK then
	LK["test"] = "test"
end




