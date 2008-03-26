--Major 5, Minor $Revision$
--[[

	How to Localize this, because it's a pain in the ass.

	/dump UnitName("target")
	/dump GetTitleText()

	The Lines marked NPC must have the EXACT spelling and coding as the above command for UnitName()
	Same applys for the *Quest marked lines, must have the EXACT spelling and coding as given by "GetTitleText()"
	if they are not the same then it will not work.

	all other lines are bissness as usual, being touched every few weeks.

	Origional German Translations done by: Sinxia
		--THANK YOU :D
]]--


local L = LibStub("AceLocale-3.0"):NewLocale("SickOfClickingDailies", "deDE")

if L then
--Skettis
	L["Sky Sergeant Doryn"] = "Himmelsoffizier Doryn"
		L["Fires Over Skettis"] = "Feuer \195\188ber Skettis"
		L["Escape from Skettis"] = "Flucht aus Skettis"

	L["Skyguard Prisoner"] = "Gefangene Himmelswache"

	L["Skyguard Khatie"] = "Himmelswache Khatie"
		L["Wrangle More Aether Rays!"] = "B\195\164ndigt noch mehr \195\132therrochen!"

	L["Sky Sergeant Vanderlip"] = "Himmelsoffizier Vanderlip"
		L["Bomb Them Again!"] = "Und wieder ein Bombenangriff!"

--Ogri'la
	L["Chu'a'lor"] = true
		L["The Relic's Emanation"] = "Die Strahlung des Relikts"

	L["Kronk"] = true
		L["Banish More Demons"] = "Bannt mehr D\195\164monen"

--Netherwing
	L["Mistress of the Mines"] = "Herrin der Minen"
		L["Picking Up The Pieces..."] = "Die Dinge in den Griff bekommen..."

	L["Dragonmaw Foreman"] = "Vorarbeiter des Drachenmals"
		L["Dragons are the Least of Our Problems"] = "Drachen sind unsere geringste Sorge"

	L["Yarzill the Merc"] = "Yarzill der S\195\182ldner"
		L["The Not-So-Friendly Skies..."] = "Ein Schatten am Horizont"
		L["A Slow Death"] = "Ein langsamer Tod"

	L["Taskmaster Varkule Dragonbreath"] = "Zuchtmeister Varkule Drachenodem"
		L["Nethercite Ore"] = "Netheriterz"
		L["Netherdust Pollen"] = "Netherstaubpollen"
		L["Nethermine Flayer Hide"] = "Balg eines Netherminenschinders"
		L["Netherwing Crystals"] = "Kristalle der Netherschwingen"

	L["Chief Overseer Mudlump"] = "Chefvorarbeiter Lehmklump"
		L["The Booterang: A Cure For The Common Worthless Peon"] = "Der Schuhmerang: Das Mittel gegen den wertlosen Peon"

	L["Commander Arcus"] = "Kommandant Arcus"
	L["Commander Hobb"] = "Kommandant Hobb"
	L["Overlord Mor'ghor"] = "Oberanf\195\188hrer Mor'ghor"
		L["Disrupting the Twilight Portal"] = "Schw\195\164cht das Portal des Zwielichts"
		L["The Deadliest Trap Ever Laid"] = "Die t\195\182dlichste Falle aller Zeiten"

--Shattered Sun Offensive
	-- L["Vindicator Xayann"] = true					--*NPC
		-- L["Erratic Behavior"] = true				--Quest
	-- L["Captain Theris Dawnhearth"] = true			--*NPC
		-- L["The Sanctum Wards"] = true				--Quest

--Wintersaber Rep
L["Rivern Frostwind"] = true
	L["Frostsaber Provisions"] = "Frosts\195\164blerverpflegung"
	L["Winterfall Intrusion"] = "Eindringlinge der Winterfelle"
	L["Rampaging Giants"] = "Tobende Riesen"

--Cooking
L["The Rokk"] = "Der Rokk"
	L["Super Hot Stew"] = "Superhei\195\159es Ragout"
	L["Soup for the Soul"] = "Suppe f\195\188r die Seele"
	L["Revenge is Tasty"] = "Rache ist schmackhaft"
	L["Manalicious"] = "Manazi\195\182s"

--Fishing
-- L["Old Man Barlo"] = true								--*NPC
	-- L["Crocolisks in the City"] = true						--*Quest
	-- L["Bait Bandits"] = true						--*Quest
	-- L["Felblood Fillet"] = true					--*Quest
	-- L["Shrimpin' Ain't Easy"] = true					--*Quest
	-- L["The One That Got Away"] = true							--*Quest

