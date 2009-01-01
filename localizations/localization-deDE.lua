--
--	General Localizations here
--
--	deDE translation provided by Sinxia, kunda

local L = LibStub("AceLocale-3.0"):NewLocale("SOCD_Core", "deDE")
if not L then return end

if L then
	L["Sick Of Clicking Dailies"] = true
	L["Module Control"] = "Einstellungen"
	L["PvP"] = PVP
	L["World PvP"] = "PvP im Freien"
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
	L["Horde"] = FACTION_HORDE
	L["Alliance"] = FACTION_ALLIANCE
	
	--Classic Section
	L["Classic WoW"] = true
	L["Wintersaber Trainers"] = "Wintersäbler Ausbilder"


	--BC Section
	L["Burning Crusade"] = true
		--Instances		Might include instance soft names here, but that would break some automagic stuff
	L["Instances"] = "Instanzen"
	L["Heroic Instances"] = "Heroische Instanzen"
		--Factions
	L["Sha'tari Skyguard"] = "Himmelswache der Sha'tari"
	L["Og'rila"] = "Og'rila"
	L["Netherwing"] = "Netherschwingen"
			--SSO
	L["Shattered Sun Offensive"] = "Offensive der Zerschmetterten Sonne"
	L["SSO Phase 1"] = "Sanktum der Sonnenweiten"
	L["SSO Phase 2a"] = "Waffenkammer der Sonnenweiten"
	L["SSO Phase 2b"] = "Sonnenbrunnenportal"
	L["SSO Phase 3a"] = "Hafen der Sonnenweiten"
	L["SSO Phase 3b"] = "Schmiede der Sonnenweiten"
	L["SSO Phase 4a"] = "Alchemielabor"
	L["SSO Phase 4b"] = "Denkmal"
	L["SSO Phase 4c"] = "Finale"
	L["SSO_MISC"] = "Offensive der Zerschmetterten Sonne: verschiedene Quests"
		--Professions
	L["Professions"] = TRADE_SKILLS
	L["Cooking"] = "Kochkunst"
	L["Fishing"] = "Angeln"
	L["Jewelcrafting"] = "Juwelenschleifen"

	--LichKing
	L["LK"] = "Lich King"
		--Factions
	L["The Wyrmrest Accord"] = "Der Wyrmruhpakt"
	L["Sholazar Basin"] = "Sholazarbecken"
	L["The Oracles"] = "Die Orakel"
	L["Frenzyheart Tribe"] = "Stamm der Wildherzen"
	L["The Sons of Hodir"] = "Die Söhne Hodirs"
	L["Argent Crusade"] = "Argentumkreuzzug"
	L["Knights of the Ebon Blade"] = "Ritter der Schwarzen Klinge"
	L["The Kalu'ak"] = "Die Kalu'ak"
	L["The Storm Peaks"] = "Die Sturmgipfel"

		--Misc Titles
	L["Shared Faction Quests"] = "Fraktionsübergreifende Quests"
	L["Icecrown"] = "Eiskrone"
	L["Grizzly Hills"] = "Grizzlyhügel"
	L["Wintergrasp"] = "Tausendwinter"
	L["Shared Quests"] = "Gemeinsame Quests"
	L["Icecrown Netural Quests"] = "Eiskrone neutrale Quests"
	L["Troll Patrol: "] = "Trollpatrouille: " --There is a space at the end, this is used to clip ugly quests.
	L["Shipment: "] = "Lieferung: " --There is also a space at the end of here..
	L["Proof of Demise: "] = "Todesbeweis: "
	L["Timear Foresees (.+) in your Future!"] = "Timear prophezeit (.+) in Eurer Zukunft!" --regex leave the (.+) in the middle there.
	L["Faction Token"] = "Belobigungsabzeichen"


end

--All Quests Classified by orgin / content location
--
--	Classic
--
--
local C = LibStub("AceLocale-3.0"):NewLocale("SOCD_Classic", "deDE")

if C then
--Wintersaber Trainer
	C["Frostsaber Provisions"] = "Frostsäblerverpflegung"
	C["Winterfall Intrusion"] = "Eindringlinge der Winterfelle"
	C["Rampaging Giants"] = "Tobende Riesen"

