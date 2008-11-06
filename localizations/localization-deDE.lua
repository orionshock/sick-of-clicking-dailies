--
--	General Localizations here
--
-- deDE translation provided by Sinxia

local L = LibStub("AceLocale-3.0"):NewLocale("SOCD_Core", "deDE")
if not L then return end

if L then
	L["Sick Of Clicking Dailies"] = true
	L["Module Control"] = "Einstellungen"
	L["PvP"] = PVP
	L["World PvP"] = true
	L["Battlegrounds"] = BATTLEFIELDS
	L["Netural"] = FACTION_STANDING_LABEL4
	L["Friendly"] = FACTION_STANDING_LABEL5
	L["Honored"] = FACTION_STANDING_LABEL6
	L["Revered"] = FACTION_STANDING_LABEL7
	L["Faction"] = FACTION
	L["None"] = LFG_TYPE_NONE
	L["Quest Rewards"] = "Questbelohnungen"
	L["Quests"] = QUESTS_LABEL
	L["Wanted: "] = "Gesucht: "		--Used in Instance quest for dsplay...
	

	--Classic Section
	L["Classic WoW"] = true
	L["Wintersaber Trainers"] = "Winters\195\164bler Ausbilder"


	--BC Section
	L["Burning Crusade"] = true
		--Instances		Might include instance soft names here, but that would break some automagic stuff
	L["Instances"] = "Instanzen"
	L["Heroic Instances"] = "heroische Instanzen"
		--Factions
	L["Sha'tari Skyguard"] = "Himmelswache der Sha'tari"
	L["Og'rila"] = true
	L["Netherwing"] = "Netherschwingen"
			--SSO
	L["Shattered Sun Offensive"] = "Offensive der Zerschmetterten Sonne"
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
	L["Cooking"] = "Kochkunst"
	L["Fishing"] = "Angeln"
end

--All Quests Classified by orgin / content location
--
--	Classic
--
--
local C = LibStub("AceLocale-3.0"):NewLocale("SOCD_Classic", "deDE")

if C then
--Wintersaber Trainer
	C["Frostsaber Provisions"] = "Frosts\195\164blerverpflegung"
	C["Winterfall Intrusion"] = "Eindringlinge der Winterfelle"
	C["Rampaging Giants"] = "Tobende Riesen"

--PvP
	C["Call to Arms: Alterac Valley"] = "Ruf zu den Waffen: Alteractal"
	C["Call to Arms: Arathi Basin"] = "Ruf zu den Waffen: Arathibecken"
	C["Call to Arms: Warsong Gulch"] = "Ruf zu den Waffen: Kriegshymnenschlucht"
end	

--
--	TBC
--	

local BC = LibStub("AceLocale-3.0"):NewLocale("SOCD_BC", "deDE")

if BC then
--Skettis Dailies
	BC["Fires Over Skettis"] = "Feuer \195\188ber Skettis"
	BC["Escape from Skettis"] = "Flucht aus Skettis"

--Blade's Edge Mountains
	BC["Wrangle More Aether Rays!"] = "B\195\164ndigt noch mehr \195\132therrochen!"
	BC["Bomb Them Again!"] = "Und wieder ein Bombenangriff!"
	BC["The Relic's Emanation"] = "Die Strahlung des Relikts"
	BC["Banish More Demons"] = "Bannt mehr D\195\164monen"
--Netherwing
	--Netrual
	BC["Nethercite Ore"] = "Netheriterz"
	BC["Netherdust Pollen"] = "Netherstaubpollen"
	BC["Nethermine Flayer Hide"] = "Balg eines Netherminenschinders"
	BC["Netherwing Crystals"] = "Kristalle der Netherschwingen"
	BC["The Not-So-Friendly Skies..."] = "Ein Schatten am Horizont"
	BC["A Slow Death"] = "Ein langsamer Tod"
	--Friendly
	BC["Picking Up The Pieces..."] = "Die Dinge in den Griff bekommen..."
	BC["Dragons are the Least of Our Problems"] = "Drachen sind unsere geringste Sorge"
	BC["The Booterang: A Cure For The Common Worthless Peon"] = "Der Schuhmerang: Das Mittel gegen den wertlosen Peon"
	--Honored
	BC["Disrupting the Twilight Portal"] = "Schw\195\164cht das Portal des Zwielichts"
	--Revered
	BC["The Deadliest Trap Ever Laid"] = "Die t\195\182dlichste Falle aller Zeiten"