--Non-Heroic Instances
L["Nether-Stalker Mah'duun"] = "Netherpirscher Mah'duun"
	L["Wanted: Arcatraz Sentinels"] = "Gesucht: Schildwachen der Arkatraz"
	L["Wanted: Coilfang Myrmidons"] = "Gesucht: Myrmidonen des Echsenkessels"
	L["Wanted: Malicious Instructors"] = "Gesucht: B\195\182sartige Ausbilderinnen"
	L["Wanted: Rift Lords"] = "Gesucht: F\195\188rsten der Zeitenrisse"
	L["Wanted: Shattered Hand Centurions"] = "Gesucht: Zenturionen der Zerschmetterten Hand"
	L["Wanted: Sunseeker Channelers"] = "Gesucht: Kanalisierer der Sonnensucher"
	L["Wanted: Tempest-Forge Destroyers"] = "Gesucht: Zerst\195\182rer der Sturmschmiede"

	--Names...		These lines are used for display in the gui to shorten the idea of what the quest is.
	L["Arcatraz Sentinels"] = "Schildwachen der Arkatraz"
	L["Coilfang Myrmidons"] = "Myrmidonen des Echsenkessels"
	L["Malicious Instructors"] = "B\195\182sartige Ausbilderinnen"
	L["Rift Lords"] = "F\195\188rsten der Zeitenrisse"
	L["Shattered Hand Centurions"] = "Zenturionen der Zerschmetterten Hand"
	L["Sunseeker Channelers"] = "Kanalisierer der Sonnensucher"
	L["Tempest-Forge Destroyers"] = "Zerst\195\182rer der Sturmschmiede"

--Heroic Instances
L["Wind Trader Zhareem"] = "Windh\195\164ndler Zhareem"
	L["Wanted: A Black Stalker Egg"] = "Gesucht: Ei der Schattenmutter"
	L["Wanted: A Warp Splinter Clipping"] = "Gesucht: Warpzweigsplitter"
	L["Wanted: Aeonus's Hourglass"] = "Gesucht: Aeonus' Stundenglas"
	L["Wanted: Bladefist's Seal"] = "Messerfausts Siegel"
	L["Wanted: Keli'dan's Feathered Stave"] = "Gesucht: Keli'dans gefiederter Stab"
	L["Wanted: Murmur's Whisper"] = "Gesucht: Murmurs Fl\195\188stern"
	L["Wanted: Nazan's Riding Crop"] = "Gesucht: Nazans Reitgerte"
	L["Wanted: Pathaleon's Projector"] = "Gesucht: Pathaleons Projektionsger\195\164t"
	L["Wanted: Shaffar's Wondrous Pendant"] = "Gesucht: Shaffars wundersames Amulett"
	L["Wanted: The Epoch Hunter's Head"] = "Gesucht: Der Kopf des Epochenj\195\164gers"
	L["Wanted: The Exarch's Soul Gem"] = "Gesucht: Der Seelenedelstein des Exarchen"
	L["Wanted: The Headfeathers of Ikiss"] = "Gesucht: Die Kopfschmuckfedern von Ikiss"
	L["Wanted: The Heart of Quagmirran"] = "Gesucht: Das Herz von Quagmirran"
	L["Wanted: The Scroll of Skyriss"] = "Gesucht: Horizontiss' Schriftrolle"
	L["Wanted: The Warlord's Treatise"] = "Gesucht: Die Aufzeichnungen des Kriegsherren"

--Names...		These lines are used for display in the gui to shorten the idea of what the quest is.
	L["A Black Stalker Egg"] = "Ei der Schattenmutter"
	L["A Warp Splinter Clipping"] = "Warpzweigsplitter"
	L["Aeonus's Hourglass"] = "Aeonus' Stundenglas"
	L["Bladefist's Seal"] = "Messerfausts Siegel"
	L["Keli'dan's Feathered Stave"] = "Keli'dans gefiederter Stab"
	L["Murmur's Whisper"] = "Murmurs Fl\195\188stern"
	L["Nazan's Riding Crop"] = "Nazans Reitgerte"
	L["Pathaleon's Projector"] = "Pathaleons Projektionsger\195\164t"
	L["Shaffar's Wondrous Pendant"] = "Shaffars wundersames Amulett"
	L["The Epoch Hunter's Head"] = "Der Kopf des Epochenj\195\164gers"
	L["The Exarch's Soul Gem"] = "Der Seelenedelstein des Exarchen"
	L["The Headfeathers of Ikiss"] = "Die Kopfschmuckfedern von Ikiss"
	L["The Heart of Quagmirran"] = "Das Herz von Quagmirran"
	L["The Scroll of Skyriss"] = "Horizontiss' Schriftrolle"
	L["The Warlord's Treatise"] = "Die Aufzeichnungen des Kriegsherren"

--PvP
L["Alliance Brigadier General"] = "Brigadegeneral der Allianz"
L["Horde Warbringer"] = "Kriegshetzer der Horde"
	L["Call to Arms: Alterac Valley"] = "Ruf zu den Waffen: Alteractal"
	L["Call to Arms: Arathi Basin"] = "Ruf zu den Waffen: Arathibecken"
	L["Call to Arms: Eye of the Storm"] = "Ruf zu den Waffen: Auge des Sturms"
	L["Call to Arms: Warsong Gulch"] = "Ruf zu den Waffen: Kriegshymnenschlucht"