--PvP
	C["Call to Arms: Warsong Gulch"] = "Ruf zu den Waffen: Kriegshymnenschlucht"
	C["Call to Arms: Arathi Basin"] = "Ruf zu den Waffen: Arathibecken"
	C["Call to Arms: Alterac Valley"] = "Ruf zu den Waffen: Alteractal"
end	

--
--	TBC
--	

local BC = LibStub("AceLocale-3.0"):NewLocale("SOCD_BC", "deDE")

if BC then
--Skettis Dailies
	BC["Fires Over Skettis"] = "Feuer über Skettis"
	BC["Escape from Skettis"] = "Flucht aus Skettis"

--Blade's Edge Mountains
	BC["Wrangle More Aether Rays!"] = "Bändigt noch mehr Netherrochen!"
	BC["Bomb Them Again!"] = "Und wieder ein Bombenangriff!"
	BC["The Relic's Emanation"] = "Die Strahlung des Relikts"
	BC["Banish More Demons"] = "Bannt mehr Dämonen"
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
	BC["Disrupting the Twilight Portal"] = "Schwächt das Portal des Zwielichts"
	--Revered
	BC["The Deadliest Trap Ever Laid"] = "Die tödlichste Falle aller Zeiten"

--Shattered Sun Offensive
	--P1
	BC["Erratic Behavior"] = "Unberechenbares Verhalten"
	BC["The Sanctum Wards"] = "Die Barrieren des Sanktums"
	--P2a
	BC["Further Conversions"] = "Weitere Konvertierungen"
	BC["Arm the Wards!"] = "Fahrt die Barrieren hoch!"
	BC["The Battle for the Sun's Reach Armory"] = "Die Schlacht um die Waffenkammer der Sonnenweiten"
	BC["Distraction at the Dead Scar"] = "Ablenkungsmanöver an der Todesschneise"
	BC["Intercepting the Mana Cells"] = "Manazellen abfangen"
	--P2b
	BC["Maintaining the Sunwell Portal"] = "Das Sonnenbrunnenportal aufrechterhalten"
	BC["Know Your Ley Lines"] = "Kenne deine Leylinien"
	--P3a
	BC["The Battle Must Go On"] = "Die Schlacht muss weitergehen"
	BC["The Air Strikes Must Continue"] = "Die Luftangriffe müssen weitergehen"
	BC["Intercept the Reinforcements"] = "Haltet die Verstärkung auf"
	BC["Taking the Harbor"] = "Den Hafen einnehmen"
	BC["Making Ready"] = "Vorbereitungen"
	--P3b
	BC["Don't Stop Now...."] = "Hört jetzt nicht auf!"
	BC["Ata'mal Armaments"] = "Waffen von Ata'mal"
	--P4a
	BC["Keeping the Enemy at Bay"] = "Den Feind vom Leibe halten"
	BC["Crush the Dawnblade"] = "Vernichtet die Dämmerklingen"
	BC["Discovering Your Roots"] = "Die eigenen Wurzeln entdecken"
	BC["A Charitable Donation"] = "Eine milde Gabe"
	BC["Disrupt the Greengill Coast"] = "Belästigung an der Küste der Grünkiemen"
	--P4b
	BC["Your Continued Support"] = "Eure weitere Unterstützung"
	--P4c
	BC["Rediscovering Your Roots"] = "Eure Wurzeln wiederentdecken"
	BC["Open for Business"] = "Geschäft geöffnet"
	---Misc SSO Quests for Outland
	BC["The Multiphase Survey"] = "Die Multiphasen-Vermessung"
	BC["Blood for Blood"] = "Blut für Blut"
	BC["Blast the Gateway"] = "Vernichtet den Durchgang"
	BC["Sunfury Attack Plans"] = "Angriffspläne des Sonnenzorns"
	BC["Gaining the Advantage"] = "Einen Vorteil gewinnen"

--Professions - Cooking
	BC["Super Hot Stew"] = "Superheißes Ragout"
	BC["Soup for the Soul"] = "Suppe für die Seele"
	BC["Revenge is Tasty"] = "Rache ist schmackhaft"
	BC["Manalicious"] = "Manaziös"

--Professions - Fishing
	BC["Crocolisks in the City"] = "Krokilisken in der Stadt"
	BC["Bait Bandits"] = "Köderbanditen"
	BC["Felblood Fillet"] = "Teufelsblutfilet"
	BC["Shrimpin' Ain't Easy"] = "Garnelenfangen ist nicht einfach"
	BC["The One That Got Away"] = "Der Eine, der entkam"

