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


local module = AddonParent:NewModule("LK")
local L = LibStub("AceLocale-3.0"):GetLocale("SOCD_Core")
local GT = LibStub("AceLocale-3.0"):GetLocale("SOCD_GossipText")
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
			[LQ["Timear Foresees Centrifuge Constructs in your Future!"]] = -1,
			[LQ["Timear Foresees Infinite Agents in your Future!"]] = -1,
			[LQ["Timear Foresees Titanium Vanguards in your Future!"]] = -1,
			[LQ["Timear Foresees Ymirjar Berserkers in your Future!"]] = -1,
			--Argent Tournament
			[LQ["Among the Champions"]] = -1,
			[LQ["Battle Before The Citadel"]] = -1,
			[LQ["Taking Battle To The Enemy"]] = -1,
			[LQ["Threat From Above"]] = -1,
			--Turky Festives
			[LQ["Can't Get Enough Turkey"]] = -1,
			[LQ["Don't Forget The Stuffing!"]] = -1,
			[LQ["Easy As Pie"]] = -1,
			[LQ["She Says Potato"]] = -1,
			[LQ["We're Out of Cranberry Chutney Again?"]] = -1,
		},
		quests = {},
		gossip = {
			--["Tell me of yourself, Xarantaur. Why are you called the Witness?"] = true,
			[GT["I'm ready to begin. What is the first ingredient you require?"]] = true,	--Alchy Dailie from Argent crusade in Drak'Tharon
			[GT["Get out there and make those Scourge wish they were never reborn!"]] = true,	--Troll patrol quest
			[GT["Let's do this, sister."] ] = true,	--Defending your Title in Storm peaks
			[GT["Go on, you're free.  Get out of here!"] ] = true,	--"Slaves to Saronite
			[GT["Give me a bomber!"] ] = true,	--Bombing quests in icecrown
			[GT["Mount the Hippogryph and prepare for battle!"]] = true,	--Get Kracken!
		}
	},
}
do
	local profile = module.defaults.profile.quests
	for k,v in pairs(LQ) do
		profile[v] = true
	end
	profile[ LQ["Hand of the Oracles"] ] = false		--Disabled by request of "Fisker-" in IRC
	profile[ LQ["Frenzyheart Champion"] ] = false		--These 2 quests switch faction
	profile[ LQ["Contributin' To The Cause"] ] = false	--AC gold for rep quest

	local module_specialQuests = {
		[ LQ["A Rare Herb"] ] = "GetNextWGReset",
		[ LQ["Bones and Arrows"] ] = "GetNextWGReset",
		[ LQ["Defend the Siege"] ] = "GetNextWGReset",
		[ LQ["Fueling the Demolishers"] ] = "GetNextWGReset",
		[ LQ["Healing with Roses"] ] = "GetNextWGReset",
		[ LQ["Jinxing the Walls"] ] = "GetNextWGReset",
		[ LQ["No Mercy for the Merciless"] ] = "GetNextWGReset",
		[ LQ["Slay them all!"] ] = "GetNextWGReset",
		[ LQ["Stop the Siege"] ] = "GetNextWGReset",
		[ LQ["Victory in Wintergrasp"] ] = "GetNextWGReset",
		[ LQ["Warding the Walls"] ] = "GetNextWGReset",
		[ LQ["Warding the Warriors"] ] = "GetNextWGReset",
		[ LQ["Southern Sabotage"] ] = "GetNextWGReset",
		[ LQ["Toppling the Towers"] ] = "GetNextWGReset",
	}
	for k,v in pairs(module_specialQuests) do
		AddonParent.specialResetQuests[k] = v
	end
end


function module:OnInitialize()
	--D("OnInit")
	db = AddonParent.db:RegisterNamespace("LK", module.defaults)
	self.db = db
	db.RegisterCallback(self, "OnProfileChanged", "RefreshConfig")
	db.RegisterCallback(self, "OnProfileCopied", "RefreshConfig")
	db.RegisterCallback(self, "OnProfileReset", "RefreshConfig")
end

function module:RefreshConfig(event, db, newProfile)
	D(self:GetName(), event, newProfile)
	if self:IsEnabled() then
		AddonParent:UnRegisterQuests("LK")
		AddonParent:RegisterQuests("LK", db.profile.quests, db.profile.qOptions, db.profile.gossip)
	end
end


