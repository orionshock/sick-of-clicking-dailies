--
--	Wrath of the Lich King Module
--
--
--
local AddonParent = LibStub("AceAddon-3.0"):GetAddon("SickOfClickingDailies")

local D		--Basic Debug
do
	local str = ""
	function D(arg, ...)
		str = ""
		if type(arg) == "string" and string.find(arg, "%%") then
			str = arg:format(...)
		else
			str = string.join(", ", tostringall(arg, ...) )
			str = str:gsub(":,", ":"):gsub("=,", "=")
		end
		if AddonParent.db and AddonParent.db.profile.debug then		
			print("SOCD-LK: "..str)
		end
		return str
	end
end

do
	local fr = ("$Rev$"):match("%d+") or 0
	local cr = (AddonParent.version):match("%d+") or 1
	if fr > cr then
		AddonParent.version = ("$Rev$")
	end

end
local module = AddonParent:NewModule("LK")
local L = LibStub("AceLocale-3.0"):GetLocale("SOCD_Core")
local LQ = LibStub("AceLocale-3.0"):GetLocale("SOCD_LK")
local db, qTable = nil, AddonParent.qTable

module.defaults = {
	profile = {
		--This Table will get auto gened by the next block from the locale data
		qOptions = {
			--["*"] = 3,
			--This section has to be manually set with the localized quest name and a default option of off
			--not very many of these quests so it won't matter :D
			--Instance non-Heroic
			[LQ["Timear Foresees Centrifuge Constructs in your Future!"]] = 5,
			[LQ["Timear Foresees Infinite Agents in your Future!"]] = 5,
			[LQ["Timear Foresees Titanium Vanguards in your Future!"]] = 5,
			[LQ["Timear Foresees Ymirjar Berserkers in your Future!"]] = 5,
			--Argent Tournament
			[LQ["Among the Champions"]] = 5,
			[LQ["Battle Before The Citadel"]] = 5,
			[LQ["Taking Battle To The Enemy"]] = 5,
			[LQ["Threat From Above"]] = 5,

		},
		quests = {},
		gossip = {
			--["Tell me of yourself, Xarantaur. Why are you called the Witness?"] = true,
			[LQ["I'm ready to begin. What is the first ingredient you require?"]] = true,
			[LQ["Get out there and make those Scourge wish they were never reborn!"]] = true,
		}
	},
}
do
	local profile = module.defaults.profile.quests
	for k,v in pairs(LQ) do
		profile[v] = true
	end
	profile[ LQ["Hand of the Oracles"] ] = false		--Disabled on good authority by
	profile[ LQ["Frenzyheart Champion"] ] = false		-- "Fisker-" in IRC
	profile[ LQ["Contributin' To The Cause"] ] = false
end


function module:OnInitialize()
	--D("OnInit")
	db = AddonParent.db:RegisterNamespace("LK", module.defaults)
	self.db = db
end

function module:OnEnable()
	--D("OnEnable")
	AddonParent:RegisterQuests("LK", db.profile.quests, self.npcList, db.profile.qOptions, db.profile.gossip)
	SetItemRef("item:43950", "item:43950")	--Kirin Tor Faction Token
	SetItemRef("item:43950", "item:43950")
	
	SetItemRef("item:44711", "item:44711")	--Argetn Crusade Toeken
	SetItemRef("item:44711", "item:44711")

	SetItemRef("item:44713", "item:44713")	--Ebobn Blade
	SetItemRef("item:44713", "item:44713")

	SetItemRef("item:44710", "item:44710")	--wyrmrest
	SetItemRef("item:44710", "item:44710")

	SetItemRef("item:46114", "item:46114")	--Champion's Writ
	SetItemRef("item:46114", "item:46114")

	SetItemRef("item:45724", "item:45724")	--Champion's Purse
	SetItemRef("item:45724", "item:45724")
end

function module:OnDisable()
	--D("OnDisable")
	AddonParent:UnRegisterQuests("LK")
