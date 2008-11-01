--[[
	Burning Crusade Module

	netherwing
	shat'ar skyguard
	ogrila
	cooking
	fishing
]]--

local D		--Basic Debug
do
	local temp = {}
	function D(...)
		local str
		local arg = select(1, ...) or ""
		if type(arg) == "string" and string.find(arg, "%%") then
			str = (select(1, ...)):format(select(2,...))
		else
			for i = 1, select("#", ...) do
				temp[i] = tostring(select(i, ...))
			end
			str = table.concat(temp, ", ")
		end
		ChatFrame1:AddMessage("SOCD-BC: "..str)
		for i = 1, #temp do
			temp[i] = nil
		end
	end
end

local AddonParent = LibStub("AceAddon-3.0"):GetAddon("SickOfClickingDailies")
local module = AddonParent:NewModule("BC")
local L = LibStub("AceLocale-3.0"):GetLocale("SOCD_Core")
local LQ = LibStub("AceLocale-3.0"):GetLocale("SOCD_BC")
local db, qTable = nil, AddonParent.qTable

module.defaults = {
	profile = {
		--This Table will get auto gened by the next block from the locale data
		qOptions = {
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
	profile[LQ["A Charitable Donation"]] = false
	profile[LQ["Your Continued Support"]] = false
end

local cooking_values

function module:OnInitialize()
	--D("OnInit")
	db = AddonParent.db:RegisterNamespace("BC", module.defaults)
	self.db = db
end

function module:OnEnable()
	--D("OnEnable")
	GameTooltip:SetHyperlink("item:30809")	--Aldor Mark
	GameTooltip:SetHyperlink("item:30810")	--Scryer Mark
	GameTooltip:SetHyperlink("item:34538")	--Melee weapon
	GameTooltip:SetHyperlink("item:34539")	--caster weapon
	GameTooltip:SetHyperlink("item:33844")	--Barrel of Fish
	GameTooltip:SetHyperlink("item:33857")	--Crate Of Meat
	
	cooking_values = { (GetItemInfo(33844)), (GetItemInfo(33857)), L["None"]}

	AddonParent:RegisterQuests("BC", db.profile, self.npcList, db.profile.qOptions)
end

function module:OnDisable()
	--D("OnDisable")
	AddonParent:UnRegisterQuests("BC")
end

module.npcList = table.concat({
	--SkyGuard
	23048,		--Sky Sergeant Doryn
	23383,		--Skyguard Prisoner
	23335,		--Skyguard Khatie
	23120,		--Sky Sergeant Vanderlip
	--Ogrila
	23253,		--Kronk
	23233,		--Chu'a'lor
	--Netherwing
	23140,		--Taskmaster Varkule Dragonbreath
	23141,		--Yarzill the Merc
	23149,		--Mistress of the Mines
	23376,		--Dragonmaw Foreman
	23291,		--Chief Overseer Mudlump
	23434,		--Commander Hobb
	23452,		--Commander Arcus
	23139,		--Overlord Mor'ghor
	--SSO
	25112,		--Anchorite Ayuri
	24967,		--Captain Theris Dawnhearth
	25046,		--Smith Hauthaa
	24937,		--Magistrix Seyla
	25069,		--Magister Ilastar
	24975,		--Mar'nah
	25088,		--Captain Valindria
	25057,		--Battlemage Arynna
	24965,		--Vindicator Xayann
	19202,		--Emissary Mordin
	25108,		--Vindicator Kaalan
	24932,		--Exarch Nasuun
	25133,		--Astromancer Darnarian
	25140,		--Lord Torvos
	25061,		--Harbinger Inuuro
	19475,		--Harbinger Haronem
	25112,		--Anchorite Ayuri
	--Professions
	24393,		--The Rokk
	25580,		--Old Man Barlo
	--Instance
	24369,		--Wind Trader Zhareem
	24370,		--Nether-Stalker Mah'duun
	}, ":")


--local function GetGenericToggleOption(questName, order)
--	return {name = questName, type = "toggle", get = "GetQuestEnabled", set = "SetQuestEnabled", order = order}
--end



function module:GetOptionsTable()
	local options = {
		name = L["Burning Crusade"],
		type = "group",
		handler = module,
		order = 2,
		get = "Multi_Get", set = "Multi_Set",
		args = {
			faction = {
				name = L["Faction"], type = "group", order = 1,
				args = {
					skettis = {
						name = L["Sha'tari Skyguard"], type = "multiselect", order = 1,
						values = { LQ["Fires Over Skettis"], LQ["Escape from Skettis"],	--Skettis
							LQ["Wrangle More Aether Rays!"], LQ["Bomb Them Again!"] }, --Blade's Edge Mountains
					},
					ogrila = {
						name = L["Og'rila"], type = "multiselect", order = 2,
						values = { LQ["The Relic's Emanation"], LQ["Banish More Demons"] },
					},
					netherwing = {
						name = L["Netherwing"], type = "group", order = 3,
						args = {
							Netrual = {
								name = L["Netural"], type = "multiselect", order = 1, width = "full",
								values = { LQ["Nethercite Ore"], LQ["Netherdust Pollen"], LQ["Nethermine Flayer Hide"],
									LQ["Netherwing Crystals"], LQ["The Not-So-Friendly Skies..."], LQ["A Slow Death"] },
							},
							Friendly = {
								name = L["Friendly"], type = "multiselect", order = 2, width = "full",
								values = { LQ["Picking Up The Pieces..."], LQ["Dragons are the Least of Our Problems"],
									LQ["The Booterang: A Cure For The Common Worthless Peon"] },
							},
							HonorRev = {
								name = L["Honored"].." / "..L["Revered"], type = "multiselect", order = 3, width = "full",
								values = { LQ["Disrupting the Twilight Portal"], LQ["The Deadliest Trap Ever Laid"] },
							},
						},
					},
					sso = module:GenerateSSOOptions(),
				},
			},	--End of Faction Table
			professions = {name = L["Professions"], type = "group", order = 2,
				args = {
					cooking = {
						name = L["Cooking"], type = "group", order = 1, inline = true,
						args = {
							questRewards = { 
								name = L["Quest Rewards"], type = "group", order = 2, 
								get = "GetQuestOption", set = "SetQuestOption", inline = true,
								args = {
									shs = { name = LQ["Super Hot Stew"], order = 1, type = "select", values = cooking_values },
									s4s = { name = LQ["Soup for the Soul"], order = 2, type = "select", values = cooking_values },
									rit = { name = LQ["Revenge is Tasty"] , order = 2, type = "select", values = cooking_values },
									mal = { name = LQ["Manalicious"], order = 2, type = "select", values = cooking_values },
								},
							},
							quests = {
								name = L["Quests"], type = "multiselect", order = 1,
								values = { LQ["Super Hot Stew"], LQ["Soup for the Soul"], LQ["Revenge is Tasty"], LQ["Manalicious"] },
							},
						},
					},	--End of Cooking
					fishing = {
						name = L["Fishing"], type = "multiselect",
						values = { LQ["Crocolisks in the City"], LQ["Bait Bandits"], LQ["Felblood Fillet"], LQ["Shrimpin' Ain't Easy"], LQ["The One That Got Away"] },
					},
				},
			},	--end of professions table
			pvp = {
				name = L["PvP"], type = "group", order = 3,
				args = {
					battlegrounds = {
						name = L["Battlegrounds"], type = "multiselect", order = 1, width = "full",
						values = { LQ["Call to Arms: Eye of the Storm"] },
					},
					world = {
						name = L["World PvP"], type = "multiselect", order = 2,
						values = { LQ["Hellfire Fortifications"], LQ["Spirits of Auchindoun"], LQ["Enemies, Old and New"], LQ["In Defense of Halaa"] },
					},
				},
			},
			instances = {
				name = L["Instances"], type = "group", order = 4,
				args = {
					normal = {
						name = L["Instances"], type = "multiselect", width = "full",
						values = { 
							[LQ["Wanted: Arcatraz Sentinels"]] = LQ["Wanted: Arcatraz Sentinels"]:gsub(L["Wanted: "], ""),
							[LQ["Wanted: Coilfang Myrmidons"]] = LQ["Wanted: Coilfang Myrmidons"]:gsub(L["Wanted: "], ""),
							[LQ["Wanted: Malicious Instructors"]] = LQ["Wanted: Malicious Instructors"]:gsub(L["Wanted: "], ""),
							[LQ["Wanted: Rift Lords"]] = LQ["Wanted: Rift Lords"]:gsub(L["Wanted: "], ""),
							[LQ["Wanted: Shattered Hand Centurions"]] = LQ["Wanted: Shattered Hand Centurions"]:gsub(L["Wanted: "], ""),
							[LQ["Wanted: Sunseeker Channelers"]] = LQ["Wanted: Sunseeker Channelers"]:gsub(L["Wanted: "], ""),
							[LQ["Wanted: Tempest-Forge Destroyers"]] = LQ["Wanted: Tempest-Forge Destroyers"]:gsub(L["Wanted: "], ""),
							[LQ["Wanted: Sisters of Torment"]] = LQ["Wanted: Sisters of Torment"]:gsub(L["Wanted: "], ""),
							},
					},
					heroic = {
						name = L["Heroic Instances"], type = "multiselect", width = "full",
						values = {
							[LQ["Wanted: A Black Stalker Egg"]] = LQ["Wanted: A Black Stalker Egg"]:gsub(L["Wanted: "], ""),
							[LQ["Wanted: A Warp Splinter Clipping"]] = LQ["Wanted: A Warp Splinter Clipping"]:gsub(L["Wanted: "], ""),
							[LQ["Wanted: Aeonus's Hourglass"]] = LQ["Wanted: Aeonus's Hourglass"]:gsub(L["Wanted: "], ""),
							[LQ["Wanted: Bladefist's Seal"]] = LQ["Wanted: Bladefist's Seal"]:gsub(L["Wanted: "], ""),
							[LQ["Wanted: Keli'dan's Feathered Stave"]] = LQ["Wanted: Keli'dan's Feathered Stave"]:gsub(L["Wanted: "], ""),
							[LQ["Wanted: Murmur's Whisper"]] = LQ["Wanted: Murmur's Whisper"]:gsub(L["Wanted: "], ""),
							[LQ["Wanted: Nazan's Riding Crop"]] = LQ["Wanted: Nazan's Riding Crop"]:gsub(L["Wanted: "], ""),
							[LQ["Wanted: Pathaleon's Projector"]] = LQ["Wanted: Pathaleon's Projector"]:gsub(L["Wanted: "], ""),
							[LQ["Wanted: Shaffar's Wondrous Pendant"]] = LQ["Wanted: Shaffar's Wondrous Pendant"]:gsub(L["Wanted: "], ""),
							[LQ["Wanted: The Epoch Hunter's Head"]] = LQ["Wanted: The Epoch Hunter's Head"]:gsub(L["Wanted: "], ""),
							[LQ["Wanted: The Exarch's Soul Gem"]] = LQ["Wanted: The Exarch's Soul Gem"]:gsub(L["Wanted: "], ""),
							[LQ["Wanted: The Headfeathers of Ikiss"]] = LQ["Wanted: The Headfeathers of Ikiss"]:gsub(L["Wanted: "], ""),
							[LQ["Wanted: The Heart of Quagmirran"]] = LQ["Wanted: The Heart of Quagmirran"]:gsub(L["Wanted: "], ""),
							[LQ["Wanted: The Scroll of Skyriss"]] =  LQ["Wanted: The Scroll of Skyriss"]:gsub(L["Wanted: "], ""),
							[LQ["Wanted: The Warlord's Treatise"]] = LQ["Wanted: The Warlord's Treatise"]:gsub(L["Wanted: "], ""),
							[LQ["Wanted: The Signet Ring of Prince Kael'thas"]] = LQ["Wanted: The Signet Ring of Prince Kael'thas"]:gsub(L["Wanted: "], ""),}
					},
				},
			},
		}, --Top Lvl Args
	}--Top lvl options
	return options
end

function module:GenerateSSOOptions()
	local table = {
		name = L["Shattered Sun Offensive"], type = "group", order = 4,
		args = {
			p1 = {
				name = L["SSO Phase 1"], type = "multiselect", order = 1, width = "full",
				values = {LQ["Erratic Behavior"], LQ["The Sanctum Wards"], },
			},
			p2a = {
				name = L["SSO Phase 2a"], type = "multiselect", order = 2, width = "full",
				values = {LQ["Further Conversions"], LQ["Arm the Wards!"],--Final for "Erratic Behavior" & "The Sanctum Wards"
					LQ["The Battle for the Sun's Reach Armory"], LQ["Distraction at the Dead Scar"],
					LQ["Intercepting the Mana Cells"], },
			},
			p2b = {
				name = L["SSO Phase 2b"], type = "multiselect", order = 3, width = "full",
				values = {LQ["Maintaining the Sunwell Portal"], LQ["Know Your Ley Lines"],}, --Final for "Intercepting the Mana Cells"
			},
			p3a = {
				name = L["SSO Phase 3a"], type = "multiselect", order = 4, width = "full",
				values = {LQ["The Battle Must Go On"], LQ["The Air Strikes Must Continue"], --Final for "Battle for Sun's Reach Armory" & "Distraction at the Dad Scar"
					LQ["Intercept the Reinforcements"], LQ["Taking the Harbor"], LQ["Making Ready"], },
			},
			p3b = {
				name = L["SSO Phase 3b"], type = "multiselect", order = 5, width = "full",
				values = {LQ["Don't Stop Now...."], LQ["Ata'mal Armaments"],}, --Final for "Making Ready"
			},
			p4a = {
				name = L["SSO Phase 4a"], type = "multiselect", order = 6, width = "full",
				values = {LQ["Keeping the Enemy at Bay"], LQ["Crush the Dawnblade"], --Final for "Intercept the Reinforcements" & "Taking the Harbor"
					LQ["Discovering Your Roots"], LQ["A Charitable Donation"], LQ["Disrupt the Greengill Coast"], },
			},
			p4b = {
				name = L["SSO Phase 4b"], type = "multiselect", order = 7, width = "full",
				values = { LQ["Your Continued Support"], }, --FInal for "A Charitable Donation"
			},
			p4c = {
				name = L["SSO Phase 4c"], type = "multiselect", order = 8, width = "full",
				values = { LQ["Rediscovering Your Roots"],LQ["Open for Business"],}, --Final for "Discovering Your Roots"
			},
			misc = {
				name = L["SSO_MISC"], type = "multiselect", order = 9,
				values = { LQ["The Multiphase Survey"], LQ["Blood for Blood"], LQ["Blast the Gateway"], LQ["Sunfury Attack Plans"], LQ["Gaining the Advantage"], },
			},
			b4bQo = {
				name = LQ["Blood for Blood"], type = "select", order = 10, 
				values = { (GetItemInfo(30809)), (GetItemInfo(30810)), L["None"] },
				get = "GetQuestOption", set = "SetQuestOption",
			},
			aaQo = {
				name = LQ["Ata'mal Armaments"], type = "select", order = 11,
				values = { (GetItemInfo(34538)), (GetItemInfo(34539)), L["None"] },
				get = "GetQuestOption", set = "SetQuestOption",
			},
		},
	}
	return table
end

--function module:GetQuestEnabled(info)
--	return db.profile[info.option.name]
--end

--function module:SetQuestEnabled(info, val)
--	db.profile[info.option.name] = val
--end

function module:GetQuestOption(info)
	local name = info.option.name
	if db.profile.qOptions[name] == nil then
		db.profile.qOptions[name] = 3
	end
	return db.profile.qOptions[name]
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