L["Warrant Officer Tracy Proudwell"] = "Stabsfeldwebel Tracy Stolzbrunn"
L["Battlecryer Blackeye"] = "Kriegsherold Blauauge"
	L["Hellfire Fortifications"] = "H\195\182llenfeuerbefestigungen"

-- Options Table Locale
--General Titles
L["Sick Of Clicking Dailies?"] = true  ---- Addon Name used for Options table
L["NPC & Quest Options"] = "NPC & Quest Optionen"
L["NPC Enabled"] = "NPC aktiviert"
L["Addon Options"] = "Addon Optionen"
L["Enabled"] = "Aktiviert"
L["Enable Quest"] = "Aktiviere Quest"
L["Quest Reward"] = "Quest Belohnung"
L["None"] = "Keine"

L["Always Loop NPCs"] = "NPCs immer durchschalten"
L["Always Loop on the NPC from one quest to the next forever"] = "NPCs von einem zum n\195\164chsten Quest immer durchschalten"
L["Enable Gossip window"] = "Zeige Laber-Fenster"
L["Enable skipping the opening gossip text"] = "Laber-Fenster \195\188berspringen"
L["Enable Quest Text window"] = "Zeige Quest-Text-Fenster"
L["Enable skipping the Quest Descriptive text"] = "Quest-Text \195\188berspringen"
L["Enable Completion Gossip"] = "Laber-Queste komplettieren"
L["Enable skipping the Quest Completion question text"] = "Texte zum Beenden von Quests automatisch komplettieren"
L["Enable Quest Turn In"] = "Questabgabe aktivieren"
L["Enable skipping the actual turn in of the quest"] = "Abgabe der aktuellen Quest \195\188berspringen"

--Titles
L["Faction Grinds"] = "Fraktionen"
	L["Skyguard"] = "Himmelswache der Sha'tari"
		L["Blades Edge Mountains"] = "Schergrat"
		L["Skettis"] = "Skettis"
	L["Ogri'la"] = true
	L["Netherwing"] = "Netherschwingen"
		L["Netherwing - Neutral"] = "Netherschwingen - Neutral"
		L["Netherwing - Friendly"] = "Netherschwingen - Freundlich"
		L["Netherwing - Honored"] = "Netherschwingen - Wohlwollend"
		L["Netherwing - Revered"] = "Netherschwingen - Ehrf\195\188rchtig"
	--L["Shattered Sun Offensive"] = true
	L["Wintersaber Trainer"] = "Winters\195\164blerausbilder"

L["PvP"] = true
	L["Horde PvP"] = true
	L["Alliance PvP"] = "Allianz PvP"
	L["Battlegrounds"] = "Schlachtfelder"
	L["World PvP"] = "Open PvP"

L["Instance"] = "Instanz"
	L["Instance - Normal"] = "Instanz - Normal"
	L["Instance - Heroic"] = "Instanz - Heroisch"
		L["The Eye"] = "Das Auge"
		L["Serpentshrine Cavern"] = "H\195\182hle des Schlangenschreins"
		L["Hellfire Citadel"] = "H\195\182llenfeuerzitadelle"
		L["Caverns of Time"] = "H\195\182hlen der Zeit"
		L["Auchindoun"] = true

L["Cooking"] = "Kochen"
L["Fishing"] = "Fischen"
L["Profession"] = "Beruf"

--Special Tool Tips
L["This will toggle the quest on both Doryn and the Prisoner"] = "Diese Option schaltet beide Quests. Doryn und den Gefangenen."
L["|cffFF0000WARNING!!!|r, This Option also toggles both Scryer and Aldor Quests"] = "|cffFF0000WARNUNG!!!|r, Diese Option schaltet Seher und Aldor Quests ein"  ---Warning Color Code included in this string
L["\nAll Non-Heroic Quests are from |cff00ff00'Nether-Stalker Mah'duun'|r in LowerCity"] = "\nAlle non-heroic-Dailies von |cff00ff00'Netherpirscher Mah'duun'|r im unteren Viertel"
L["\nAll Heroic Dailies from |cff00ff00'Wind Trader Zhareem'|r in LowerCity"] = "\nAlle Heroic-Dailies von |cff00ff00'Windh\195\164ndler Zhareem'|r im unteren Viertel"

--Quest Options

L["Select what Potion you want for the 'Escape from Skettis' quest"] = "Welcher Trank soll als Questbelohnung f\195\188r 'Flucht aus Skettis' gew\195\164hlt werden?"
L["Health Potion"] = "Heiltrank"
L["Mana Potion"] = "Manatrank"
--L["Escort Quest Potion"] = ""
L["Barrel of Fish"] = "Fass mit Fischen"
L["Crate of Meat"] = "Kiste mit Fleisch"

end