end

module.npcList = table.concat({
		-----INSTANCES-----
	26653,  --Kilix the Unraveler
		---Heroics---
	20735, --Archmage Lan'dalock
		---Non-Heroics---
	31439, --Archmage Timear

	-------PROFESSIONS-----
		---Cooking---
	29631, --Awilo Lon'gomba
	28718, --Ranid Glowergold
	28705, --Katherine Lee
	29049, --Arille Azuregaze
	29527, --Orton Bennet
	28160, --Archmage Pentarus
	29532, --Ajay Green

		---Jewlcrafting----
	28701, --Timothy Jones
		---Fishing---
	28742, --Marcia Chase

	-------FACTIONS-----
		---The, --Wyrmrest Accord---
	32548, --Corastrasza
	26117, --Raelorasz
	27575, --Lord Afrasastrasz

		---The Oracles---
	28027, --High-Oracle Soo-say
	29006, --Oracle Soo-nee
	29149, --Oracle Soo-dow
	28107, --Lightningcaller Soo-met
	28667, --Jaloot

		---Frenzyheart Tribe---
	29043, --Rejek
	28138, --Elder Harkek
	28216, --Zepik the Gorloc Hunter
	29146, --Vekgar
	28106, --Shaman Jakjek

		---The Sons of Hodir 
	--Ok these quest might not be so automagic, unless you can target the object..
	--o:192078, --Hodir's Horn
	LQ["Hodir's Horn"],
	--o:192524, --Arngrim the Insatiable
	LQ["Arngrim the Insatiable"],
	--o:192071, --Fjorn's Anvil
	LQ["Fjorn's Anvil"],
	--o:192080, --Hodir's Helm
	LQ["Hodir's Helm"],
	--o:192079, --Hodir's Spear
	LQ["Hodir's Spear"],
	30294, --  Frostworg Denmother

		---Argent Crusade---
	28039, --Commander Kunz

	28043, --Captain Grondel
	28042, --Captain Brandon
	28044, --Captain Rupert
	28205, --Alchemist Finklestein
	28090, --Crusade Recruit

		---Knights of the Ebon Blade---
	29456, --Aurochs Grimbane
	29343, --Baron Sliver
	29405, --Uzo Deathcaller
	29396, --Setaal Darkmer
	30074, --The Leaper
	30216, --Vile

		---The Kalu'ak---
	26228, --Trapper Mau'i
	26213, --Utaik
	24810, --Anuniaq

		---The Frostborn---
	29732, --Fjorlin Frostbrow 

	-------ZONE QUESTS-----
		---IceCrown---
	31776, --Frazzle Geargrinder
	31781, --Blast Thunderbomb
	32302, --Knight-Captain Droche
	32301, --Warbringer Davos
	29795, --Koltira Deathweaver
	29799, --Thassarian
	30825, --Chief Engineer Copperclaw 
	30345, --Chief Engineer Boltwrench 
	31261, --Brother Keltan 
	31259, --Absalan the Pious 
	32444, --Kibli Killohertz 
	32430, --Fringe Engineer Tezzla 
	30345, --Chief Engineer Boltwrench 
	30825, --Chief Engineer Copperclaw 
	30344, --High Captain Justin Bartlett 
	30824, --Sky-Reaver Korm Blackscar
	31833, --Kor'kon Squad Leader
	31834, --Ground Commander Xutjja
	31808, --Ground Commander Koup
	31737, --Skybreaker Squad Leader
			--IceCrown - Argent Crusade Torny

	33435,	--Bozzle Blastbolt
	33434,	--Bezzle Blastbolt
	-----Tourny NPCS	--I hate this...
	--Horde	
	--Sunreavers
	33542, 	--Magister Edien Sunhollow"
	33658, 	--Amariel Sunsworn"
	33659, 	--Galathia Brightdawn"
	--SilverWing
	33379, 	--Eressea Dawnsinger"
	33538, 	--Kethiel Sunlance"
	33548, 	--Aneera Thuron"
	--Undercity
	33373, 	--Deathstalker Visceri"
	33541, 	--Sarah Chalke"
	33547, 	--Handler Dretch"
	--Orgrimar
	33361, 	--Mokra the Skullcrusher"
	33405, 	--Akinos"
	33544, 	--Morah Worgsister"
	--Thunder Bluff
	33403, 	--Runok Wildmane"
	33539, 	--Dern Ragetotem"
	33549, 	--Anka Clawhoof"
	--Sen'Jin (Trolls)
	33372, 	--Zul'tore"
	33540, 	--Shadow Hunter Mezil-kree"
	33545, 	--Gahju"
	--Alliance
	--The Silver Covenant
	33646, --Avareth Swiftstrike
	33625, --Arcanist Taelis
	33647, --Scout Shalyndria
	--Exodar
	33655, --Saandos
	33593, --Colosos
	33656, --Ranii
	--Darnassus
	33652, --Illestria Bladesinger
	33592, --Jaelyne Evensong
	33654, --Airae Starseeker
	--Stormwind
	33222, --Sir Marcus Barlowe
	33225, --Marshal Jacob Alerius
	33223, --Captain Joseph Holley
	--Ironforge
	33315, --Rollo Sureshot
	33312, --Lana Stouthammer
	33309, --Clara Tumblebrew
	--Gnomeregan Exiles
	33648, --Tickin Gearspanner
	33335, --Ambrose Boltspark
	33649, --Flickin Gearspanner
	--Ebon Hold
	33770, 	--"Illyrie Nightfall"
	33762,	--"Crok Scourgebane"
	33769,	--"Zor'be the Bloodletter"
	--Argent Crusade
	33771, 	--"Luuri"
	33759, 	--"Eadric the Pure", nil
	33763, 	--"Cellian Daybreak", nil
	34210, --Squire Artie
	
-------------------------------------------
		---Grizzly Hills---
	27484, --Rheanna 
	27464, --Aumana 
	27416, --Pipthwack 
	27422, --Lurz 
	27423, --Grekk 
	27371, --Synipus 
	26604, --Mack Fearsen

		---The, --Storm Peaks--- --Faction Netural--
	29796, --Gretta the Arbiter
	29428, --Ricket

		---Howling, --Fjord--- (Alliance Only)
	23895, --Bombardier Petrov 
	24399, --Steel Gate Chief Archaeologist 

	-------PvP----- 
		---Wintergrasp Fortress---
	31054, --Anchorite Tessa 
	31053, --Primalist Mulfort 
	31052, --Bowyer Randolph 
	31102, --Vieron Blazefeather  
	31109, --Senior Demolitionist Legoso 
	31107, --Lieutenant Murp  
	31108, --Siege Master Stouthandle  
	31036, --Commander Zanneth  
	31091, --Commander Dardosh  
	31106, --Siegesmith Stronghoof  
	31153, --Tactical Officer Ahbramis 
	31151, --Tactical Officer Kilrath 
	31051, --Sorceress Kaylana 
	31101, --Hoodoo Master Fu'jin 

		---BattleGround---
	15351, --Alliance Brigadier General 
	15350, --Horde Warbringer

	---IceCrown---
	30824, --Sky-Reaver Korm Blackscar
	30344, --High Captain Justin Bartlett

	---Grizzly, --Hills----
	27562, --Lieutenant Stuart 
	27563, --Centurion Kaggrum 
	27759, --Commander Howser 
	27708, --General Gorlok 
	27602, --Sergeant Downey 
	27606, --Stone Guard Ragetotem 
	27520, --Baron Freeman 
	27532, --General Khazgar 
	27468, --Sergeant Hartsman Kick 
	27451, --Commander Bargok Keep 
	27783, --Scout Captain Carter 
	27120, --Raider Captain Kronn
	--Testing
	--30381, --Xarantaur


	}, ":")