--Shattered Sun Offensive
	--P1
	BC["Erratic Behavior"] = "Unberechenbares Verhalten"
	BC["The Sanctum Wards"] = "Die Barrieren des Sanktums"
	--P2a
	BC["Further Conversions"] = "Weitere Konvertierungen"
	BC["Arm the Wards!"] = "Fahrt die Barrieren hoch!"
	BC["The Battle for the Sun's Reach Armory"] = "Die Schlacht um die Waffenkammer der Sonnenweiten"
	BC["Distraction at the Dead Scar"] = "Ablenkungsman\195\182ver an der Todesschneise"
	BC["Intercepting the Mana Cells"] = "Manazellen abfangen"
	--P2b
	BC["Maintaining the Sunwell Portal"] = "Das Sonnenbrunnenportal aufrechterhalten"
	BC["Know Your Ley Lines"] = "Kenne deine Leylinien"
	--P3a
	BC["The Battle Must Go On"] = "Die Schlacht muss weitergehen"
	BC["The Air Strikes Must Continue"] = "Die Luftangriffe m\195\188ssen weitergehen"
	BC["Intercept the Reinforcements"] = "Haltet die Verst\195\164rkung auf"
	BC["Taking the Harbor"] = "Den Hafen einnehmen"
	BC["Making Ready"] = "Vorbereitungen"
	--P3b
	BC["Don't Stop Now...."] = "H\195\182rt jetzt nicht auf!"
	BC["Ata'mal Armaments"] = "Waffen von Ata'mal"
	--P4a
	BC["Keeping the Enemy at Bay"] = "Den Feind vom Leibe halten"
	BC["Crush the Dawnblade"] = "Vernichtet die D\195\164mmerklingen"
	BC["Discovering Your Roots"] = "Die eigenen Wurzeln entdecken"
	BC["A Charitable Donation"] = "Eine milde Gabe"
	BC["Disrupt the Greengill Coast"] = "Bel\195\164stigung an der K\195\188ste der Gr\195\188nkiemen"
	--P4b
	BC["Your Continued Support"] = "Eure weitere Unterst\195\188tzung"
	--P4c
	BC["Rediscovering Your Roots"] = "Eure Wurzeln wiederentdecken"
	BC["Open for Business"] = "Gesch\195\164ft ge\195\182ffnet"
	---Misc SSO Quests for Outland
	BC["The Multiphase Survey"] = "Die Multiphasen-Vermessung"
	BC["Blood for Blood"] = "Blut f\195\188r Blut"
	BC["Blast the Gateway"] = "Vernichtet den Durchgang"
	BC["Sunfury Attack Plans"] = "Angriffspl\195\164ne des Sonnenzorns"
	BC["Gaining the Advantage"] = "Einen Vorteil gewinnen"

--Professions - Cooking
	BC["Super Hot Stew"] = "Superhei\195\159es Ragout"
	BC["Soup for the Soul"] = "Suppe f\195\188r die Seele"
	BC["Revenge is Tasty"] = "Rache ist schmackhaft"
	BC["Manalicious"] = "Manazi\195\182s"

--Professions - Fishing
	BC["Crocolisks in the City"] = "Krokilisken in der Stadt"
	BC["Bait Bandits"] = "K\195\182derbanditen"
	BC["Felblood Fillet"] = "Teufelsblutfilet"
	BC["Shrimpin' Ain't Easy"] = "Garnelenfangen ist nicht einfach"
	BC["The One That Got Away"] = "Der Eine, der entkam"

---Non Heroic Instance
	BC["Wanted: Arcatraz Sentinels"] = "Gesucht: Schildwachen der Arkatraz"
	BC["Wanted: Coilfang Myrmidons"] = "Gesucht: Myrmidonen des Echsenkessels"
	BC["Wanted: Malicious Instructors"] = "Gesucht: B\195\182sartige Ausbilderinnen"
	BC["Wanted: Rift Lords"] = "Gesucht: F\195\188rsten der Zeitenrisse"
	BC["Wanted: Shattered Hand Centurions"] = "Gesucht: Zenturionen der Zerschmetterten Hand"
	BC["Wanted: Sunseeker Channelers"] = "Gesucht: Kanalisierer der Sonnensucher"
	BC["Wanted: Tempest-Forge Destroyers"] = "Gesucht: Zerst\195\182rer der Sturmschmiede"
	BC["Wanted: Sisters of Torment"] = "Gesucht: Schwestern der Qual"

--Heroic Instance	
	BC["Wanted: A Black Stalker Egg"] = "Gesucht: Ei der Schattenmutter"
	BC["Wanted: A Warp Splinter Clipping"] = "Gesucht: Warpzweigsplitter"
	BC["Wanted: Aeonus's Hourglass"] = "Gesucht: Aeonus' Stundenglas"
	BC["Wanted: Bladefist's Seal"] = "Messerfausts Siegel"
	BC["Wanted: Keli'dan's Feathered Stave"] = "Gesucht: Keli'dans gefiederter Stab"
	BC["Wanted: Murmur's Whisper"] = "Gesucht: Murmurs Fl\195\188stern"
	BC["Wanted: Nazan's Riding Crop"] = "Gesucht: Nazans Reitgerte"
	BC["Wanted: Pathaleon's Projector"] = "Gesucht: Pathaleons Projektionsger\195\164t"
	BC["Wanted: Shaffar's Wondrous Pendant"] = "Gesucht: Shaffars wundersames Amulett"
	BC["Wanted: The Epoch Hunter's Head"] = "Gesucht: Der Kopf des Epochenj\195\164gers"
	BC["Wanted: The Exarch's Soul Gem"] = "Gesucht: Der Seelenedelstein des Exarchen"
	BC["Wanted: The Headfeathers of Ikiss"] = "Gesucht: Die Kopfschmuckfedern von Ikiss"
	BC["Wanted: The Heart of Quagmirran"] = "Gesucht: Das Herz von Quagmirran"
	BC["Wanted: The Scroll of Skyriss"] = "Gesucht: Horizontiss' Schriftrolle"
	BC["Wanted: The Warlord's Treatise"] = "Gesucht: Die Aufzeichnungen des Kriegsherren"
	BC["Wanted: The Signet Ring of Prince Kael'thas"] = "Gesucht: Der Siegelring von Prinz Kael'thas"

--PvP
	----World PvP
	--HellFire
	BC["Hellfire Fortifications"] = "H\195\182llenfeuerbefestigungen"
	--Auchindoun
	BC["Spirits of Auchindoun"] = "Geister von Auchindoun"
	--Nagrand / Halla
	BC["Enemies, Old and New"] = "Feinde - alte und neue"
	BC["In Defense of Halaa"] = "Zur Verteidigung von Halaa"
	----Battlegrounds
	BC["Call to Arms: Eye of the Storm"] = "Ruf zu den Waffen: Auge des Sturms"
end

--
--	WOTLK
--	
local LK = LibStub("AceLocale-3.0"):NewLocale("SOCD_LK", "deDE")

if LK then
	LK["test"] = "test"
end