---Non Heroic Instance
	BC["Wanted: Arcatraz Sentinels"] = "Gesucht: Schildwachen der Arkatraz"
	BC["Wanted: Coilfang Myrmidons"] = "Gesucht: Myrmidonen des Echsenkessels"
	BC["Wanted: Malicious Instructors"] = "Gesucht: Bösartige Ausbilderinnen"
	BC["Wanted: Rift Lords"] = "Gesucht: Fürsten der Zeitenrisse"
	BC["Wanted: Shattered Hand Centurions"] = "Gesucht: Zenturionen der Zerschmetterten Hand"
	BC["Wanted: Sunseeker Channelers"] = "Gesucht: Kanalisierer der Sonnensucher"
	BC["Wanted: Tempest-Forge Destroyers"] = "Gesucht: Zerstörer der Sturmschmiede"
	BC["Wanted: Sisters of Torment"] = "Gesucht: Schwestern der Qual"

--Heroic Instance	
	BC["Wanted: A Black Stalker Egg"] = "Gesucht: Ei der Schattenmutter"
	BC["Wanted: A Warp Splinter Clipping"] = "Gesucht: Warpzweigsplitter"
	BC["Wanted: Aeonus's Hourglass"] = "Gesucht: Aeonus' Stundenglas"
	BC["Wanted: Bladefist's Seal"] = "Gesucht: Messerfausts Siegel"
	BC["Wanted: Keli'dan's Feathered Stave"] = "Gesucht: Keli'dans gefiederter Stab"
	BC["Wanted: Murmur's Whisper"] = "Gesucht: Murmurs Flüstern"
	BC["Wanted: Nazan's Riding Crop"] = "Gesucht: Nazans Reitgerte"
	BC["Wanted: Pathaleon's Projector"] = "Gesucht: Pathaleons Projektionsgerät"
	BC["Wanted: Shaffar's Wondrous Pendant"] = "Gesucht: Shaffars wundersames Amulett"
	BC["Wanted: The Epoch Hunter's Head"] = "Gesucht: Der Kopf des Epochenjägers"
	BC["Wanted: The Exarch's Soul Gem"] = "Gesucht: Der Seelenedelstein des Exarchen"
	BC["Wanted: The Headfeathers of Ikiss"] = "Gesucht: Die Kopfschmuckfedern von Ikiss"
	BC["Wanted: The Heart of Quagmirran"] = "Gesucht: Das Herz von Quagmirran"
	BC["Wanted: The Scroll of Skyriss"] = "Gesucht: Horizontiss' Schriftrolle"
	BC["Wanted: The Warlord's Treatise"] = "Gesucht: Die Aufzeichnungen des Kriegsherren"
	BC["Wanted: The Signet Ring of Prince Kael'thas"] = "Gesucht: Der Siegelring von Prinz Kael'thas"

--PvP
	----World PvP
	--HellFire
	BC["Hellfire Fortifications"] = "Höllenfeuerbefestigungen"
	--Auchindoun
	BC["Spirits of Auchindoun"] = "Geister von Auchindoun"
	--Nagrand / Halla
	BC["Enemies, Old and New"] = "Feinde - alte und neue"	--Horde
	BC["In Defense of Halaa"] = "Zur Verteidigung von Halaa" --Alliance
	----Battlegrounds
	BC["Call to Arms: Eye of the Storm"] = "Ruf zu den Waffen: Auge des Sturms"
end

--
--	WOTLK
--	
local LK = LibStub("AceLocale-3.0"):NewLocale("SOCD_LK", "deDE")