function module:GetOptionsTable()
	local options = {
		name = L["LK"],
		type = "group",
		handler = module,
		get = "Multi_Get",
		set = "Multi_Set",
		order = 3,
		args = {
			faction = { name = "Factions", type = "group", order = 1,
				args = {
					wyrmrestAccord = { name = L["The Wyrmrest Accord"], type = "multiselect", order = 1, width = "full",
						values = { LQ["Aces High!"], LQ["Drake Hunt"], LQ["Defending Wyrmrest Temple"] },
					},
					sholizar = { name = L["Sholazar Basin"], type = "group", order = 2,
						args = {
							Oracles = { name = L["The Oracles"], type = "multiselect", order = 1, width = "full",
								values = { LQ["A Cleansing Song"], LQ["Appeasing the Great Rain Stone"], LQ["Hand of the Oracles"], 
									LQ["Mastery of the Crystals"], LQ["Power of the Great Ones"], LQ["Song of Fecundity"], LQ["Song of Reflection"],
									LQ["Song of Wind and Water"], LQ["Will of the Titans"], },
							},
							Frenzyheart = { name = L["Frenzyheart Tribe"], type = "multiselect", order = 2, width = "full",
								values = { LQ["A Hero's Headgear"], LQ["Chicken Party!"], LQ["Frenzyheart Champion"], LQ["Kartak's Rampage"], LQ["Rejek: First Blood"],
									LQ["Secret Strength of the Frenzyheart"], LQ["Strength of the Tempest"], LQ["The Heartblood's Strength"], LQ["Tools of War"], },
							},
						},
					},
					Hodir = { name = L["The Sons of Hodir"], type = "multiselect", order = 3, width = "full",
						values = { LQ["Blowing Hodir's Horn"], LQ["Feeding Arngrim"], LQ["Hot and Cold"], LQ["Polishing the Helm"], LQ["Spy Hunter"], 
							LQ["Thrusting Hodir's Spear"],  },
					},
					crusadeWrap = { name = L["Argent Crusade"], type = "group", order = 4, args = {
							Crusade = { name = L["Argent Crusade"], type = "multiselect", order = 1, width = "full",
								values = { 
									[LQ["The Alchemist's Apprentice"]] = LQ["The Alchemist's Apprentice"], 
									[LQ["Troll Patrol"]] = LQ["Troll Patrol"], 
									[LQ["Troll Patrol: Can You Dig It?"]] = LQ["Troll Patrol: Can You Dig It?"]:gsub(L["Troll Patrol: "], ""), 
									[LQ["Troll Patrol: Couldn't Care Less"]] = LQ["Troll Patrol: Couldn't Care Less"]:gsub(L["Troll Patrol: "], ""), 
									[LQ["Troll Patrol: Creature Comforts"]] = LQ["Troll Patrol: Creature Comforts"]:gsub(L["Troll Patrol: "], ""), 
									[LQ["Troll Patrol: Done to Death"]] =  LQ["Troll Patrol: Done to Death"]:gsub(L["Troll Patrol: "], ""), 
									[LQ["Troll Patrol: High Standards"]] = LQ["Troll Patrol: High Standards"]:gsub(L["Troll Patrol: "], ""), 
									[LQ["Troll Patrol: Intestinal Fortitude"]] = LQ["Troll Patrol: Intestinal Fortitude"]:gsub(L["Troll Patrol: "], ""), 
									[LQ["Troll Patrol: Something for the Pain"]] = LQ["Troll Patrol: Something for the Pain"]:gsub(L["Troll Patrol: "], ""), 
									[LQ["Troll Patrol: The Alchemist's Apprentice"]] = LQ["Troll Patrol: The Alchemist's Apprentice"]:gsub(L["Troll Patrol: "], ""), 
									[LQ["Troll Patrol: Throwing Down"]] =  LQ["Troll Patrol: Throwing Down"]:gsub(L["Troll Patrol: "], ""), 
									[LQ["Troll Patrol: Whatdya Want, a Medal?"]] = LQ["Troll Patrol: Whatdya Want, a Medal?"]:gsub(L["Troll Patrol: "], ""), 
									[LQ["Congratulations!"]] = LQ["Congratulations!"], 
								},
							},
							crusade_gossip = { name = L["Argent Crusade Gossip Options"], type = "multiselect", order = 2, width = "full", get = "GossipMulitGet", set = "GossipMulitSet",
								values = {
									[LQ["I'm ready to begin. What is the first ingredient you require?"]] = LQ["Troll Patrol: The Alchemist's Apprentice"]:gsub(L["Troll Patrol: "], ""),		
									[LQ["Get out there and make those Scourge wish they were never reborn!"]] = LQ["Troll Patrol: Intestinal Fortitude"]:gsub(L["Troll Patrol: "], ""),
								},
							},
						},
					},
					ebonWrap = { name = L["Knights of the Ebon Blade"], type = "group", order = 5,
						args = {
							Ebon = { name = L["Knights of the Ebon Blade"], type = "multiselect", order = 5, width = "full",
								values = { LQ["Intelligence Gathering"], LQ["Leave Our Mark"], LQ["No Fly Zone"], 
									LQ["From Their Corpses, Rise!"], LQ["Shoot 'Em Up"], LQ["Vile Like Fire!"],  },
							},
						},
					},
					Kalu = { name = L["The Kalu'ak"], type = "multiselect", order = 6, width = "full",
						values = { LQ["Planning for the Future"], LQ["Preparing for the Worst"], LQ["The Way to His Heart..."], },
					},
					peaks = { name = L["The Storm Peaks"], type = "multiselect", order = 7, width = "full",
						values = { LQ["Back to the Pit"], LQ["Defending Your Title"], LQ["Overstock"], LQ["Maintaining Discipline"], LQ["The Aberrations Must Die"], },
					},
					frostborn = { name = L["The Frostborn"], type = "multiselect", order = 7, width = "full",
						values = { LQ["Pushed Too Far"] },
					},
				},
			},
			shared = { name = L["Shared Faction Quests"], type = "group", order = 2,
				args = {
					iceZone = { type = "group", name = L["Icecrown"], order = 1,
						args = {
							PvE = {	name = L["Icecrown"], type = "multiselect", order = 2, width = "full",
								values = { LQ["King of the Mountain"], LQ["Blood of the Chosen"], LQ["Drag and Drop"], LQ["Neutralizing the Plague"], 
									LQ["No Rest For The Wicked"], LQ["Not a Bug"], LQ["Retest Now"], LQ["Slaves to Saronite"], LQ["That's Abominable!"], 
									LQ["Total Ohmage: The Valley of Lost Hope!"], LQ["Volatility"], LQ["Keeping the Alliance Blind"], 
									LQ["Riding the Wavelength: The Bombardment"], LQ["Static Shock Troops: the Bombardment"], 
									LQ["The Solution Solution"], LQ["Capture More Dispatches"], LQ["Putting the Hertz: The Valley of Lost Hope"],
									LQ["Assault by Ground"], LQ["Assault by Air"],
									 },
							},
							torurny = module:GetACTourny(),
						},
					},
							
					hills = { name = L["Grizzly Hills"], type = "multiselect", order = 2, width = "full",
						values = { LQ["Life or Death"], LQ["Overwhelmed!"], LQ["Making Repairs"], LQ["Pieces Parts"], 
							LQ["Keep Them at Bay"], LQ["Riding the Red Rocket"], LQ["Seared Scourge"], LQ["Smoke 'Em Out"], }
					},
				},
			},
			world_pvp = module:GetWorldPvP(),
			professions = module:GetProfessionsOptions(),
			instance = module:GetInstanceOptions(),
		}, --Top Lvl Args
	}--Top lvl options
	return options
