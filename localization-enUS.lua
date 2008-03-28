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




local L = LibStub("AceLocale-3.0"):NewLocale("SickOfClickingDailies", "enUS", true)

if L then
--Skettis
	L["Sky Sergeant Doryn"] = true					--*NPC
		L["Fires Over Skettis"] = true				--*Quest
		L["Escape from Skettis"] = true				--*Quest

	L["Skyguard Prisoner"] = true					--*NPC

	L["Skyguard Khatie"] = true						--*NPC
		L["Wrangle More Aether Rays!"] = true		--*Quest

	L["Sky Sergeant Vanderlip"] = true				--*NPC
		L["Bomb Them Again!"] = true				--*Quest
		
--Ogri'la
	L["Chu'a'lor"] = true							--*NPC
		L["The Relic's Emanation"] = true			--*Quest

	L["Kronk"] = true								--*NPC
		L["Banish More Demons"] = true				--*Quest
		
--Netherwing
	L["Mistress of the Mines"] = true				--*NPC
		L["Picking Up The Pieces..."] = true		--*Quest

	L["Dragonmaw Foreman"] = true					--*NPC
		L["Dragons are the Least of Our Problems"] = true	--*Quest

	L["Yarzill the Merc"] = true					--*NPC
		L["The Not-So-Friendly Skies..."] = true	--*Quest
		L["A Slow Death"] = true					--*Quest

	L["Taskmaster Varkule Dragonbreath"] = true		--*NPC
		L["Nethercite Ore"] = true					--*Quest
		L["Netherdust Pollen"] = true				--*Quest
		L["Nethermine Flayer Hide"] = true			--*Quest
		L["Netherwing Crystals"] = true				--*Quest

	L["Chief Overseer Mudlump"] = true				--*NPC
		L["The Booterang: A Cure For The Common Worthless Peon"] = true		--*Quest

	L["Commander Arcus"] = true						--*NPC
	L["Commander Hobb"] = true						--*NPC
	L["Overlord Mor'ghor"] = true					--*NPC
		L["Disrupting the Twilight Portal"] = true	--*Quest
		L["The Deadliest Trap Ever Laid"] = true	--*Quest

--Shattered Sun Offensive
	L["Vindicator Xayann"] = true					--*NPC
		L["Erratic Behavior"] = true				--Quest
		L["Further Conversions"] = true				--Quest
	L["Captain Theris Dawnhearth"] = true
		L["The Sanctum Wards"] = true
		L["Arm the Wards!"] = true
	L["Harbinger Haronem"] = true
		L["The Multiphase Survey"] = true
	L["Lord Torvos"] = true
		L["Sunfury Attack Plans"] = true
	L["Emissary Mordin"] = true
		L["Gaining the Advantage"] = true
	L["Harbinger Inuuro"] = true
		L["The Battle for the Sun's Reach Armory"] = true
		L["The Battle Must Go On"] = true
	L["Battlemage Arynna"] = true
		L["Distraction at the Dead Scar"] = true
		L["The Air Strikes Must Continue"] = true
	L["Magistrix Seyla"] = true
		L["Blast the Gateway"] = true
		L["Blood for Blood"] = true
	L["Exarch Nasuun"] = true
		L["Intercepting the Mana Cells"] = true
		L["Maintaining the Sunwell Portal"] = true
	L["Astromancer Darnarian"] = true
		L["Know Your Ley Lines"] = true
	L["Vindicator Kaalan"] = true
		L["Intercept the Reinforcements"] = true
		L["Keeping the Enemy at Bay"] = true
	L["Magister Ilastar"] = true
		L["Taking the Harbor"] = true
		L["Crush the Dawnblade"] = true
	L["Smith Hauthaa"] = true
		L["Making Ready"] = true
		L["Don't Stop Now...."] = true
		L["Ata'mal Armaments"] = true
	L["Anchorite Ayuri"] = true
		L["A Charitable Donation"] = true
		L["Your Continued Support"] = true
	L["Captain Valindria"] = true
		L["Disrupt the Greengill Coast"] = true
	L["Mar'nah"] = true
		L["Discovering Your Roots"] = true
		L["Rediscovering Your Roots"] = true
		L["Open for Business"] = true
		
