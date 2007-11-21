--Major 4, Minor Revision: 134 

--local L = LibStub("AceLocale-3.0"):NewLocale("SickOfClickingDailies", "enUS", true)
local L = {}
if GetLocale() == "enUS" then 
SOCD_LOCALE_TABLE = L

--if L then

	L["Sky Sergeant Doryn"] = true
	L["Fires Over Skettis"] = true
	L["Escape from Skettis"] = true

	L["Skyguard Prisoner"] = true

	L["Skyguard Khatie"] = true
	L["Wrangle More Aether Rays!"] = true

	L["Sky Sergeant Vanderlip"] = true
	L["Bomb Them Again!"] = true

	L["Chu'a'lor"] = true
	L["The Relic's Emanation"] = true

	L["Kronk"] = true
	L["Banish More Demons"] = true

	L["Mistress of the Mines"] = true
	L["Picking Up The Pieces..."] = true

	L["Dragonmaw Foreman"] = true
	L["Dragons are the Least of Our Problems"] = true

	L["Yarzill the Merc"] = true
	L["The Not-So-Friendly Skies..."] = true
	L["A Slow Death"] = true

	L["Taskmaster Varkule Dragonbreath"] = true
	L["Nethercite Ore"] = true
	L["Netherdust Pollen"] = true
	L["Nethermine Flayer Hide"] = true
	L["Netherwing Crystals"] = true

	L["Chief Overseer Mudlump"] = true
	L["The Booterang: A Cure For The Common Worthless Peon"] = true

	L["Overlord Mor'ghor"] = true
	L["Disrupting the Twilight Portal"] = true
	L["The Deadliest Trap Ever Laid"] = true

	L["Commander Arcus"] = true
	L["Commander Hobb"] = true

	L["Rivern Frostwind"] = true
	L["Frostsaber Provisions"] = true
	L["Winterfall Intrusion"] = true
	L["Rampaging Giants"] = true

	L["The Rokk"] = true
	L["Super Hot Stew"] = true
	L["Soup for the Soul"] = true
	L["Revenge is Tasty"] = true
	L["Manalicious"] = true

	L["Nether-Stalker Mah'duun"] = true
	L["Wanted: Arcatraz Sentinels"] = true
	L["Wanted: Coilfang Myrmidons"] = true
	L["Wanted: Malicious Instructors"] = true
	L["Wanted: Rift Lords"] = true
	L["Wanted: Shattered Hand Centurions"] = true
	L["Wanted: Sunseeker Channelers"] = true
	L["Wanted: Tempest-Forge Destroyers"] = true

	L["Wind Trader Zhareem"] = true
	L["Wanted: A Black Stalker Egg"] = true
	L["Wanted: A Warp Splinter Clipping"] = true
	L["Wanted: Aeonus's Hourglass"] = true
	L["Wanted: Bladefist's Seal"] = true
	L["Wanted: Keli'dan's Feathered Stave"] = true
	L["Wanted: Murmur's Whisper"] = true
	L["Wanted: Nazan's Riding Crop"] = true
	L["Wanted: Pathaleon's Projector"] = true
	L["Wanted: Shaffar's Wondrous Pendant"] = true
	L["Wanted: The Epoch Hunter's Head"] = true
	L["Wanted: The Exarch's Soul Gem"] = true
	L["Wanted: The Headfeathers of Ikiss"] = true
	L["Wanted: The Heart of Quagmirran"] = true
	L["Wanted: The Scroll of Skyriss"] = true
	L["Wanted: The Warlord's Treatise"] = true

	L["Horde Warbringer"] = true
	L["Call to Arms: Alterac Valley"] = true
	L["Call to Arms: Arathi Basin"] = true
	L["Call to Arms: Eye of the Storm"] = true
	L["Call to Arms: Warsong Gulch"] = true

	L["Alliance Brigadier General"] = true
	L["Warrant Officer Tracy Proudwell"] = true
	L["Battlecryer Blackeye"] = true
	L["Hellfire Fortifications"] = true

-- Options Table Locale
--General Titles
	L["Sick Of Clicking Dailies?"] = true  ---- Addon Name used for Options table
	L["NPC & Quest Options"] = true
	L["NPC Enabled"] = true
	L["General Options"] = true
	L["Enabled"] = true
	L["Always Loop NPCs"] = true
	L["Always Loop on the NPC from one quest to the next forever"] = true
	L["Enable Quest"] = true

--Faction Groups
	L["Faction Grinds"] = true
		L["Skyguard"] = true
		L["Ogri'la"] = true
		L["Netherwing"] = true
		L["Netherwing - Neutral"] = true
		L["Netherwing - Friendly"] = true
		L["Netherwing - Honored"] = true
		L["Wintersaber Trainer"] = true
	L["PvP Dailies"] = true
		L["Horde PvP"] = true
		L["Alliance PvP"] = true
		L["Battlegrounds"] = true
		L["World PvP"] = true

	L["Instance Dailies"] = true
		L["Normal Mode"] = true
		L["Heroic Mode"] = true
		
		L["The Eye Heroic Dailies"] = true
		L["Serpentshrine Cavern Heroic Dailies"] = true
		L["Hellfire Citadel Heroic Dailies"] = true
		L["Caverns of Time Heroic Dailies"] = true
		L["Auchindoun Heroic Dailies"] = true
	
	L["Cooking Dailies"] = true

--Special Tool Tips
L["This will toggle the quest on both Doryn and the Prisoner"] = true
L["|cffFF0000WARNING!!!|r, This Option also toggles both Scryer and Aldor Quests"] = true  ---Warning Color Code included in this string
L["Currently All non-Heroic Quests are from\n |cff00ff00'Nether-Stalker Mah'duun'|r in lower city "] = true
L["Heroic Mode Dailies available from: \n |cff00ff00'Wind Trader Zhareem' in LowerCity"] = true
L["Currently All non-Heroic Quests are from\n |cff00ff00'Nether-Stalker Mah'duun'|r in lower city "] = true


--Quest Options
L["Quest Reward"] = true
L["Select what Potion you want for the 'Escape from Skettis' quest"] = true
L["None"] = true
L["Health Potion"] = true
L["Mana Potion"] = true
L["Escort Quest Potion"] = true
L["Barrel of Fish"] = true
L["Crate of Meat"] = true

for k,v in pairs(L) do
	if v == true then
		v = k
	end
end

end