end

function module:GetWorldPvP()
	local t = { name = L["World PvP"], type = "group", order = 3,
		args = {
			wintergrasp = { name = L["Wintergrasp"], order = 1, type = "multiselect", width = "full",
				values = { LQ["A Rare Herb"], LQ["Bones and Arrows"], LQ["Defend the Siege"], LQ["Fueling the Demolishers"], LQ["Healing with Roses"], 
					LQ["Jinxing the Walls"], LQ["No Mercy for the Merciless"], LQ["Slay them all!"], LQ["Stop the Siege"], LQ["Victory in Wintergrasp"], 
					LQ["Warding the Walls"], LQ["Warding the Warriors"], LQ["Southern Sabotage"],
				},
			},
			iceCrown = { name = L["Icecrown"], order = 2, type = "group",
				args = {
					Netural = {name = L["Icecrown Netural Quests"], type = "multiselect", order = 1, width = "full", values = {}, hidden = true},
					--Icrown might not have any pvp quests that are netural...
					IceHorde = { name = L["Horde"], type = "multiselect", order = 2, width = "full",
						values = { LQ["Make Them Pay!"], LQ["Shred the Alliance"] },
						hidden = function(info) return select(2, UnitFactionGroup("player")) == "Alliance" end

					},
					IceAlliance = { name = L["Alliance"], type = "multiselect", order = 2, width = "full",
						values = { LQ["No Mercy!"], LQ["Shredder Repair"] },
						hidden = function(info) return select(2, UnitFactionGroup("player")) == "Horde" end
					},
				},
			},
			hills = { name = L["Grizzly Hills"], type = "group", order = 3,
				args = {
					netural = { name = L["Shared Quests"], type = "multiselect", order = 1, width = "full",
						values = { LQ["Keep Them at Bay"], LQ["Riding the Red Rocket"], LQ["Seared Scourge"], LQ["Smoke 'Em Out"], },
					},
					horde = {name = L["Horde"], type = "multiselect", order = 2, width = "full",
						values = { LQ["Crush Captain Brightwater!"], LQ["Keep 'Em on Their Heels"], LQ["Blackriver Brawl"], },
						hidden = function(info) return select(2, UnitFactionGroup("player")) == "Alliance" end
					},
					alliance = { name = L["Alliance"], type = "multiselect", order = 3, width = "full",
						values = { LQ["Down With Captain Zorna!"], LQ["Kick 'Em While They're Down"], LQ["Blackriver Skirmish"], },
						hidden = function(info) return select(2, UnitFactionGroup("player")) == "Horde" end
					},
				},
			},
		},
	}
	return t
