--
--	General Localizations here
--
--	frFR Translation by Cinedelle

local L = LibStub("AceLocale-3.0"):NewLocale("SOCD_Core", "frFR", false)
if not L then return end

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
	L["Horde"] = FACTION_HORDE
	L["Alliance"] = FACTION_ALLIANCE
	
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
	L["Jewelcrafting"] = "Joaillerie"
	
		--LichKing
	L["LK"] = "Lich King"
		--Factions
	L["The Wyrmrest Accord"] = "L'Accord de Repos du ver"
	L["Sholazar Basin"] = "Bassin de Sholazar"
	L["The Oracles"] = "Les Oracles"
	L["Frenzyheart Tribe"] = "Tribu Frénécœur"
	L["The Sons of Hodir"] = "Les Fils de Hodir"
	L["Argent Crusade"] = "La Croisade d'argent"
	L["Knights of the Ebon Blade"] = "Chevaliers de la Lame d'ébène"
	L["The Kalu'ak"] = "Les Kalu'aks"
	L["The Storm Peaks"] = "Les pics Foudroyés"
	L["The Frostborn"] = "Les Givre-nés"

		--Misc Titles
	L["Shared Faction Quests"] = "Quêtes communes aux factions"
	L["Icecrown"] = "La Couronne de glace"
	L["Grizzly Hills"] = "Les Grisonnes"
	L["Wintergrasp"] = "Joug-d'hiver"
	L["Shared Quests"] = "Quêtes communes"
	L["Icecrown Netural Quests"] = "Quêtes de la Couronne de glace neutre"
	L["Troll Patrol: "] = "Patrouille anti-trolls : "	--There is a space at the end, this is used to clip ugly quests.
	L["Shipment: "] = "Livraison : "	--There is also a space at the end of here..
	L["Proof of Demise: "] = "Preuve de la mort : "
	L["Timear Foresees (.+) in your Future!"] = "Timear prédit (.+) dans votre avenir !"	--regex leave the (.+) in the middle there.
	L["Faction Token"] = "Jeton de faction"
	
	
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
	--Instance Dailies
	LK["All Things in Good Time"] = "Tout vient à point…"
		--Heroics
	LK["Proof of Demise: Anub'arak"] = "Preuve de la mort d'Anub'arak"
	LK["Proof of Demise: Cyanigosa"] = "Preuve de la mort de Cyanigosa"
	LK["Proof of Demise: Gal'darah"] = "Preuve de la mort de Gal'darah"
	LK["Proof of Demise: Herald Volazj"] = "Preuve de la mort du héraut Volazj"
	LK["Proof of Demise: Ingvar the Plunderer"] = "Preuve de la mort d'Ingvar le Pilleur"
	LK["Proof of Demise: Keristrasza"] = "Preuve de la mort de Keristrasza"
	LK["Proof of Demise: King Ymiron"] = "Preuve de la mort du roi Ymiron"
	LK["Proof of Demise: Ley-Guardian Eregos"] = "Preuve de la mort du gardien-tellurique Eregos"
	LK["Proof of Demise: Loken"] = "Preuve de la mort de Loken"
	LK["Proof of Demise: Mal'Ganis"] = "Preuve de la mort de Mal'Ganis"
	LK["Proof of Demise: Sjonnir The Ironshaper"] = "Preuve de la mort de Sjonnir le Sculptefer"
	LK["Proof of Demise: The Prophet Tharon'ja"] = "Preuve de la mort du prophète Theron'ja"
		--Non Heroics
	LK["Timear Foresees Centrifuge Constructs in your Future!"] = "Timear prédit des assemblages centrifuges dans votre avenir !"
	LK["Timear Foresees Infinite Agents in your Future!"] = "Timear prédit des agents infinis dans votre avenir !"
	LK["Timear Foresees Titanium Vanguards in your Future!"] = "Timear prédit des avant-gardes en titane dans votre avenir !"
	LK["Timear Foresees Ymirjar Berserkers in your Future!"] = "Timear prédit des berserkers ymirjar dans votre avenir !"

	--Professions
		--Cooking
	LK["Cheese for Glowergold"] = "Du fromage pour Froncelor"
	LK["Convention at the Legerdemain"] = "Convention à l'Abracadabar"
	LK["Infused Mushroom Meatloaf"] = "Pain de viande aux champignons infusés"
	LK["Mustard Dogs!"] = "Hot-dogs à la moutarde !"
	LK["Sewer Stew"] = "Le ragoût des égouts"
		--Jewlcrafting
	LK["Shipment: Blood Jade Amulet"] = "Livraison : Amulette en jade de sang"
	LK["Shipment: Bright Armor Relic"] = "Livraison : Relique de l'armure éclatante"
	LK["Shipment: Glowing Ivory Figurine"] = "Livraison : Figurine luminescente en ivoire"
	LK["Shipment: Intricate Bone Figurine"] = "Livraison : Figurine complexe en os"
	LK["Shipment: Shifting Sun Curio"] = "Livraison : Bibelot du soleil changeant"
	LK["Shipment: Wicked Sun Brooch "] = "Livraison : Broche du soleil pernicieux"

	--Factions
		--The Wyrmrest Accord
	LK["Aces High!"] = "Un as dans notre jeu !"
	LK["Drake Hunt"] = "La chasse au drake"
	LK["Defending Wyrmrest Temple"] = "La défense du temple du Repos du ver"

		--The Oracles
	LK["A Cleansing Song"] = "Un chant de purification"
	LK["Appeasing the Great Rain Stone"] = "Un chant de purification"
	LK["Hand of the Oracles"] = "La main des oracles"
	LK["Mastery of the Crystals"] = "La maîtrise des cristaux"
	LK["Power of the Great Ones"] = "Le pouvoir des Tout-puissants"
	LK["Song of Fecundity"] = "Un chant de fécondité"
	LK["Song of Reflection"] = "Un chant de réflexion"
	LK["Song of Wind and Water"] = "Le chant du Vent et de l'Eau"
	LK["Will of the Titans"] = "La volonté des titans"

		--Frenzyheart Tribe
	LK["A Hero's Headgear"] = "Un couvre-chef de héros"
	LK["Chicken Party!"] = "Des poulets et des varleus"
	LK["Frenzyheart Champion"] = "Le champion frénécœur"
	LK["Kartak's Rampage"] = "Le massacre de Kartak"
	LK["Rejek: First Blood"] = "Rejek : le premier sang"
	LK["Secret Strength of the Frenzyheart"] = "La puissance secrète des Frénécœurs"
	LK["Strength of the Tempest"] = "La puissance de la tempête"
	LK["The Heartblood's Strength"] = "La force du sang du coeur"
	LK["Tools of War"] = "De drôle d'outils de guerre"

		--The Sons of Hodir
	LK["Blowing Hodir's Horn"] = "Souffler dans le cor de Hodir"
	LK["Hodir's Horn"] = "Cor de Hodir"	--object Name
	
	LK["Feeding Arngrim"] = "Caler la dent creuse d'Arngrim"
	LK["Arngrim the Insatiable"] = "Arngrim l'Insatiable "	--object Name
	
	LK["Hot and Cold"] = "Chaud et froid"
	LK["Fjorn's Anvil"] = "Enclume de Fjorn"	--object name
	
	
	LK["Polishing the Helm"] = "Polir le heaume"
	LK["Hodir's Helm"] = "Heaume de Hodir"	--object Name
	
	LK["Spy Hunter"] = "À la chasse aux espions"
	
	LK["Thrusting Hodir's Spear"] = "Planter la lance de Hodir"
	LK["Hodir's Spear"] = "Lance de Hodir "	--object Name

		--Argent Crusade
	LK["The Alchemist's Apprentice"] = "L'apprenti alchimiste"
	LK["Troll Patrol"] = "Patrouille anti-trolls"
	LK["Troll Patrol: Can You Dig It?"] = "Patrouille anti-trolls : et que ça creuse !"
	LK["Troll Patrol: Couldn't Care Less"] = "Patrouille anti-trolls : je m'en fiche totalement !"
	LK["Troll Patrol: Creature Comforts"] = "Patrouille anti-trolls : une bonne flambée"
	LK["Troll Patrol: Done to Death"] = "Patrouille anti-trolls : morts incinérés"
	LK["Troll Patrol: High Standards"] = "Patrouille anti-trolls : hissez les étendards !"
	LK["Troll Patrol: Intestinal Fortitude"] = "Patrouille anti-trolls : un peu de courage !"
	LK["Troll Patrol: Something for the Pain"] = "Patrouille anti-trolls : un remède contre la douleur"
	LK["Troll Patrol: The Alchemist's Apprentice"] = "Patrouille anti-trolls : l'apprenti alchimiste"
	LK["Troll Patrol: Throwing Down"] = "Patrouille anti-trolls : attention en dessous !"
	LK["Troll Patrol: Whatdya Want, a Medal?"] = "Patrouille anti-trolls : vous voulez quoi ? Une médaille ?"
	LK["Congratulations!"] = "Félicitations !"

		--Knights of the Ebon Blade
	LK["Intelligence Gathering"] = "Trouver des informations"
	LK["Leave Our Mark"] = "Laisser notre marque"
	LK["No Fly Zone"] = "Zone d'exclusion aérienne"
	LK["From Their Corpses, Rise!"] = "Réanimez leurs cadavres !"
	LK["Shoot 'Em Up"] = "Descendez-les tous !"
	LK["Vile Like Fire!"] = "Vil aime feu !"

		--The Kalu'ak
	LK["Planning for the Future"] = "Préparer l'avenir"
	LK["Preparing for the Worst"] = "Se préparer au pire"
	LK["The Way to His Heart..."] = "Le chemin de son cœur…"

		--The Frostborn
	LK["Pushed Too Far"] = "Trop loin"

	----Horde Expedition / --Alliance Vanguard
		--These are shared quests for the given zone
		--IceCrown
	LK["King of the Mountain"] = "Roi de la montagne"	--Netural
	LK["Blood of the Chosen"] = "Le sang des Élus"	--Netural
	LK["Drag and Drop"] = "Attraper et lâcher"	--Netural
	LK["Neutralizing the Plague"] = "Neutraliser la peste"	--Netural
	LK["No Rest For The Wicked"] = "Pas de repos pour le malfaisant"	--Netural
	LK["Not a Bug"] = "Il n'est pas nuisible"	--Netural
	LK["Retest Now"] = "Testez-le à nouveau"	--Netural
	LK["Slaves to Saronite"] = "Esclaves de la saronite"	--Netural
	LK["That's Abominable!"] = "C'est abominable !"	--Netural
	LK["Static Shock Troops: the Bombardment"] = "Troupe de choc statique : le Bombardement"	--Alliance
	LK["Total Ohmage: The Valley of Lost Hope!"] = "Ohmage total : la vallée de l'Espoir perdu !"	--Horde
	LK["The Solution Solution"] = "La solution pour la solution"	--Alliance
	LK["Volatility"] = "Volatilité"	--Horde
	LK["Capture More Dispatches"] = "Récupérez plus de dépêches"	--Alliance
	LK["Keeping the Alliance Blind"] = "Que l'Alliance reste aveugle"	--Horde
	LK["Putting the Hertz: The Valley of Lost Hope"] = "Objectif Killo : la vallée de l'Espoir perdu"	--Alliance
	LK["Riding the Wavelength: The Bombardment"] = "Profiter de l'onde : le Bombardement"	--Horde

		--Grizzly Hills
	LK["Life or Death"] = "La vie ou la mort"	--Alliance
	LK["Overwhelmed!"] = "Débordée !"	--Horde
	LK["Making Repairs"] = "Procéder aux réparations"	--Horde
	LK["Pieces Parts"] = "Pour quelques bouts de ferraille de plus…"	--Alliance
	LK["Keep Them at Bay"] = "Ra-baie-ssez l'ennemi"	--Netural
	LK["Riding the Red Rocket"] = "À cheval sur la fusée…"	--Netural
	LK["Seared Scourge"] = "Fléau flambé"	--Netural
	LK["Smoke 'Em Out"] = "Enfumez-les"	--Netural
	
		--The Storm Peaks
	LK["Back to the Pit"] = "Retour dans la fosse"
	LK["Defending Your Title"] = "Défendre votre titre"
	LK["Overstock"] = "Surplus"
	LK["Maintaining Discipline"] = "Maintenir la discipline"
	LK["The Aberrations Must Die"] = "Les aberrations doivent mourir"


		--World PvP
		--These Quests Specificlally flag you as PvP Active
		--Wintergrasp Fortress
	LK["A Rare Herb"] = "Une herbe rare"
	LK["Bones and Arrows"] = "Des os et des flèches"
	LK["Defend the Siege"] = "La défense du siège"
	LK["Fueling the Demolishers"] = "Alimenter les démolisseurs"
	LK["Healing with Roses"] = "Guérison par les plantes"
	LK["Jinxing the Walls"] = "Ensorceler les murs"
	LK["No Mercy for the Merciless"] = "Pas de pitié pour les sans pitié"
	LK["Slay them all"] = "Tuez-les tous !"
	LK["Stop the Siege"] = "L'arrêt du siège"
	LK["Victory in Wintergrasp"] = "Victoire à Joug-d'hiver"
	LK["Warding the Walls"] = "Surveiller les murs"
	LK["Warding the Warriors"] = "Protéger les guerriers"

		--BattleGround
	LK["Call to Arms: Strand of the Ancients"] = "Appel aux armes : rivage des Anciens"

		--IceCrown
	LK["Make Them Pay!"] = "Faites-les payer !"	--Horde
	LK["Shred the Alliance"] = "Déchiquetez l'Alliance"	--Horde
	LK["No Mercy!"] = "Pas de pitié !"	--Allaince
	LK["Shredder Repair"] = "Réparation de déchiqueteurs"	--Alliance

		--Grizzly Hills
	LK["Keep Them at Bay"] = "Ra-baie-ssez l'ennemi"	--Netural
	LK["Riding the Red Rocket"] = "À cheval sur la fusée…"	--Netural
	LK["Seared Scourge"] = "Fléau flambé"	--Netural
	LK["Smoke 'Em Out"] = "Enfumez-les"	--Netural

	LK["Down With Captain Zorna!"] = "Mort au capitaine Zorna !"	--Alliance
	LK["Kick 'Em While They're Down"] = "Frappez-les tant qu'ils sont à terre"	--Alliance
	LK["Blackriver Skirmish"] = "Escarmouches sur la rivière Noire"	--Alliance

	LK["Crush Captain Brightwater!"] = "Abattez le capitaine Brilleflot !"	--Horde
	LK["Keep 'Em on Their Heels"] = "Mettez-les sur les dents"	--Horde
	LK["Blackriver Brawl"] = "Baston sur la rivière Noire"	--Horde


	--Misc
		--Howling Fjord
	LK["Break the Blockade"] = "Forcer le blocus"	--Alliance
	LK["Steel Gate Patrol"] = "Patrouille à la Porte d'acier"	--Alliance

end
