--Major 4, Minor $Revision$

if GetLocale() == "enUS" or "enGB" then
SOCD_LOCALE_TABLE = {
--QNPC's
	--Skettis
		["Sky Sergeant Doryn"] = true,
		["Skyguard Prisoner"] = true, 
		["Escape from Skettis"] = true,
	--Blades Edge Mountains
		["Skyguard Khatie"] = true,
		["Sky Sergeant Vanderlip"] = true,
		["Chu'a'lor"] = true,	
		["Kronk"] = true,
	--Netherwing
		["Mistress of the Mines"] = true,
		["Dragonmaw Foreman"] = true,
		["Yarzill the Merc"] = true,
		["Taskmaster Varkule Dragonbreath"] = true,
		["Chief Overseer Mudlump"] = true,
		["Overlord Mor'ghor"] = true,
		["Commander Hobb"] = true, -- Scryer
		["Commander Arcus"] = true, --Aldor
--Quests
	--Skettis
		["Fires Over Skettis"] = true,
		["Escape from Skettis"] = true,
	--Blades Edge Mountains
		["Wrangle More Aether Rays!"] = true,
		["Bomb Them Again!"] = true,
		["The Relic's Emanation"] = true,
		["Banish More Demons"] = true,
	--Netherwing
		["Picking Up The Pieces..."] = true,
		["Dragons are the Least of Our Problems"] = true,
		["The Not-So-Friendly Skies..."] = true,
		["A Slow Death"] = true,
		["Nethercite Ore"] = true,
		["Netherdust Pollen"] = true,
		["Nethermine Flayer Hide"] = true,
		["Netherwing Crystals"] = true,
		["The Booterang: A Cure For The Common Worthless Peon"] = true,
		["Disrupting the Twilight Portal"] = true,
		["The Deadliest Trap Ever Laid"] = true,
	}

	for k, v in pairs(SOCD_LOCALE_TABLE) do
		if v == true then
			SOCD_LOCALE_TABLE[k] = k
		end
	end
end