function module:OnEnable()
	--D("OnEnable")
	AddonParent:RegisterQuests("LK", db.profile.quests, db.profile.qOptions, db.profile.gossip)
	SetItemRef("item:43950", "item:43950")	--Kirin Tor Faction Token
	SetItemRef("item:43950", "item:43950")

	SetItemRef("item:44711", "item:44711")	--Argetn Crusade Toeken
	SetItemRef("item:44711", "item:44711")

	SetItemRef("item:44713", "item:44713")	--Ebobn Blade
	SetItemRef("item:44713", "item:44713")

	SetItemRef("item:44710", "item:44710")	--wyrmrest
	SetItemRef("item:44710", "item:44710")

	SetItemRef("item:49702", "item:49702")	--Sons of Hodir
	SetItemRef("item:49702", "item:49702")

	SetItemRef("item:46114", "item:46114")	--Champion's Writ
	SetItemRef("item:46114", "item:46114")

	SetItemRef("item:45724", "item:45724")	--Champion's Purse
	SetItemRef("item:45724", "item:45724")
end

function module:OnDisable()
	--D("OnDisable")
	AddonParent:UnRegisterQuests("LK")
end


function module:GetOptionsTable()
        local t = {
		name = L["LK"],
		type = "group",
		handler = module,
		get = "Multi_Get",
		set = "Multi_Set",
		order = 3,
		childGroups = "tab",
		args = {
			world = self:WorldQuests(),
			instance = self:InstanceQuests(),
			pvp = self:PlayerVsPlayerQuests(),
			professions = self:ProfessionsQuests(),
		},

        }
        return t
end

local trol_patrol_sub_Text = L["Troll Patrol: "]
local function tpScrub(text)
	return (tostring(text):gsub(trol_patrol_sub_Text, ""))
end

