--
--	General Localizations here
--
--	:D

local L = LibStub("AceLocale-3.0"):NewLocale("SOCD_Core", "enUS", true)
if not L then return end

if L then
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
	L["Horde"] = FACTION_HORDE
	L["Alliance"] = FACTION_ALLIANCE

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
	L["Cooking"] = (GetSpellInfo(2550))
	L["Fishing"] = (GetSpellInfo(7733))
	L["Jewelcrafting"] = (GetSpellInfo(25229))

	--LichKing
	L["LK"] = "Lich King"
		--Factions
	L["The Wyrmrest Accord"] = true
	L["Sholazar Basin"] = true
	L["The Oracles"] = true
	L["Frenzyheart Tribe"] = true
	L["The Sons of Hodir"] = true
	L["Argent Crusade"] = true
	L["Knights of the Ebon Blade"] = true
	L["The Kalu'ak"] = true
	L["The Storm Peaks"] = true
	L["The Frostborn"] = true

		--Misc Titles
	L["Shared Faction Quests"] = true
	L["Icecrown"] = true
	L["Grizzly Hills"] = true
	L["Wintergrasp"] = true
	L["Shared Quests"] = true
	L["Icecrown Netural Quests"] = true
	L["Troll Patrol: "] = true	--There is a space at the end, this is used to clip ugly quests.
	L["Shipment: "] = true	--There is also a space at the end of here..
	L["Proof of Demise: "] = true
	L["Timear Foresees (.+) in your Future!"] = true	--regex leave the (.+) in the middle there.
	L["Faction Token"] = true
	
	
end	

--All Quests Classified by orgin / content location
--
--	Classic
--
--
local C = LibStub("AceLocale-3.0"):NewLocale("SOCD_Classic", "enUS", true)

if C then
--Wintersaber Trainer
	C["Frostsaber Provisions"] = true
	C["Winterfall Intrusion"] = true
	C["Rampaging Giants"] = true

--PvP
	C["Call to Arms: Warsong Gulch"] = true
	C["Call to Arms: Arathi Basin"] = true
	C["Call to Arms: Alterac Valley"] = true
end

--
--	TBC
--	

local BC = LibStub("AceLocale-3.0"):NewLocale("SOCD_BC", "enUS", true)

if BC then
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
end

--
--	WOTLK
--	
local LK = LibStub("AceLocale-3.0"):NewLocale("SOCD_LK", "enUS", true)