end

function module:GetProfessionsOptions()
	local t = { name = L["Professions"], type = "group", order = 4,
		args = {
			cooking = { name = L["Cooking"], type = "multiselect", order = 1, width = "full",
				values = { LQ["Cheese for Glowergold"], LQ["Convention at the Legerdemain"], LQ["Infused Mushroom Meatloaf"], LQ["Mustard Dogs!"], LQ["Sewer Stew"] },
			},
			JC = { name = L["Jewelcrafting"], type = "multiselect", order = 2, width = "full",
				values = {
					[LQ["Shipment: Blood Jade Amulet"]] = LQ["Shipment: Blood Jade Amulet"]:gsub(L["Shipment: "], ""),
					[LQ["Shipment: Bright Armor Relic"]] = LQ["Shipment: Bright Armor Relic"]:gsub(L["Shipment: "], ""),
					[LQ["Shipment: Glowing Ivory Figurine"]] = LQ["Shipment: Glowing Ivory Figurine"]:gsub(L["Shipment: "], ""),
					[LQ["Shipment: Intricate Bone Figurine"]] = LQ["Shipment: Intricate Bone Figurine"]:gsub(L["Shipment: "], ""),
					[LQ["Shipment: Shifting Sun Curio"]] = LQ["Shipment: Shifting Sun Curio"]:gsub(L["Shipment: "], ""),
					[LQ["Shipment: Wicked Sun Brooch"]] = LQ["Shipment: Wicked Sun Brooch"]:gsub(L["Shipment: "], ""),
				},
			},
			fishing = { name = L["Fishing"], type = "multiselect", order = 3, width = "full",
				values = { LQ["Blood Is Thicker"], LQ["Dangerously Delicious"], LQ["Jewel Of The Sewers"], LQ["Monsterbelly Appetite"], LQ["The Ghostfish"], },
			},
		},
	}
	return t
