
local L = LibStub("AceLocale-3.0"):NewLocale("SOCD_Core", "enUS", true)

--
--	General Localizations here
--
	L["Sick Of Clicking Dailies"] = true
	L["Module Control"] = true
	L["PvP"] = PVP
	L["World PvP"] = true
	L["Battlegrounds"] = BATTLEFIELDS
	L["Netural"] = FACTION_STANDING_LABEL4
	L["Friendly"] = FACTION_STANDING_LABEL5
	L["Honored"] = FACTION_STANDING_LABEL6
	L["Revered"] = FACTION_STANDING_LABEL7
	L["Faction"] = FACTION
	L["None"] = LFG_TYPE_NONE
	L["Quest Rewards"] = true
	L["Quests"] = QUESTS_LABEL
	L["Wanted: "] = true		--Used in Instance quest for dsplay...
	

	--Classic Section
	L["Classic WoW"] = true
	L["Wintersaber Trainers"] = true


	--BC Section
	L["Burning Crusade"] = true
		--Instances		Might include instance soft names here, but that would break some automagic stuff
	L["Instances"] = true
	L["Heroic Instances"] = true
		--Factions
	L["Sha'tari Skyguard"] = true
	L["Og'rila"] = true
	L["Netherwing"] = true
			--SSO
	L["Shattered Sun Offensive"] = true
	L["SSO Phase 1"] = "Sun's Reach Sanctum"
	L["SSO Phase 2a"] = "Sun's Reach Armory"
	L["SSO Phase 2b"] = "Sunwell Portal"
	L["SSO Phase 3a"] = "Sun's Reach Harbor"
	L["SSO Phase 3b"] = "Sun's Reach Anvil"
	L["SSO Phase 4a"] = "Alchemy Lab"
	L["SSO Phase 4b"] = "Memorial"
	L["SSO Phase 4c"] = "Final"
	L["SSO_MISC"] = "SSO Misc. Quests"
		--Professions
	L["Professions"] = TRADE_SKILLS
	L["Cooking"] = true
	L["Fishing"] = true
	

--All Quests Classified by orgin / content location
local C = LibStub("AceLocale-3.0"):NewLocale("SOCD_Classic", "enUS", true)

--
--	Classic
--
--

--Wintersaber Trainer
	C["Frostsaber Provisions"] = true
	C["Winterfall Intrusion"] = true
	C["Rampaging Giants"] = true

--PvP
	C["Call to Arms: Warsong Gulch"] = true
	C["Call to Arms: Arathi Basin"] = true
	C["Call to Arms: Alterac Valley"] = true
	


--
--	TBC
--	
local BC = LibStub("AceLocale-3.0"):NewLocale("SOCD_BC", "enUS", true)
--Skettis Dailies
	BC["Fires Over Skettis"] = true
	BC["Escape from Skettis"] = true

--Blade's Edge Mountains
	BC["Wrangle More Aether Rays!"] = true
	BC["Bomb Them Again!"] = true
	BC["The Relic's Emanation"] = true
	BC["Banish More Demons"] = true
--Netherwing
	--Netrual
	BC["Nethercite Ore"] = true
	BC["Netherdust Pollen"] = true
	BC["Nethermine Flayer Hide"] = true
	BC["Netherwing Crystals"] = true
	BC["The Not-So-Friendly Skies..."] = true
	BC["A Slow Death"] = true
	--Friendly
	BC["Picking Up The Pieces..."] = true
	BC["Dragons are the Least of Our Problems"] = true
	BC["The Booterang: A Cure For The Common Worthless Peon"] = true
	--Honored
	BC["Disrupting the Twilight Portal"] = true
	--Revered
	BC["The Deadliest Trap Ever Laid"] = true