if LK then
	--Instance Dailies
	LK["All Things in Good Time"] = true
		--Heroics
	LK["Proof of Demise: Anub'arak"] = true
	LK["Proof of Demise: Cyanigosa"] = true
	LK["Proof of Demise: Gal'darah"] = true
	LK["Proof of Demise: Herald Volazj"] = true
	LK["Proof of Demise: Ingvar the Plunderer"] = true
	LK["Proof of Demise: Keristrasza"] = true
	LK["Proof of Demise: King Ymiron"] = true
	LK["Proof of Demise: Ley-Guardian Eregos"] = true
	LK["Proof of Demise: Loken"] = true
	LK["Proof of Demise: Mal'Ganis"] = true
	LK["Proof of Demise: Sjonnir The Ironshaper"] = true
	LK["Proof of Demise: The Prophet Tharon'ja"] = true
		--Non Heroics
	LK["Timear Foresees Centrifuge Constructs in your Future!"] = true
	LK["Timear Foresees Infinite Agents in your Future!"] = true
	LK["Timear Foresees Titanium Vanguards in your Future!"] = true
	LK["Timear Foresees Ymirjar Berserkers in your Future!"] = true

	--Professions
		--Cooking
	LK["Cheese for Glowergold"] = true
	LK["Convention at the Legerdemain"] = true
	LK["Infused Mushroom Meatloaf"] = true
	LK["Mustard Dogs!"] = true
	LK["Sewer Stew"] = true
		--Jewlcrafting
	LK["Shipment: Blood Jade Amulet"] = true
	LK["Shipment: Bright Armor Relic"] = true
	LK["Shipment: Glowing Ivory Figurine"] = true
	LK["Shipment: Intricate Bone Figurine"] = true
	LK["Shipment: Shifting Sun Curio"] = true
	LK["Shipment: Wicked Sun Brooch"] = true

	--Factions
		--The Wyrmrest Accord
	LK["Aces High!"] = true
	LK["Drake Hunt"] = true
	LK["Defending Wyrmrest Temple"] = true

		--The Oracles
	LK["A Cleansing Song"] = true
	LK["Appeasing the Great Rain Stone"] = true
	LK["Hand of the Oracles"] = true
	LK["Mastery of the Crystals"] = true
	LK["Power of the Great Ones"] = true
	LK["Song of Fecundity"] = true
	LK["Song of Reflection"] = true
	LK["Song of Wind and Water"] = true
	LK["Will of the Titans"] = true

		--Frenzyheart Tribe
	LK["A Hero's Headgear"] = true
	LK["Chicken Party!"] = true
	LK["Frenzyheart Champion"] = true
	LK["Kartak's Rampage"] = true
	LK["Rejek: First Blood"] = true
	LK["Secret Strength of the Frenzyheart"] = true
	LK["Strength of the Tempest"] = true
	LK["The Heartblood's Strength"] = true
	LK["Tools of War"] = true

		--The Sons of Hodir
	LK["Blowing Hodir's Horn"] = true
	LK["Hodir's Horn"] = true	--object Name

	LK["Feeding Arngrim"] = true
	LK["Arngrim the Insatiable"] = true	--object Name

	LK["Hot and Cold"] = true
	LK["Fjorn's Anvil"] = true	--object name
	

	LK["Polishing the Helm"] = true
	LK["Hodir's Helm"] = true	--object Name

	LK["Spy Hunter"] = true

	LK["Thrusting Hodir's Spear"] = true
	LK["Hodir's Spear"] = true	--object Name

		--Argent Crusade
	LK["The Alchemist's Apprentice"] = true
	LK["Troll Patrol"] = true
	LK["Troll Patrol: Can You Dig It?"] = true
	LK["Troll Patrol: Couldn't Care Less"] = true
	LK["Troll Patrol: Creature Comforts"] = true
	LK["Troll Patrol: Done to Death"] = true
	LK["Troll Patrol: High Standards"] = true
	LK["Troll Patrol: Intestinal Fortitude"] = true
	LK["Troll Patrol: Something for the Pain"] = true
	LK["Troll Patrol: The Alchemist's Apprentice"] = true
	LK["Troll Patrol: Throwing Down"] = true
	LK["Troll Patrol: Whatdya Want, a Medal?"] = true
	LK["Congratulations!"] = true

		--Knights of the Ebon Blade
	LK["Intelligence Gathering"] = true
	LK["Leave Our Mark"] = true
	LK["No Fly Zone"] = true
	LK["From Their Corpses, Rise!"] = true
	LK["Shoot 'Em Up"] = true
	LK["Vile Like Fire!"] = true

		--The Kalu'ak
	LK["Planning for the Future"] = true
	LK["Preparing for the Worst"] = true
	LK["The Way to His Heart..."] = true

		--The Frostborn
	LK["Pushed Too Far"] = true

	----Horde Expedition / --Alliance Vanguard
		--These are shared quests for the given zone
		--IceCrown
	LK["King of the Mountain"] = true	--Netural
	LK["Blood of the Chosen"] = true	--Netural
	LK["Drag and Drop"] = true	--Netural
	LK["Neutralizing the Plague"] = true	--Netural
	LK["No Rest For The Wicked"] = true	--Netural
	LK["Not a Bug"] = true	--Netural
	LK["Retest Now"] = true	--Netural
	LK["Slaves to Saronite"] = true	--Netural
	LK["That's Abominable!"] = true	--Netural
	LK["Static Shock Troops: the Bombardment"] = true	--Alliance
	LK["Total Ohmage: The Valley of Lost Hope!"] = true	--Horde
	LK["The Solution Solution"] = true	--Alliance
	LK["Volatility"] = true	--Horde
	LK["Capture More Dispatches"] = true	--Alliance
	LK["Keeping the Alliance Blind"] = true	--Horde
	LK["Putting the Hertz: The Valley of Lost Hope"] = true	--Alliance
	LK["Riding the Wavelength: The Bombardment"] = true	--Horde

		--Grizzly Hills
	LK["Life or Death"] = true	--Alliance
	LK["Overwhelmed!"] = true	--Horde
	LK["Making Repairs"] = true	--Horde
	LK["Pieces Parts"] = true	--Alliance
	LK["Keep Them at Bay"] = true	--Netural
	LK["Riding the Red Rocket"] = true	--Netural
	LK["Seared Scourge"] = true	--Netural
	LK["Smoke 'Em Out"] = true	--Netural

		--The Storm Peaks
	LK["Back to the Pit"] = true
	LK["Defending Your Title"] = true
	LK["Overstock"] = true
	LK["Maintaining Discipline"] = true
	LK["The Aberrations Must Die"] = true


		--World PvP
		--These Quests Specificlally flag you as PvP Active
		--Wintergrasp Fortress
	LK["A Rare Herb"] = true
	LK["Bones and Arrows"] = true
	LK["Defend the Siege"] = true
	LK["Fueling the Demolishers"] = true
	LK["Healing with Roses"] = true
	LK["Jinxing the Walls"] = true
	LK["No Mercy for the Merciless"] = true
	LK["Slay them all"] = true
	LK["Stop the Siege"] = true
	LK["Victory in Wintergrasp"] = true
	LK["Warding the Walls"] = true
	LK["Warding the Warriors"] = true

		--BattleGround
	LK["Call to Arms: Strand of the Ancients"] = true

		--IceCrown
	LK["Make Them Pay!"] = true	--Horde
	LK["Shred the Alliance"] = true	--Horde
	LK["No Mercy!"] = true	--Allaince
	LK["Shredder Repair"] = true	--Alliance

		--Grizzly Hills
	LK["Keep Them at Bay"] = true	--Netural
	LK["Riding the Red Rocket"] = true	--Netural
	LK["Seared Scourge"] = true	--Netural
	LK["Smoke 'Em Out"] = true	--Netural

	LK["Down With Captain Zorna!"] = true	--Alliance
	LK["Kick 'Em While They're Down"] = true	--Alliance
	LK["Blackriver Skirmish"] = true	--Alliance

	LK["Crush Captain Brightwater!"] = true	--Horde
	LK["Keep 'Em on Their Heels"] = true	--Horde
	LK["Blackriver Brawl"] = true	--Horde


	--Misc
		--Howling Fjord
	LK["Break the Blockade"] = true	--Alliance
	LK["Steel Gate Patrol"] = true	--Alliance

end