--Wintersaber Rep
L["Rivern Frostwind"] = true						--*NPC
	L["Frostsaber Provisions"] = true				--*Quest
	L["Winterfall Intrusion"] = true				--*Quest
	L["Rampaging Giants"] = true					--*Quest
	
--Cooking
L["The Rokk"] = true								--*NPC
	L["Super Hot Stew"] = true						--*Quest
	L["Soup for the Soul"] = true					--*Quest
	L["Revenge is Tasty"] = true					--*Quest
	L["Manalicious"] = true							--*Quest
	
--Fishing
L["Old Man Barlo"] = true								--*NPC
	L["Crocolisks in the City"] = true						--*Quest
	L["Bait Bandits"] = true						--*Quest
	L["Felblood Fillet"] = true					--*Quest
	L["Shrimpin' Ain't Easy"] = true					--*Quest
	L["The One That Got Away"] = true							--*Quest

--Non-Heroic Instances
L["Nether-Stalker Mah'duun"] = true					--*NPC
	L["Wanted: Arcatraz Sentinels"] = true			--*Quest
	L["Wanted: Coilfang Myrmidons"] = true			--*Quest
	L["Wanted: Malicious Instructors"] = true		--*Quest
	L["Wanted: Rift Lords"] = true					--*Quest
	L["Wanted: Shattered Hand Centurions"] = true	--*Quest
	L["Wanted: Sunseeker Channelers"] = true		--*Quest
	L["Wanted: Tempest-Forge Destroyers"] = true	--*Quest
	L["Wanted: Sisters of Torment"] = true	--*Quest

--Names...		These lines are used for display in the gui to shorten the idea of what the quest is.
	L["Arcatraz Sentinels"] = true
	L["Coilfang Myrmidons"] = true
	L["Malicious Instructors"] = true
	L["Rift Lords"] = true
	L["Shattered Hand Centurions"] = true
	L["Sunseeker Channelers"] = true
	L["Tempest-Forge Destroyers"] = true
	L["Sisters of Torment"] = true

--Heroic Instances
L["Wind Trader Zhareem"] = true						--*NPC
	L["Wanted: A Black Stalker Egg"] = true			--*Quest
	L["Wanted: A Warp Splinter Clipping"] = true	--*Quest
	L["Wanted: Aeonus's Hourglass"] = true			--*Quest
	L["Wanted: Bladefist's Seal"] = true			--*Quest
	L["Wanted: Keli'dan's Feathered Stave"] = true	--*Quest
	L["Wanted: Murmur's Whisper"] = true			--*Quest
	L["Wanted: Nazan's Riding Crop"] = true			--*Quest
	L["Wanted: Pathaleon's Projector"] = true		--*Quest
	L["Wanted: Shaffar's Wondrous Pendant"] = true	--*Quest
	L["Wanted: The Epoch Hunter's Head"] = true		--*Quest
	L["Wanted: The Exarch's Soul Gem"] = true		--*Quest
	L["Wanted: The Headfeathers of Ikiss"] = true	--*Quest
	L["Wanted: The Heart of Quagmirran"] = true		--*Quest
	L["Wanted: The Scroll of Skyriss"] = true		--*Quest
	L["Wanted: The Warlord's Treatise"] = true		--*Quest
	L["Wanted: The Signet Ring of Prince Kael'thas"] = true		--*Quest
	
--Names...		These lines are used for display in the gui to shorten the idea of what the quest is.
	L["A Black Stalker Egg"] = true
	L["A Warp Splinter Clipping"] = true
	L["Aeonus's Hourglass"] = true
	L["Bladefist's Seal"] = true
	L["Keli'dan's Feathered Stave"] = true
	L["Murmur's Whisper"] = true
	L["Nazan's Riding Crop"] = true
	L["Pathaleon's Projector"] = true
	L["Shaffar's Wondrous Pendant"] = true
	L["The Epoch Hunter's Head"] = true
	L["The Exarch's Soul Gem"] = true
	L["The Headfeathers of Ikiss"] = true
	L["The Heart of Quagmirran"] = true
	L["The Scroll of Skyriss"] = true
	L["The Warlord's Treatise"] = true
	L["Ring of Prince Kael'thas"] = true