function module:WorldQuests()
	local str = [[
	return function(L, LQ, module, tpScrub, GT)
		local t = {
		type = "group",
		name = CHANNEL_CATEGORY_WORLD,
		order = 1,
		args = {
			faction = { type = "group", name = L["Faction Quests"], order = 1,
				args = {
					Kalu = { type = "group", name = L["The Kalu'ak"],
						args = {
							kaluSub = { name = L["The Kalu'ak"], type = "multiselect", width = "full",
								values = { LQ["Planning for the Future"], LQ["Preparing for the Worst"], LQ["The Way to His Heart..."], },
							},
						},
					},
					Frostborn = { type = "group", name = L["The Frostborn"],
						args = {
							frostSub = { name = L["The Frostborn"], type = "multiselect", width = "full",
								values = { LQ["Pushed Too Far"] },
							},
						},
					},
					Wyrmreset = { type = "group", name = L["The Wyrmrest Accord"],
						args = {
							wyrmwrestSub = { name = L["The Wyrmrest Accord"], type = "multiselect", order = 1, width = "full",
								values = { LQ["Aces High!"], LQ["Drake Hunt"], LQ["Defending Wyrmrest Temple"] },
							},
						},
					},
					hodir = { type = "group", name = L["The Sons of Hodir"],
						args = {
							hodirSub = { name = L["The Sons of Hodir"], type = "multiselect", width = "full",
								values = { LQ["Blowing Hodir's Horn"], LQ["Feeding Arngrim"], LQ["Hot and Cold"], LQ["Polishing the Helm"], LQ["Spy Hunter"],
									LQ["Thrusting Hodir's Spear"],  },
							},
						},
					},
					Oracles = { type = "group", name = L["The Oracles"],
						args = {
							oraclesSub = { name = L["The Oracles"], type = "multiselect", order = 1, width = "full",
								values = { LQ["A Cleansing Song"], LQ["Appeasing the Great Rain Stone"], LQ["Hand of the Oracles"],
									LQ["Mastery of the Crystals"], LQ["Power of the Great Ones"], LQ["Song of Fecundity"], LQ["Song of Reflection"],
									LQ["Song of Wind and Water"], LQ["Will of the Titans"], },
							},
						},
					},
					Frenzyheart = { type = "group", name = L["Frenzyheart Tribe"],
						args = {
							frenzySub = { name = "Frenzyheart", type = "multiselect", order = 1, width = "full",
								values = { LQ["A Hero's Headgear"], LQ["Chicken Party!"], LQ["Frenzyheart Champion"], LQ["Kartak's Rampage"], LQ["Rejek: First Blood"],
									LQ["Secret Strength of the Frenzyheart"], LQ["Strength of the Tempest"], LQ["The Heartblood's Strength"], LQ["Tools of War"], },
							},
						},
					},
					Argent = { type = "group", name = L["Argent Crusade"], order = 8,
						args = {
							patrol = { type = "group", name = LQ["Troll Patrol"], order = 1,
								args = {
									patrolSub = { name = LQ["Troll Patrol"], type = "multiselect", order = 1, width = "full",
										values = {
									[ LQ["The Alchemist's Apprentice"] ] = LQ["The Alchemist's Apprentice"],
									[ LQ["Troll Patrol"] ] = LQ["Troll Patrol"],
									[ LQ["Troll Patrol: Can You Dig It?"] ] = tpScrub(LQ["Troll Patrol: Can You Dig It?"]),
									[ LQ["Troll Patrol: Couldn't Care Less"] ] = tpScrub(LQ["Troll Patrol: Couldn't Care Less"]),
									[ LQ["Troll Patrol: Creature Comforts"] ] = tpScrub(LQ["Troll Patrol: Creature Comforts"]),
									[ LQ["Troll Patrol: Done to Death"] ] =  tpScrub(LQ["Troll Patrol: Done to Death"]),
									[ LQ["Troll Patrol: High Standards"] ] = tpScrub(LQ["Troll Patrol: High Standards"]),
									[ LQ["Troll Patrol: Intestinal Fortitude"] ] = tpScrub(LQ["Troll Patrol: Intestinal Fortitude"]),
									[ LQ["Troll Patrol: Something for the Pain"] ] = tpScrub(LQ["Troll Patrol: Something for the Pain"]),
									[ LQ["Troll Patrol: The Alchemist's Apprentice"] ] = tpScrub(LQ["Troll Patrol: The Alchemist's Apprentice"]),
									[ LQ["Troll Patrol: Throwing Down"] ] = tpScrub(LQ["Troll Patrol: Throwing Down"]),
									[ LQ["Troll Patrol: Whatdya Want, a Medal?"] ] = tpScrub(LQ["Troll Patrol: Whatdya Want, a Medal?"]),
									[ LQ["Congratulations!"] ] = LQ["Congratulations!"],
										}
									},
									patrol_Opts = { name = GOSSIP_OPTIONS, type = "multiselect", order = 2, width = "full", get = "GossipMulitGet", set = "GossipMulitSet",
										values = {
									[ GT["I'm ready to begin. What is the first ingredient you require?"] ] = tpScrub(LQ["Troll Patrol: The Alchemist's Apprentice"]),
									[ GT["Get out there and make those Scourge wish they were never reborn!"] ] = tpScrub(LQ["Troll Patrol: Intestinal Fortitude"]),
										},
									}
								},
							},
							preQual = { type = "group", name = L["Tournament Preliminaries"], order = 2,
								args = {
									head1 = { type = "header", name = L["The Argent Tournament - Preliminaries"], order = 1, },
									about = { type = "description", name = L["ArgentTournamentPreQual_Desc"], order = 2, },
									shared = { type = "multiselect", name = L["Shared Quests"], width = "full", order = 5,
										values = { --LQ["A Chip Off the Ulduar Block"], LQ["Jack Me Some Lumber"],
											--These 2 quests are being removed in patch 3.2 ^^^^^^^
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
										values = { [-1] = L["None"], (GetItemInfo(46114)), (GetItemInfo(45724)),},
									},
									gossip = { type = "multiselect", name = GOSSIP_OPTIONS, order = 40, width = "full",
										get = "GossipMulitGet", set = "GossipMulitSet",
										values = { [ GT["I am ready to fight!"] ]= L["Jousting Challenge"], },
									},
								},
							},
							finale = { type = "group", name = L["Tournament Finale"], order = 3,
								args = {
									head1 = { type = "header", name = L["The Argent Tournament - Finale"], order = 1, },
									about = { type = "description", name = L["ArgentTournamentFinale_Desc"], order = 2, },
									part = { type = "multiselect", name = L["Shared Quests"], order = 10, width = "full",
										values = { LQ["You've Really Done It This Time, Kul"], LQ["Rescue at Sea"], LQ["A Leg Up"], LQ["The Light's Mercy"],
											LQ["Stop The Aggressors"], LQ["Breakfast Of Champions"], LQ["Gormok Wants His Snobolds"], LQ["What Do You Feed a Yeti, Anyway?"],
											LQ["The Fate Of The Fallen"], LQ["Get Kraken!"], LQ["Drottinn Hrothgar"],LQ["Mistcaller Yngvar"],
											LQ["Ornolf The Scarred"], LQ["Deathspeaker Kharos"],
}
									},
									gossip = { type = "multiselect", name = GOSSIP_OPTIONS, order = 40, width = "full",
										get = "GossipMulitGet", set = "GossipMulitSet",
										values = { [ GT["Mount the Hippogryph and prepare for battle!"] ] = LQ["Get Kracken!"] },
									},
								},
							}
						},
					},
					Knights = { type = "group", name = L["Knights of the Ebon Blade"],
						args = {
							knightsSub = { name = L["Knights of the Ebon Blade"], type = "multiselect", width = "full",
								values = { LQ["Intelligence Gathering"], LQ["Leave Our Mark"], LQ["No Fly Zone"],
									LQ["From Their Corpses, Rise!"], LQ["Shoot 'Em Up"], LQ["Vile Like Fire!"],  },
							},
						},
					},
					Ravasaur = { type = "group", name = L["Ravasaur Trainers"],
						args = {
							raveSub = { name = L["Ravasaur Trainers"], type = "multiselect", width = "full",
								values = { LQ["Gorishi Grub"], LQ["Hungry, Hungry Hatchling"], LQ["Poached, Scrambled, Or Raw?"], LQ["Searing Roc Feathers"], },
							},
						},
					},
				},
			},
			zone = { type = "group", name = L["Zone Generic"], order = 2,
				args = {
					peaks = { type = "group", name =  L["The Storm Peaks"],
						args = {
							peaksSub = { name =  L["The Storm Peaks"], type = "multiselect", order = 1, width = "full",
								values = { LQ["Back to the Pit"], LQ["Defending Your Title"], LQ["Overstock"],
								LQ["Maintaining Discipline"], LQ["The Aberrations Must Die"], },
							},
							peaksGossip = { name = L["The Storm Peaks"].." "..GOSSIP_OPTIONS, type = "multiselect", order = 8, width = "full", get = "GossipMulitGet", set = "GossipMulitSet",
								values = { [ GT["Let's do this, sister."] ] = LQ["Defending Your Title"] },
							},
						},
					},
					Icecrown = { type = "group", name = L["Icecrown"],
						args = {
							shared = { name = L["Icecrown"], type = "multiselect", order = 1, width = "full",
								values = { LQ["King of the Mountain"], LQ["Blood of the Chosen"], LQ["Drag and Drop"], LQ["Neutralizing the Plague"],
									LQ["No Rest For The Wicked"], LQ["Not a Bug"], LQ["Retest Now"], LQ["Slaves to Saronite"], LQ["That's Abominable!"],
									LQ["Total Ohmage: The Valley of Lost Hope!"], LQ["Volatility"], LQ["Keeping the Alliance Blind"],
									LQ["Riding the Wavelength: The Bombardment"], LQ["Static Shock Troops: the Bombardment"],
									LQ["The Solution Solution"], LQ["Capture More Dispatches"], LQ["Putting the Hertz: The Valley of Lost Hope"],
									LQ["Assault by Ground"], LQ["Assault by Air"],
									 },
							},
							gossip = { name = L["Icecrown"].." "..GOSSIP_OPTIONS, type = "multiselect", order = 2, width = "full", 
								get = "GossipMulitGet", set = "GossipMulitSet",
								values = { [ GT["Go on, you're free.  Get out of here!"] ] = LQ["Slaves to Saronite"],
									[ GT["Give me a bomber!"] ] = L["Bombing Quests in Icecrown"],
									},
							},
						},
					},
--					Fyord = { type = "group", name = "Howling Fyord",
--						args = {
--							shared = { name = "Fyord", type = "multiselect", order = 1, width = "full",
--								values = { "test" },
--							},
--						},
--					},		--There is 1 alliance daily quest in HF... maybe put it in later??
					Hills = { type = "group", name = L["Grizzly Hills"],
						args = {
							shared = { name = L["Grizzly Hills"], type = "multiselect", order = 1, width = "full",
								values = {  LQ["Seared Scourge"] },
							},
						},
					},
				},
			},
			worldEvents = {  type = "group", name = L["World Events"], order = 3,
				args = {
					thanksgiving = { type = "group", name = L["Pilgrim's Bounty"], 
						args = {
							quests = { type = "multiselect", order = 1, width = "full", name = L["Pilgrim's Bounty"],
								values = {
							LQ["Can't Get Enough Turkey"], LQ["Don't Forget The Stuffing!"], LQ["Easy As Pie"], 
							LQ["She Says Potato"], LQ["We're Out of Cranberry Chutney Again?"] },
							},
							rewards = { name = L["Quest Rewards"], type = "select", order = 2, get = "ThxQuestReward", set = "ThxQuestReward",
								values = { [-1] = L["None"],
	GetItemInfo(46723) or "Pilgrim's Hat", GetItemInfo(46800) or "Pilgrim's Attire",GetItemInfo(44785) or "Pilgrim's Dress",
	GetItemInfo(46824) or "Pilgrim's Robe", GetItemInfo(44788) or "Pilgrim's Boots", GetItemInfo(44812) or "Pilgrim's Shooter",
								},
							},
						},
					},
				},
			},
		},
	}
		return t
	end
]]
	local t, lsEr = loadstring(str)
	if type(t) == "function" then
		t = t()(L, LQ, self, tpScrub, GT)
	else
		geterrorhandler()("SOCD-WotLK-WorldQuests\n"..lsEr)
		return nil
	end
	return t
end

local normal_instance_sub_Text = L["Timear Foresees (.+) in your Future!"]
local function norInstScrub(text)
	return ( text:match(normal_instance_sub_Text) )
end
local heroic_instance_sub_Text = L["Proof of Demise: "]
local function herInstScrub(text)
	return ( text:gsub(heroic_instance_sub_Text, "") )
end
function module:InstanceQuests()
	local str = [[
	return function(L, LQ, module, norInstScrub, herInstScrub)
	local t = {
		type = "group",
		name = L["Doungeons"],
		order = 2,
		args = {
			normal  = { type = "group", name = L["Dungeon"], order = 1,		--Note to self, search _G again for some client localizations, they changed alot in 3.2
				args = {
					normalSub = { name = L["Dungeon"], type = "multiselect", order = 1, width = "full",
						values = {
			[LQ["Timear Foresees Centrifuge Constructs in your Future!"] ] = norInstScrub(LQ["Timear Foresees Centrifuge Constructs in your Future!"]),
			[LQ["Timear Foresees Infinite Agents in your Future!"] ] = norInstScrub(LQ["Timear Foresees Infinite Agents in your Future!"]),
			[LQ["Timear Foresees Titanium Vanguards in your Future!"] ] = norInstScrub(LQ["Timear Foresees Titanium Vanguards in your Future!"]),
			[LQ["Timear Foresees Ymirjar Berserkers in your Future!"] ] = norInstScrub(LQ["Timear Foresees Ymirjar Berserkers in your Future!"]),
						}
					},
					option = { name = L["Faction Token"], type = "select", order = 2, get = "FactionTokenGet", set = "FactionTokenSet", width = "double",
						values = { [-1] = L["None"],  (GetItemInfo(43950)) or "Kirin Tor", (GetItemInfo(44711)) or "Argent Crusade",
								(GetItemInfo(44713)) or "Ebon Blade", (GetItemInfo(44710)) or "Wyrmrest", (GetItemInfo(49702)) or "Sons of Hodir" },
					}
				},
			},
			heroic = { type = "group", name = L["Heroic Dungeon"], order = 2,
				args = {
					heroicSub = { name =  L["Heroic Dungeon"], type = "multiselect", width = "full",
						values = {
							[LQ["Proof of Demise: Anub'arak"] ] = herInstScrub(LQ["Proof of Demise: Anub'arak"]),
							[LQ["Proof of Demise: Cyanigosa"] ] = herInstScrub(LQ["Proof of Demise: Cyanigosa"]),
							[LQ["Proof of Demise: Gal'darah"] ] = herInstScrub(LQ["Proof of Demise: Gal'darah"]),
							[LQ["Proof of Demise: Herald Volazj"] ] = herInstScrub(LQ["Proof of Demise: Herald Volazj"]),
							[LQ["Proof of Demise: Ingvar the Plunderer"] ] = herInstScrub(LQ["Proof of Demise: Ingvar the Plunderer"]),
							[LQ["Proof of Demise: Keristrasza"] ] = herInstScrub(LQ["Proof of Demise: Keristrasza"]),
							[LQ["Proof of Demise: King Ymiron"] ] = herInstScrub(LQ["Proof of Demise: King Ymiron"]),
							[LQ["Proof of Demise: Ley-Guardian Eregos"] ] = herInstScrub(LQ["Proof of Demise: Ley-Guardian Eregos"]),
							[LQ["Proof of Demise: Loken"] ] = herInstScrub(LQ["Proof of Demise: Loken"]),
							[LQ["Proof of Demise: Mal'Ganis"] ] = herInstScrub(LQ["Proof of Demise: Mal'Ganis"]),
							[LQ["Proof of Demise: Sjonnir The Ironshaper"] ] = herInstScrub(LQ["Proof of Demise: Sjonnir The Ironshaper"]),
							[LQ["Proof of Demise: The Prophet Tharon'ja"] ] = herInstScrub(LQ["Proof of Demise: The Prophet Tharon'ja"]),
							[LQ["Proof of Demise: The Black Knight"] ] = herInstScrub(LQ["Proof of Demise: The Black Knight"]),
						}
					},
				},
			},
		},
	}
	return t
	end ]]
	local t = loadstring(str)()(L, LQ, self, norInstScrub, herInstScrub)

	return t
end

function module:PlayerVsPlayerQuests()
	local str = [[
	return function(L, LQ, module)
	local t = {
		type = "group",
		name = L["World PvP"],
		order = 3,
		args = {
			bg  = { type = "group", name = L["Battlegrounds"],
				args = {
					bgSub = { name = L["Battlegrounds"], type = "multiselect", width = "full",
						values = { LQ["Call to Arms: Strand of the Ancients"], LQ["Call to Arms: Isle of Conquest"] },
					},
				},
			},
			wg  = { type = "group", name = L["Wintergrasp"],	--Don't care too much to break the horde and alliance ones up here...
				args = {
					wgSub = { name = L["Wintergrasp"], type = "multiselect", width = "full",
						values = { LQ["A Rare Herb"], LQ["Bones and Arrows"], LQ["Defend the Siege"], LQ["Fueling the Demolishers"], LQ["Healing with Roses"],
					LQ["Jinxing the Walls"], LQ["No Mercy for the Merciless"], LQ["Slay them all!"], LQ["Stop the Siege"], LQ["Victory in Wintergrasp"],
					LQ["Warding the Walls"], LQ["Warding the Warriors"], LQ["Southern Sabotage"], LQ["Toppling the Towers"],
						},
					},
				},
			},
			Grizzly  = { type = "group", name = L["Grizzly Hills"],		--These are all classified as PvP Quests, even though it might not take pvp, as dictated by Acheivemnt
				args = {
					shared = { name = L["Shared Quests"], type = "multiselect", order = 1, width = "full",
						values = { LQ["Keep Them at Bay"], LQ["Riding the Red Rocket"], LQ["Smoke 'Em Out"] },
					},
					horde = { name = L["Horde"], type = "multiselect", order = 10, width = "full",
						values = { LQ["Blackriver Brawl"], LQ["Making Repairs"], LQ["Overwhelmed!"], LQ["Crush Captain Brightwater!"],
							LQ["Shred the Alliance"], LQ["Keep 'Em on Their Heels"] },

						hidden = function(info) return select(2, UnitFactionGroup("player")) == "Alliance" end
					},
					alliance = { name = L["Alliance"], type = "multiselect", order = 20, width = "full",
						values = { LQ["Blackriver Skirmish"], LQ["Life or Death"], LQ["Kick 'Em While They're Down"], LQ["Down With Captain Zorna!"],
							LQ["Pieces Parts"], LQ["Shredder Repair"] },
						hidden = function(info) return select(2, UnitFactionGroup("player")) == "Horde" end
					},
				},
			},
			Icecrown  = { type = "group", name = "Icecrown PvP", 		--I know, not a whole lot eh?
				args = {
--					shared = { name = L["Shared Quests"], type = "multiselect", order = 1, width = "full",
--						values = {  },
--					},
					horde = { name = L["Horde"], type = "multiselect", order = 10, width = "full",
						values = { LQ["Make Them Pay!"] },
						hidden = function(info) return select(2, UnitFactionGroup("player")) == "Alliance" end
					},
					alliance = { name = L["Alliance"], type = "multiselect", order = 20, width = "full",
						values = { LQ["No Mercy!"] },
						hidden = function(info) return select(2, UnitFactionGroup("player")) == "Horde" end
					},
				},
			},
		},
	}
	return t
	end]]
	local t = loadstring(str)()(L, LQ, self)
	return t
end

local jc_sub_Text = L["Shipment: "]
local function jcScrub(text)
	return (tostring(text):gsub(jc_sub_Text, ""))
end
function module:ProfessionsQuests()
	local str = [[
	return function(L, LQ, module, jcScrub)
	local t = {
		type = "group",
		name = L["Professions"],
		order = 4,
		args = {
			jc  = { type = "group", name = L["Jewelcrafting"],
				args = {
					jc_Sub = { name = "Jewlcrafting", type = "multiselect", width = "full",
						values = {
							[LQ["Shipment: Blood Jade Amulet"] ] = jcScrub(LQ["Shipment: Blood Jade Amulet"]),
							[LQ["Shipment: Bright Armor Relic"] ] = jcScrub(LQ["Shipment: Bright Armor Relic"]),
							[LQ["Shipment: Glowing Ivory Figurine"] ] = jcScrub(LQ["Shipment: Glowing Ivory Figurine"]),
							[LQ["Shipment: Intricate Bone Figurine"] ] = jcScrub(LQ["Shipment: Intricate Bone Figurine"]),
							[LQ["Shipment: Shifting Sun Curio"] ] = jcScrub(LQ["Shipment: Shifting Sun Curio"]),
							[LQ["Shipment: Wicked Sun Brooch"] ] = jcScrub(LQ["Shipment: Wicked Sun Brooch"]),
						},
					},
				},
			},
			cook = { type = "group", name = L["Cooking"],
				args = {
					cookSub = { name = L["Cooking"], type = "multiselect", order = 1, width = "full",
						values = { LQ["Cheese for Glowergold"], LQ["Convention at the Legerdemain"], LQ["Infused Mushroom Meatloaf"], LQ["Mustard Dogs!"], LQ["Sewer Stew"] },
					},
				},
			},
			fish = { type = "group", name = L["Fishing"],
				args = {
					shared = { name = L["Fishing"], type = "multiselect", order = 1, width = "full",
						values = { LQ["Blood Is Thicker"], LQ["Dangerously Delicious"], LQ["Jewel Of The Sewers"], LQ["Monsterbelly Appetite"], LQ["The Ghostfish"], },
					},
				},
			},
		},
	}
	return t
	end]]
	local t = loadstring(str)()(L, LQ, module, jcScrub)
	return t
end

function module:FactionTokenGet(info)
	return db.profile.qOptions[LQ["Timear Foresees Centrifuge Constructs in your Future!"] ]
end

function module:FactionTokenSet(info, val)
	local qOpt = db.profile.qOptions
	qOpt[LQ["Timear Foresees Centrifuge Constructs in your Future!"] ] = val
	qOpt[LQ["Timear Foresees Infinite Agents in your Future!"] ] = val
	qOpt[LQ["Timear Foresees Titanium Vanguards in your Future!"] ] = val
	qOpt[LQ["Timear Foresees Ymirjar Berserkers in your Future!"] ] = val
end

function module:ThxQuestReward(info, val)
	print("ThxQuestReward", info, val)
	if val then	--Set function
		print("Set Func?", value)
		local qOpt = db.profile.qOptions
		qOpt[ LQ["Can't Get Enough Turkey"] ] = val
		qOpt[ LQ["Don't Forget The Stuffing!"] ] = val
		qOpt[ LQ["Easy As Pie"] ] = val
		qOpt[ LQ["She Says Potato"] ] = val
		qOpt[ LQ["We're Out of Cranberry Chutney Again?"] ] = val
	else
		print("Get func", quest)
		return db.profile.qOptions[ LQ["Can't Get Enough Turkey"] ]
	end
end

function module:ACTGet(info)
	return db.profile.qOptions[LQ["Among the Champions"] ]
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
		return db.profile.quests[info.option.values[value] ]
	else
		return db.profile.quests[value]
	end
end

function module:Multi_Set(info, value, state)

	if type(value) == "number" then
		db.profile.quests[info.option.values[value] ] = state
	else
		db.profile.quests[value] = state
	end
end
----
function module:GossipMulitGet(info, value, state)
	if type(value) == "number" then
		return db.profile.gossip[info.option.values[value] ]
	else
		return db.profile.gossip[value]
	end

end

function module:GossipMulitSet(info, value, state)
	if type(value) == "number" then
		db.profile.gossip[info.option.values[value] ] = state
	else
		db.profile.gossip[value] = state
	end

end
