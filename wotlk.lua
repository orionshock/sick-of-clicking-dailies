--
--	Wrath of the Lich King Module
--
--
--

local D		--Basic Debug
do
	local LK = {}
	function D(...)
		local str
		local arg = select(1, ...) or ""
		if type(arg) == "string" and string.find(arg, "%%") then
			str = (select(1, ...)):format(select(2,...))
		else
			for i = 1, select("#", ...) do
				LK[i] = tostring(select(i, ...))
			end
			str = table.concat(LK, ", ")
		end
		ChatFrame1:AddMessage("SOCD-LK: "..str)
		for i = 1, #LK do
			LK[i] = nil
		end
	end
end

local AddonParent = LibStub("AceAddon-3.0"):GetAddon("SickOfClickingDailies")
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
		},
	},
}
do
	local profile = module.defaults.profile
	for k,v in pairs(LQ) do
		profile[v] = true
	end
end


function module:OnInitialize()
	--D("OnInit")
	db = AddonParent.db:RegisterNamespace("LK", module.defaults)
	self.db = db
end

function module:OnEnable()
	--D("OnEnable")
	AddonParent:RegisterQuests("LK", db.profile, self.npcList, db.profile.qOptions)
end

function module:OnDisable()
	--D("OnDisable")
	AddonParent:UnRegisterQuests("LK")
end

module.npcList = table.concat({
	"00000"		--Don't forget to replace this

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
						},
					},
					Ebon = { name = L["Knights of the Ebon Blade"], type = "multiselect", order = 5, width = "full",
						values = { LQ["Intelligence Gathering"], LQ["Leave Our Mark"], LQ["No Fly Zone"], 
							LQ["From Their Corpses, Rise!"], LQ["Shoot 'Em Up"], LQ["Vile Like Fire!"],  },
					},
					Kalu = { name = L["The Kalu'ak"], type = "multiselect", order = 6, width = "full",
						values = { LQ["Planning for the Future"], LQ["Preparing for the Worst"], LQ["The Way to His Heart..."], },
					},
					peaks = { name = L["The Storm Peaks"], type = "multiselect", order = 7, width = "full",
						values = { LQ["Back to the Pit"], LQ["Defending Your Title"], LQ["Overstock"], LQ["Maintaining Discipline"], LQ["The Aberrations Must Die"], },
					},
				},
			},
			shared = { name = L["Shared Faction Quests"], type = "group", order = 2,
				args = {
					ice = {	name = L["Icecrown"], type = "multiselect", order = 1, width = "full",
						values = { LQ["King of the Mountain"], LQ["Blood of the Chosen"], LQ["Drag and Drop"], LQ["Neutralizing the Plague"], 
							LQ["No Rest For The Wicked"], LQ["Not a Bug"], LQ["Retest Now"], LQ["Slaves to Saronite"], LQ["That's Abominable!"], 
							LQ["Total Ohmage: The Valley of Lost Hope!"], LQ["Volatility"], LQ["Keeping the Alliance Blind"], 
							LQ["Riding the Wavelength: The Bombardment"], LQ["Static Shock Troops: the Bombardment"], 
							LQ["The Solution Solution"], LQ["Capture More Dispatches"], LQ["Putting the Hertz: The Valley of Lost Hope"], },
					},
					hills = { name = L["Grizzly Hills"], type = "multiselect", order = 2, width = "full",
						values = { LQ["Life or Death"], LQ["Overwhelmed!"], LQ["Making Repairs"], LQ["Pieces Parts"], 
							LQ["Keep Them at Bay"], LQ["Riding the Red Rocket"], LQ["Seared Scourge"], LQ["Smoke 'Em Out"], }
					},
				},
			},
			world_pvp = module:GetWorldPvP(),
		}, --Top Lvl Args
	}--Top lvl options
	return options
end

function module:GetWorldPvP()
	local t = { name = L["World PvP"], type = "group", order = 3,
		args = {
			wintergrasp = { name = L["Wintergrasp"], order = 1, type = "multiselect", width = "full",
				values = { LQ["A Rare Herb"], LQ["Bones and Arrows"], LQ["Defend the Siege"], LQ["Fueling the Demolishers"], LQ["Healing with Roses"], 
					LQ["Jinxing the Walls"], LQ["No Mercy for the Merciless"], LQ["Slay them all"], LQ["Stop the Siege"], LQ["Victory in Wintergrasp"], 
					LQ["Warding the Walls"], LQ["Warding the Warriors"], 
				},
			},
			iceCrown = { name = L["Icecrown"], order = 2, type = "group",
				args = {
					Netural = {name = "Icecrown Netural Quests", type = "multiselect", order = 1, width = "full", values = {},},			
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



--Included for sake of Completeness for single edged quests.
--function module:GetQuestEnabled(info)
--	return db.profile[info.option.name]
--end

--function module:SetQuestEnabled(info, val)
--	db.profile[info.option.name] = val
--end

function module:GetQuestOption(info)
	return db.profile.qOptions[info.option.name]
end

function module:SetQuestOption(info, val)
	db.profile.qOptions[info.option.name] = val
end

function module:Multi_Get(info, value)
	if type(value) == "number" then
		return db.profile[info.option.values[value]]
	else
		return db.profile[value]
	end
end

function module:Multi_Set(info, value, state)
	if type(value) == "number" then
		db.profile[info.option.values[value]] = state
	else
		db.profile[value] = state
	end
end