--PvP
L["Alliance Brigadier General"] = true				--*NPC
L["Horde Warbringer"] = true						--*NPC
	L["Call to Arms: Alterac Valley"] = true		--Quest
	L["Call to Arms: Arathi Basin"] = true			--Quest
	L["Call to Arms: Eye of the Storm"] = true		--Quest
	L["Call to Arms: Warsong Gulch"] = true			--Quest
L["Warrant Officer Tracy Proudwell"] = true			--*NPC
L["Battlecryer Blackeye"] = true					--*NPC
	L["Hellfire Fortifications"] = true				--Quest
L["Exorcist Sullivan"] = true						--*NPC
L["Exorcist Vaisha"] = true							--*NPC
	L["Spirits of Auchindoun"] = true				--Quest
L["Karrtog"] = true									--*NPC
	L["Enemies, Old and New"] = true				--Quest
L["Lakoor"] = true									--*NPC
	L["In Defense of Halaa"] = true					--Quest

-- Options Table Locale
--General Titles
L["Sick Of Clicking Dailies?"] = true  ---- Addon Name used for Options table
L["NPC & Quest Options"] = true
L["NPC Enabled"] = true
L["Addon Options"] = true
L["Enabled"] = true
L["Enable Quest"] = true
L["Quest Reward"] = true
L["None"] = true

L["Always Loop NPCs"] = true
L["Always Loop on the NPC from one quest to the next forever"] = true
L["Enable Gossip window"] = true
L["Enable skipping the opening gossip text"] = true
L["Enable Quest Text window"] = true
L["Enable skipping the Quest Descriptive text"] = true
L["Enable Completion Gossip"] = true
L["Enable skipping the Quest Completion question text"] = true
L["Enable Quest Turn In"] = true
L["Enable skipping the actual turn in of the quest"] = true

--Titles
L["Faction Grinds"] = true
	L["Skyguard"] = true
		L["Blades Edge Mountains"] = true
		L["Skettis"] = true
	L["Ogri'la"] = true
	L["Netherwing"] = true
		L["Netherwing - Neutral"] = true
		L["Netherwing - Friendly"] = true
		L["Netherwing - Honored"] = true
		L["Netherwing - Revered"] = true
	L["Shattered Sun Offensive"] = true
	L["Wintersaber Trainer"] = true
	
L["PvP"] = true
	L["Horde PvP"] = true
	L["Alliance PvP"] = true
	L["Battlegrounds"] = true
	L["World PvP"] = true
	
L["Instance"] = true
	L["Instance - Normal"] = true
	L["Instance - Heroic"] = true
		L["The Eye"] = true
		L["Serpentshrine Cavern"] = true
		L["Hellfire Citadel"] = true
		L["Caverns of Time"] = true
		L["Auchindoun"] = true
		L["Magister's Terrace"] = true
		
L["Cooking"] = true
L["Fishing"] = true
L["Profession"] = true

--Special Tool Tips
L["This will toggle the quest on both Doryn and the Prisoner"] = true
L["|cffFF0000WARNING!!!|r, This Option also toggles both Scryer and Aldor Quests"] = true  ---Warning Color Code included in this string
L["\nAll Non-Heroic Quests are from |cff00ff00'Nether-Stalker Mah'duun'|r in LowerCity"] = true
L["\nAll Heroic Dailies from |cff00ff00'Wind Trader Zhareem'|r in LowerCity"] = true

--Quest Options

L["Select what Potion you want for the 'Escape from Skettis' quest"] = true
L["Health Potion"] = true
L["Mana Potion"] = true
L["Barrel of Fish"] = true
L["Crate of Meat"] = true
L["Mark of Sargeras"] = true
L["Sunfury Signet"] = true
L["Blessed Weapon Coating"] = true
L["Righteous Weapon Coating"] = true

end