--Shattered Sun Offensive
	--P1
	BC["Erratic Behavior"] = true
	BC["The Sanctum Wards"] = true
	--P2a
	BC["Further Conversions"] = true	--Final for "Erratic Behavior"
	BC["Arm the Wards!"] = true		--Final for "The Sanctum Wards"
	BC["The Battle for the Sun's Reach Armory"] = true
	BC["Distraction at the Dead Scar"] = true
	BC["Intercepting the Mana Cells"] = true
	--P2b
	BC["Maintaining the Sunwell Portal"] = true		--Final for "Intercepting the Mana Cells"
	BC["Know Your Ley Lines"] = true
	--P3a
	BC["The Battle Must Go On"] = true	--Final for "Battle for Sun's Reach Armory"
	BC["The Air Strikes Must Continue"] = true		--Final for "Distraction at the Dad Scar"
	BC["Intercept the Reinforcements"] = true
	BC["Taking the Harbor"] = true
	BC["Making Ready"] = true
	--P3b
	BC["Don't Stop Now...."] = true		--Final for "Making Ready"
	BC["Ata'mal Armaments"] = true
	--P4a
	BC["Keeping the Enemy at Bay"] = true		--Final for "Intercept the Reinforcements"
	BC["Crush the Dawnblade"] = true		--Final for "Taking the Harbor"
	BC["Discovering Your Roots"] = true
	BC["A Charitable Donation"] = true
	BC["Disrupt the Greengill Coast"] = true
	--P4b
	BC["Your Continued Support"] = true		--FInal for "A Charitable Donation"
	--P4c
	BC["Rediscovering Your Roots"] = true		--Final for "Discovering Your Roots"
	BC["Open for Business"] = true
	---Misc SSO Quests for Outland
	BC["The Multiphase Survey"] = true
	BC["Blood for Blood"] = true
	BC["Blast the Gateway"] = true
	BC["Sunfury Attack Plans"] = true
	BC["Gaining the Advantage"] = true


--Professions - Cooking
	BC["Super Hot Stew"] = true
	BC["Soup for the Soul"] = true
	BC["Revenge is Tasty"] = true
	BC["Manalicious"] = true

--Professions - Fishing
	BC["Crocolisks in the City"] = true
	BC["Bait Bandits"] = true
	BC["Felblood Fillet"] = true
	BC["Shrimpin' Ain't Easy"] = true
	BC["The One That Got Away"] = true

---Non Heroic Instance
	BC["Wanted: Arcatraz Sentinels"] = true
	BC["Wanted: Coilfang Myrmidons"] = true
	BC["Wanted: Malicious Instructors"] = true
	BC["Wanted: Rift Lords"] = true
	BC["Wanted: Shattered Hand Centurions"] = true
	BC["Wanted: Sunseeker Channelers"] = true
	BC["Wanted: Tempest-Forge Destroyers"] = true
	BC["Wanted: Sisters of Torment"] = true

--Heroic Instance	
	BC["Wanted: A Black Stalker Egg"] = true
	BC["Wanted: A Warp Splinter Clipping"] = true
	BC["Wanted: Aeonus's Hourglass"] = true
	BC["Wanted: Bladefist's Seal"] = true
	BC["Wanted: Keli'dan's Feathered Stave"] = true
	BC["Wanted: Murmur's Whisper"] = true
	BC["Wanted: Nazan's Riding Crop"] = true
	BC["Wanted: Pathaleon's Projector"] = true
	BC["Wanted: Shaffar's Wondrous Pendant"] = true
	BC["Wanted: The Epoch Hunter's Head"] = true
	BC["Wanted: The Exarch's Soul Gem"] = true
	BC["Wanted: The Headfeathers of Ikiss"] = true
	BC["Wanted: The Heart of Quagmirran"] = true
	BC["Wanted: The Scroll of Skyriss"] = true
	BC["Wanted: The Warlord's Treatise"] = true
	BC["Wanted: The Signet Ring of Prince Kael'thas"] = true
--PvP
	----World PvP
	--HellFire
	BC["Hellfire Fortifications"] = true
	--Auchindoun
	BC["Spirits of Auchindoun"] = true
	--Nagrand / Halla
	BC["Enemies, Old and New"] = true	--Horde
	BC["In Defense of Halaa"] = true	--Alliance
	----Battlegrounds
	BC["Call to Arms: Eye of the Storm"] = true

local LK = LibStub("AceLocale-3.0"):NewLocale("SOCD_LK", "enUS", true)
--
--	WOTLK
--	
	LK["test"] = true