if LK then
	--Instance Dailies
	LK["All Things in Good Time"] = "Alles zu seiner Zeit"
		--Heroics
	LK["Proof of Demise: Anub'arak"] = "Todesbeweis: Anub'arak"
	LK["Proof of Demise: Cyanigosa"] = "Todesbeweis: Cyanigosa"
	LK["Proof of Demise: Gal'darah"] = "Todesbeweis: Gal'darah"
	LK["Proof of Demise: Herald Volazj"] = "Todesbeweis: Herold Volazj"
	LK["Proof of Demise: Ingvar the Plunderer"] = "Todesbeweis: Ingvar der Brandschatzer"
	LK["Proof of Demise: Keristrasza"] = "Todesbeweis: Keristrasza"
	LK["Proof of Demise: King Ymiron"] = "Todesbeweis: König Ymiron"
	LK["Proof of Demise: Ley-Guardian Eregos"] = "Todesbeweis: Leywächter Eregos"
	LK["Proof of Demise: Loken"] = "Todesbeweis: Loken"
	LK["Proof of Demise: Mal'Ganis"] = "Todesbeweis: Mal'Ganis"
	LK["Proof of Demise: Sjonnir The Ironshaper"] = "Todesbeweis: Sjonnir der Eisenformer"
	LK["Proof of Demise: The Prophet Tharon'ja"] = "Todesbeweis: Der Prophet Tharon'ja"
		--Non Heroics
	LK["Timear Foresees Centrifuge Constructs in your Future!"] = "Timear prophezeit Zentrifugenkonstrukte in Eurer Zukunft!"
	LK["Timear Foresees Infinite Agents in your Future!"] = "Timear prophezeit Ewige Agenten in Eurer Zukunft!"
	LK["Timear Foresees Titanium Vanguards in your Future!"] = "Timear prophezeit Titanvorposten in Eurer Zukunft!"
	LK["Timear Foresees Ymirjar Berserkers in your Future!"] = "Timear prophezeit Berserker von Ymirjar in Eurer Zukunft!"

	--Professions
		--Cooking
	LK["Cheese for Glowergold"] = "Käse für Leuchtegold"
	LK["Convention at the Legerdemain"] = "Versammlung am Zauberkasten"
	LK["Infused Mushroom Meatloaf"] = "Energieerfüllter Pilzhackbraten"
	LK["Mustard Dogs!"] = "Senfwürstchen!"
	LK["Sewer Stew"] = "Kanaleintopf"
		--Jewlcrafting
	LK["Shipment: Blood Jade Amulet"] = "Lieferung: Blutrotes Nephritamulett"
	LK["Shipment: Bright Armor Relic"] = "Lieferung: Helles Rüstungsrelikt"
	LK["Shipment: Glowing Ivory Figurine"] = "Lieferung: Leuchtende Elfenbeinfigur"
	LK["Shipment: Intricate Bone Figurine"] = "Lieferung: Aufwändige Knochenfigur"
	LK["Shipment: Shifting Sun Curio"] = "Lieferung: Veränderliche Sonnenkuriosität"
	LK["Shipment: Wicked Sun Brooch"] = "Lieferung: Tückische Sonnenbrosche"

	--Factions
		--The Wyrmrest Accord
	LK["Aces High!"] = "Schlacht in den Wolken"
	LK["Drake Hunt"] = "Drachenjagd"
	LK["Defending Wyrmrest Temple"] = "Verteidigt den Wyrmruhtempel"

		--The Oracles
	LK["A Cleansing Song"] = "Ein reinigendes Lied"
	LK["Appeasing the Great Rain Stone"] = "Besänftigung des großen Regensteins"
	LK["Hand of the Oracles"] = "Hand der Orakel"
	LK["Mastery of the Crystals"] = "Beherrschen der Kristalle"
	LK["Power of the Great Ones"] = "Macht der Großen"
	LK["Song of Fecundity"] = "Lied der Fruchtbarkeit"
	LK["Song of Reflection"] = "Lied der Besinnung"
	LK["Song of Wind and Water"] = "Lied von Wind und Wasser"
	LK["Will of the Titans"] = "Wille der Titanen"

		--Frenzyheart Tribe
	LK["A Hero's Headgear"] = "Des Helden Helm"
	LK["Chicken Party!"] = "Hühnerparty!"
	LK["Frenzyheart Champion"] = "Champion der Wildherzen"
	LK["Kartak's Rampage"] = "Kartaks Wut"
	LK["Rejek: First Blood"] = "Rejek: Erstes Blut"
	LK["Secret Strength of the Frenzyheart"] = "Geheime Kraft der Wildherzen"
	LK["Strength of the Tempest"] = "Kraft des Sturms"
	LK["The Heartblood's Strength"] = "Des Herzbluts Stärke"
	LK["Tools of War"] = "Instrument des Krieges"

		--The Sons of Hodir
	LK["Blowing Hodir's Horn"] = "Hodirs Horn blasen"
	LK["Hodir's Horn"] = "Hodirs Horn"	--object Name

	LK["Feeding Arngrim"] = "Arngrim füttern"
	LK["Arngrim the Insatiable"] = "Arngrimm der Unersättliche"	--object Name

	LK["Hot and Cold"] = "Heiß und kalt"
	LK["Fjorn's Anvil"] = "Fjorns Amboss"	--object name


	LK["Polishing the Helm"] = "Den Helm polieren"
	LK["Hodir's Helm"] = "Hodirs Helm"	--object Name

	LK["Spy Hunter"] = "Jagd auf Spione"

	LK["Thrusting Hodir's Spear"] = "Hodirs Speer werfen"
	LK["Hodir's Spear"] = "Hodirs Speer"	--object Name

		--Argent Crusade
	LK["The Alchemist's Apprentice"] = "Der Lehrling des Alchemisten"
	LK["Troll Patrol"] = "Trollpatrouille"
	LK["Troll Patrol: Can You Dig It?"] = "Trollpatrouille: Könnt Ihrs aushalten?"
	LK["Troll Patrol: Couldn't Care Less"] = "Trollpatrouille: Juckt mich kein bisschen"
	LK["Troll Patrol: Creature Comforts"] = "Trollpatrouille: Annehmlichkeiten"
	LK["Troll Patrol: Done to Death"] = "Trollpatrouille: todsicher gehen"
	LK["Troll Patrol: High Standards"] = "Trollpatrouille: Standarten hoch"
	LK["Troll Patrol: Intestinal Fortitude"] = "Trollpatrouille: Starker Magen"
	LK["Troll Patrol: Something for the Pain"] = "Trollpatrouille: Etwas gegen die Schmerzen"
	LK["Troll Patrol: The Alchemist's Apprentice"] = "Trollpatrouille: Der Lehrling des Alchemisten"
	LK["Troll Patrol: Throwing Down"] = "Trollpatrouille: Werfen"
	LK["Troll Patrol: Whatdya Want, a Medal?"] = "Trollpatrouille: Was wollt Ihr - ne Medaille?"
	LK["Congratulations!"] = "Herzlichen Glückwunsch!"

		--Knights of the Ebon Blade
	LK["Intelligence Gathering"] = "Informationsbeschaffung"
	LK["Leave Our Mark"] = "Setzt ein Zeichen"
	LK["No Fly Zone"] = "Flugsperrzone"
	LK["From Their Corpses, Rise!"] = "Erhebt euch von den Toten!"
	LK["Shoot 'Em Up"] = "Schießt sie ab!"
	LK["Vile Like Fire!"] = "Ekel mag Feuer!"

		--The Kalu'ak
	LK["Planning for the Future"] = "Zukunftsplanungen"
	LK["Preparing for the Worst"] = "Auf das Schlimmste gefasst sein"
	LK["The Way to His Heart..."] = "Der Weg zu seinem Herzen..."

		--The Frostborn
	LK["Pushed Too Far"] = "Zu weit getrieben"

	----Horde Expedition / --Alliance Vanguard
		--These are shared quests for the given zone
		--IceCrown
	LK["King of the Mountain"] = "König der Berge"	--Neutral
	LK["Blood of the Chosen"] = "Blut der Auserwählten"	--Neutral
	LK["Drag and Drop"] = "Ziehen und ablegen"	--Neutral
	LK["Neutralizing the Plague"] = "Die Seuche neutralisieren"	--Neutral
	LK["No Rest For The Wicked"] = "Die Boshaften haben nicht Frieden"	--Neutral -- __________NEEDS_CHECK__________
	LK["Not a Bug"] = "Keine Wanze"	--Neutral
	LK["Retest Now"] = "Jetzt neu testen"	--Neutral
	LK["Slaves to Saronite"] = "Vom Saronit abhängig"	--Neutral
	LK["That's Abominable!"] = "Das ist monströs!"	--Neutral
	LK["Static Shock Troops: the Bombardment"] = "Statische Schocktruppen: das Bombardement"	--Alliance
	LK["Total Ohmage: The Valley of Lost Hope!"] = "Totale Vernichtung: Das Tal der Verlorenen Hoffnung!"	--Horde
	LK["The Solution Solution"] = "Die Lösungslösung"	--Alliance
	LK["Volatility"] = "Verflüchtigung"	--Horde
	LK["Capture More Dispatches"] = "Capture More Dispatches TODO"	--Alliance -- __________TODO__________
	LK["Keeping the Alliance Blind"] = "Keeping the Alliance Blind TODO"	--Horde -- __________TODO__________
	LK["Putting the Hertz: The Valley of Lost Hope"] = "Mission mit Hertz: Das Tal der Verlorenen Hoffnung"	--Alliance
	LK["Riding the Wavelength: The Bombardment"] = "Auf derselben Wellenlänge: Das Bombardement"	--Horde

		--Grizzly Hills
	LK["Life or Death"] = "Leben oder Tod"	--Alliance
	LK["Overwhelmed!"] = "Überfordert!"	--Horde
	LK["Making Repairs"] = "Reparaturen"	--Horde
	LK["Pieces Parts"] = "Verbreitet die guten Ersatzteile"	--Alliance
	LK["Keep Them at Bay"] = "Nehmt die Bucht ein"	--Neutral
	LK["Riding the Red Rocket"] = "Ritt auf der roten Rakete"	--Neutral
	LK["Seared Scourge"] = "Die angesengte Geißel"	--Neutral
	LK["Smoke 'Em Out"] = "Räuchert sie aus"	--Neutral

		--The Storm Peaks
	LK["Back to the Pit"] = "Zurück in die Grube"
	LK["Defending Your Title"] = "Euren Titel verteidigen"
	LK["Overstock"] = "Überbestand"
	LK["Maintaining Discipline"] = "Disziplin bewahren"
	LK["The Aberrations Must Die"] = "Die Missgeburten müssen sterben"


		--World PvP
		--These Quests Specificlally flag you as PvP Active
		--Wintergrasp Fortress
	LK["A Rare Herb"] = "Ein seltenes Kraut"
	LK["Bones and Arrows"] = "Pfeil und Knochen"
	LK["Defend the Siege"] = "Belagerungsmaschinen verteidigen"
	LK["Fueling the Demolishers"] = "Verwüster auftanken"
	LK["Healing with Roses"] = "Mit Rosen heilen"
	LK["Jinxing the Walls"] = "Die Mauern verhexen"
	LK["No Mercy for the Merciless"] = "Keine Gnade für die Gnadenlosen"
	LK["Slay them all"] = "Tötet sie alle!"
	LK["Stop the Siege"] = "Setzt der Belagerung ein Ende"
	LK["Victory in Wintergrasp"] = "Sieg in Tausendwinter"
	LK["Warding the Walls"] = "Die Wälle schützen"
	LK["Warding the Warriors"] = "Die Krieger schützen"

		--BattleGround
	LK["Call to Arms: Strand of the Ancients"] = "Ruf zu den Waffen: Strand der Uralten"

		--IceCrown
	LK["Make Them Pay!"] = "Sie müssen zahlen!"	--Horde
	LK["Shred the Alliance"] = "Schreddert die Allianz"	--Horde
	LK["No Mercy!"] = "Keine Gnade!"	--Alliance
	LK["Shredder Repair"] = "Schredder reparieren"	--Alliance

		--Grizzly Hills
	LK["Keep Them at Bay"] = "Nehmt die Bucht ein"	--Neutral
	LK["Riding the Red Rocket"] = "Ritt auf der roten Rakete"	--Neutral
	LK["Seared Scourge"] = "Die angesengte Geißel"	--Neutral
	LK["Smoke 'Em Out"] = "Räuchert sie aus"	--Neutral

	LK["Down With Captain Zorna!"] = "Nieder mit Kapitän Zorna!"	--Alliance
	LK["Kick 'Em While They're Down"] = "Tritt rein, solang' sie am Boden liegen"	--Alliance
	LK["Blackriver Skirmish"] = "Gemetzel am Schwarzwasser"	--Alliance

	LK["Crush Captain Brightwater!"] = "Zerschmettert Kapitän Hellwasser!"	--Horde
	LK["Keep 'Em on Their Heels"] = "Haltet sie auf Trab"	--Horde
	LK["Blackriver Brawl"] = "Keilerei in Schwarzwasser"	--Horde


	--Misc
		--Howling Fjord
	LK["Break the Blockade"] = "Durchbrecht die Blockade"	--Alliance
	LK["Steel Gate Patrol"] = "Patrouille am Stählernen Tor"	--Alliance

end