end

function module:GetInstanceOptions()

	local t = { name = L["Instances"], type = "group", order = 5,
		args = {
			heroicWrap = { type = "group", order = 1, name = L["Heroic Instances"],
				args = {
					Heroics = { name = L["Heroic Instances"], type = "multiselect", width = "full",
						values = {
							[LQ["Proof of Demise: Anub'arak"]] = LQ["Proof of Demise: Anub'arak"]:gsub(L["Proof of Demise: "], ""),
							[LQ["Proof of Demise: Cyanigosa"]] = LQ["Proof of Demise: Cyanigosa"]:gsub(L["Proof of Demise: "], ""),
							[LQ["Proof of Demise: Gal'darah"]] = LQ["Proof of Demise: Gal'darah"]:gsub(L["Proof of Demise: "], ""),
							[LQ["Proof of Demise: Herald Volazj"]] = LQ["Proof of Demise: Herald Volazj"]:gsub(L["Proof of Demise: "], ""),
							[LQ["Proof of Demise: Ingvar the Plunderer"]] = LQ["Proof of Demise: Ingvar the Plunderer"]:gsub(L["Proof of Demise: "], ""),
							[LQ["Proof of Demise: Keristrasza"]] = LQ["Proof of Demise: Keristrasza"]:gsub(L["Proof of Demise: "], ""),
							[LQ["Proof of Demise: King Ymiron"]] = LQ["Proof of Demise: King Ymiron"]:gsub(L["Proof of Demise: "], ""),
							[LQ["Proof of Demise: Ley-Guardian Eregos"]] = LQ["Proof of Demise: Ley-Guardian Eregos"]:gsub(L["Proof of Demise: "], ""),
							[LQ["Proof of Demise: Loken"]] = LQ["Proof of Demise: Loken"]:gsub(L["Proof of Demise: "], ""),
							[LQ["Proof of Demise: Mal'Ganis"]] = LQ["Proof of Demise: Mal'Ganis"]:gsub(L["Proof of Demise: "], ""),
							[LQ["Proof of Demise: Sjonnir The Ironshaper"]] = LQ["Proof of Demise: Sjonnir The Ironshaper"]:gsub(L["Proof of Demise: "], ""),
							[LQ["Proof of Demise: The Prophet Tharon'ja"]] = LQ["Proof of Demise: The Prophet Tharon'ja"]:gsub(L["Proof of Demise: "], ""),
						},
					},
				},

			},	--end Heroic Wrap
			nonHeroicWrap = { name = L["Instances"], type = "group", order = 2,
				args = {
					nonH = { name = L["Instances"], type = "multiselect", order = 1, width = "full",
						values = {
			[LQ["Timear Foresees Centrifuge Constructs in your Future!"]] = LQ["Timear Foresees Centrifuge Constructs in your Future!"]:match(L["Timear Foresees (.+) in your Future!"]),
			[LQ["Timear Foresees Infinite Agents in your Future!"]] = LQ["Timear Foresees Infinite Agents in your Future!"]:match(L["Timear Foresees (.+) in your Future!"]),
			[LQ["Timear Foresees Titanium Vanguards in your Future!"]] = LQ["Timear Foresees Titanium Vanguards in your Future!"]:match(L["Timear Foresees (.+) in your Future!"]),
			[LQ["Timear Foresees Ymirjar Berserkers in your Future!"]] = LQ["Timear Foresees Ymirjar Berserkers in your Future!"]:match(L["Timear Foresees (.+) in your Future!"]),
						},
					},
					option = { name = L["Faction Token"], type = "select", order = 2, get = "FactionTokenGet", set = "FactionTokenSet",
						values = { (GetItemInfo(43950)) or "Kirin Tor", (GetItemInfo(44711)) or "Argent Crusade", 
								(GetItemInfo(44713)) or "Ebon Blade", (GetItemInfo(44710)) or "Wyrmrest", L["None"]},
					},
				},
			},
		},
	}
	return t
end

function module:GetACTourny()
	local t = { name = L["Argent Tournament"], type = "group", order = 1, inline = true,
		args = {
			shard = { type = "multiselect", name = L["Shared Quests"], width = "full", order = 1,
				values = { LQ["A Chip Off the Ulduar Block"], LQ["Jack Me Some Lumber"],
					LQ["The Edge Of Winter"], LQ["A Worthy Weapon"], LQ["A Blade Fit For A Champion"]
				},
			},
			aspirant = {type = "multiselect", name = L["Aspirant Class"], width = "full", order = 10,
				values = { LQ["Training In The Field"], LQ["Learning The Reins"] },
			},
			valiant = {type = "multiselect", name = L["Valiant Class"], width = "full", order = 20,
				values = { LQ["At The Enemy's Gates"], LQ["The Grand Melee"], LQ["A Valiant's Field Training"] },
			},
			champ = { type = "multiselect", name = L["Champion Class"], width = "full", order = 30,
				values = { LQ["Battle Before The Citadel"], LQ["Threat From Above"], LQ["Among the Champions"], LQ["Taking Battle To The Enemy"], LQ["Contributin' To The Cause"] },
			},
			campOpt = { type = "select", name = L["Champion Quest Rewards"], order = 35, get = "ACTGet", set = "ACTSet",
				values = { (GetItemInfo(46114)), (GetItemInfo(45724)), nil, nil, L["None"]},
			},
		},
	}
	return t
end

function module:FactionTokenGet(info)
	return db.profile.qOptions[LQ["Timear Foresees Centrifuge Constructs in your Future!"]]
end

function module:FactionTokenSet(info, val)
	local qOpt = db.profile.qOptions
	qOpt[LQ["Timear Foresees Centrifuge Constructs in your Future!"]] = val
	qOpt[LQ["Timear Foresees Infinite Agents in your Future!"]] = val
	qOpt[LQ["Timear Foresees Titanium Vanguards in your Future!"]] = val
	qOpt[LQ["Timear Foresees Ymirjar Berserkers in your Future!"]] = val
end

function module:ACTGet(info)
	return db.profile.qOptions[LQ["Among the Champions"]]
end

function module:ACTSet(info, val)
	local qOpt = db.profile.qOptions
	qOpt[ LQ["Among the Champions"] ] = val
	qOpt[ LQ["Battle Before The Citadel"] ] = val
	qOpt[ LQ["Taking Battle To The Enemy"] ] = val
	qOpt[ LQ["Threat From Above"] ] = val
end

function module:GetQuestOption(info)
	return db.profile.qOptions[info.option.name]
end

function module:SetQuestOption(info, val)
	db.profile.qOptions[info.option.name] = val
end

function module:Multi_Get(info, value)
	if type(value) == "number" then
		return db.profile.quests[info.option.values[value]]
	else
		return db.profile.quests[value]
	end
end

function module:Multi_Set(info, value, state)
	if type(value) == "number" then
		db.profile.quests[info.option.values[value]] = state
	else
		db.profile.quests[value] = state
	end
end
----
function module:GossipMulitGet(info, value, state)
	if type(value) == "number" then
		return db.profile.gossip[info.option.values[value]]
	else
		return db.profile.gossip[value]
	end

end

function module:GossipMulitSet(info, value, state)
	if type(value) == "number" then
		db.profile.gossip[info.option.values[value]] = state
	else
		db.profile.gossip[value] = state
	end

end
