--[[
	Burning Crusade Module

	netherwing
	shat'ar skyguard
	ogrila
	cooking
	fishing
]]--


local AddonParent = LibStub("AceAddon-3.0"):GetAddon("SickOfClickingDailies")
local D = AddonParent.D
local module = AddonParent:NewModule("BC")
local L = LibStub("AceLocale-3.0"):GetLocale("SOCD_Core")
local GT = LibStub("AceLocale-3.0"):GetLocale("SOCD_GossipText")
local LQ = LibStub("AceLocale-3.0"):GetLocale("SOCD_BC")
local db

module.defaults = {
	profile = {
		quests = {
			--This Table will get auto gened by the next block from the locale data
		},
		qOptions = {
				--This section has to be manually set with the localized quest name and a default option of off
				--not very many of these quests so it won't matter :D
			--Cooking
			[ LQ["Super Hot Stew"] ] = -1,
			[ LQ["Soup for the Soul"] ] = -1,
			[ LQ["Revenge is Tasty"] ] = -1,
			[ LQ["Manalicious"] ] = -1,
			--SSO-Misc
			[ LQ["Blood for Blood"] ] = -1,
			[ LQ["Ata'mal Armaments"] ] = -1,
		},
		gossip = {
			[ GT["Do you still need some help moving kegs from the crash site near Razor Hill?"] ] = true,
			[ GT["I'm ready to work for you today!  Give me that ram!"] ] = true,
			[ GT["Do you still need some help shipping kegs from Kharanos?"] ] = true,
			[ GT["I'm ready to work for you today!  Give me the good stuff!"] ] = true,
		},
	},
}
do
	local profile = module.defaults.profile.quests
	for k,v in pairs(LQ) do
		profile[v] = true
	end
	profile[LQ["A Charitable Donation"]] = false
	profile[LQ["Your Continued Support"]] = false
	
	local module_specialQuests = {
		[ L["Candy Bucket"] ] = "Exclude",
	}
	for k,v in pairs(module_specialQuests) do
		AddonParent.specialResetQuests[k] = v
	end
end

function module:OnInitialize()
	--D("OnInit")
	db = AddonParent.db:RegisterNamespace("BC", module.defaults)
	self.db = db
	db.RegisterCallback(self, "OnProfileChanged", "RefreshConfig")
	db.RegisterCallback(self, "OnProfileCopied", "RefreshConfig")
	db.RegisterCallback(self, "OnProfileReset", "RefreshConfig")
end

function module:RefreshConfig(event, db, newProfile)
	D(self:GetName(), event, newProfile)
	if self:IsEnabled() then
		AddonParent:UnRegisterQuests("BC")
		AddonParent:RegisterQuests("BC", db.profile.quests, db.profile.qOptions, db.profile.gossip)
	end
end

function module:OnEnable()
	SetItemRef("item:30809","item:30809")	--Aldor Mark
	SetItemRef("item:30809","item:30809")

	SetItemRef("item:30810","item:30810")	--Scryer Mark
	SetItemRef("item:30810","item:30810")

	SetItemRef("item:34538","item:34538")	--Melee weapon
	SetItemRef("item:34538","item:34538")

	SetItemRef("item:34539","item:34539")	--Caster weapon
	SetItemRef("item:34539","item:34539")

	SetItemRef("item:33844","item:33844")	--Barrel of Fish
	SetItemRef("item:33844","item:33844")

	SetItemRef("item:33857","item:33857")	--Crate Of Meat
	SetItemRef("item:33857","item:33857")
	
	AddonParent:RegisterQuests("BC", db.profile.quests, db.profile.qOptions, db.profile.gossip)
end

function module:OnDisable()
	D("OnDisable")
	AddonParent:UnRegisterQuests("BC")
end

function module:GetOptionsTable()
	local cooking_values = { (GetItemInfo(33844)) or "Barrel of Fish", (GetItemInfo(33857)) or "Crate Of Meat", L["None"]}
	local options = {
		name = L["BC"],
		type = "group",
		handler = module,
		order = 2,
		childGroups = "tab",
		get = "Multi_Get", set = "Multi_Set",
		args = {
			world = module:GetWorldQuests(),	--End of Faction Table
			professions = module:GetProfessionQuests(),	--end of professions table
			pvp = module:GetPvPQuests(),
			instances = module:GetInstanceQuests(),
		}, --Top Lvl Args
	}--Top lvl options
	return options
end

function module:GetWorldQuests()
	local str = [[
	return function(L, LQ, module, GT)
	local t = {
		name = CHANNEL_CATEGORY_WORLD, type = "group", order = 1,
		args = {
			skettiswrap = { type = "group", name = L["Sha'tari Skyguard"],
				args = {
					skettis = {
						name = L["Sha'tari Skyguard"], type = "multiselect", width = "full",
						values = { LQ["Fires Over Skettis"], LQ["Escape from Skettis"],	--Skettis
							LQ["Wrangle More Aether Rays!"], LQ["Bomb Them Again!"] }, --Blade's Edge Mountains
					},
				}
			},
			ogrilawrap = { type = "group", name = L["Og'rila"],
				args = {
					ogrila = {
						name = L["Og'rila"], type = "multiselect", width = "full",
						values = { LQ["The Relic's Emanation"], LQ["Banish More Demons"] },
					},
				},
			},
			netherwing = {
				name = L["Netherwing"], type = "group",
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
			events = { type = "group", name = "World Events",
				args = {
					brewfest = { name = L["Brewfest"], type = "group",
						args = {
							help = { type = "description", name = L["Please See http://www.wowwiki.com/Brewfest for more details about Brewfest"], order = 1, },
							gen = { type = "multiselect", width = "full", name = L["Brewfest"],
								values = { LQ["Bark for T'chali's Voodoo Brewery!"], LQ["Bark for Drohn's Distillery!"],
										LQ["Bark for the Barleybrews!"], LQ["Bark for the Thunderbrews!"],
										LQ["Insult Coren Direbrew"], LQ["This One Time, When I Was Drunk..."],
								},
							},
							gossip = { type = "toggle", width = "full", name = L["Brewfewst Racing 'Daily' Gossip"],
								get = "Brewfest_Racing_Gossip", set = "Brewfest_Racing_Gossip",
								desc = L["Gossip selections for the <Ram Racing Master> to allow you to repeat 'There and Back Again' every 12 or 18 hrs"]
							},
						},						
					},
					hallowsEnd = { name = L["Hallow's End"], type = "group",
						args = {
							gen = { type = "multiselect", name = L["Hallow's End"], width = "full",
								values = { L["Candy Bucket"] },
							},
							gossip = { type = "multiselect", width = "full", name = GOSSIP_OPTIONS,
								get = "GossipMulitGet" , set = "GossipMulitSet",
								values = { [ GT["Trick or Treat!"] ]= L["Inkeeper Trick or treating"], },

							},
						},
					},
				},
			},
		},
	}		
	return t
	end ]]
	local t = loadstring(str)()(L, LQ, self, GT)
	return t
end

function module:GenerateSSOOptions()
	local str = [[
	return function(L, LQ, module)
	local t = {
		name = L["Shattered Sun Offensive"], type = "group", 
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
				values = { (GetItemInfo(30809)) or "Aldor Mark", (GetItemInfo(30810)) or "Scryer Mark", nil, nil, L["None"] },
				get = "GetQuestOption", set = "SetQuestOption", width = "double",
			},
			aaQo = {
				name = LQ["Ata'mal Armaments"], type = "select", order = 11,
				values = { [-1] = L["None"], (GetItemInfo(34538)) or "Melee Oil" , (GetItemInfo(34539)) or "Caster Oil" },
				get = "GetQuestOption", set = "SetQuestOption", width = "double",
			},
		},
	}
	return t
	end ]]
	local t = loadstring(str)()(L, LQ, self)
	return t
end

function module:GetProfessionQuests()
	local str = [[
	return function(L, LQ, module)
	local t = {
		name = L["Professions"], type = "group", order = 4,
		args = {
			cookWrap = {
				name = L["Cooking"], type = "group",
				args = {
					quests = { name = L["Quests"], type = "multiselect", order = 1, 
						values = { LQ["Super Hot Stew"], LQ["Soup for the Soul"], LQ["Revenge is Tasty"], LQ["Manalicious"] },
					},
					qRewards = { name = L["Quest Rewards"], type = "select", 
						values = { [-1] =  L["None"], (GetItemInfo(33844)) or "Barrel of Fish", (GetItemInfo(33857)) or "Crate Of Meat"},
						get = "FishingGet", set = "FishingSet", width = "double",
					},
				},
			},	--End of Cooking
			fishWrap = { type = "group", name = L["Fishing"], 
				args = {
					fishing = { name = L["Fishing"], type = "multiselect",
						values = { LQ["Crocolisks in the City"], LQ["Bait Bandits"], LQ["Felblood Fillet"], 
						LQ["Shrimpin' Ain't Easy"], LQ["The One That Got Away"] },
					},
				},
			},
		},
	}
	return t
	end ]]
	local t = loadstring(str)()(L, LQ, self, cooking_values)
	return t
end

function module:GetPvPQuests()
	local str = [[
	return function(L, LQ, module)
	local t = {
		name = L["PvP"], type = "group", order = 3,
		args = {
			battlegrounds = {
				name = L["Battlegrounds"], type = "multiselect", width = "full",
				values = { LQ["Call to Arms: Eye of the Storm"] },
			},
			world = {
				name = L["World PvP"], type = "multiselect", width = "full",
				values = { LQ["Hellfire Fortifications"], LQ["Spirits of Auchindoun"], LQ["Enemies, Old and New"], LQ["In Defense of Halaa"] },
			},
		},
	}
	return t
	end ]]
	local t = loadstring(str)()(L, LQ, self)
	return t
end

local function inScrub(txt)
	return txt:gsub(L["Wanted: "], "")
end
function module:GetInstanceQuests()
	local str = [[
	return function(L, LQ, module, inScrub)
	local t = {
		name = L["Doungeons"], type = "group", order = 2,
		args = {
			normal = {
				name = L["Dungeon"], type = "multiselect", width = "full",
				values = { 
					[ LQ["Wanted: Arcatraz Sentinels"] ] = inScrub(LQ["Wanted: Arcatraz Sentinels"]),
					[ LQ["Wanted: Coilfang Myrmidons"] ] = inScrub(LQ["Wanted: Coilfang Myrmidons"]),
					[ LQ["Wanted: Malicious Instructors"] ] = inScrub(LQ["Wanted: Malicious Instructors"]),
					[ LQ["Wanted: Rift Lords"] ] = inScrub(LQ["Wanted: Rift Lords"]),
					[ LQ["Wanted: Shattered Hand Centurions"] ] = inScrub(LQ["Wanted: Shattered Hand Centurions"]),
					[ LQ["Wanted: Sunseeker Channelers"] ] = inScrub(LQ["Wanted: Sunseeker Channelers"]),
					[ LQ["Wanted: Tempest-Forge Destroyers"] ] = inScrub(LQ["Wanted: Tempest-Forge Destroyers"]),
					[ LQ["Wanted: Sisters of Torment"] ] = inScrub(LQ["Wanted: Sisters of Torment"]),
					},
			},
			heroic = {
				name = L["Heroic Dungeon"], type = "multiselect", width = "full",
				values = {
					[ LQ["Wanted: A Black Stalker Egg"] ] = inScrub(LQ["Wanted: A Black Stalker Egg"]),
					[ LQ["Wanted: A Warp Splinter Clipping"] ] = inScrub(LQ["Wanted: A Warp Splinter Clipping"]),
					[ LQ["Wanted: Aeonus's Hourglass"] ] = inScrub(LQ["Wanted: Aeonus's Hourglass"]),
					[ LQ["Wanted: Bladefist's Seal"] ] = inScrub(LQ["Wanted: Bladefist's Seal"]),
					[ LQ["Wanted: Keli'dan's Feathered Stave"] ] = inScrub(LQ["Wanted: Keli'dan's Feathered Stave"]),
					[ LQ["Wanted: Murmur's Whisper"] ] = inScrub(LQ["Wanted: Murmur's Whisper"]),
					[ LQ["Wanted: Nazan's Riding Crop"] ] = inScrub(LQ["Wanted: Nazan's Riding Crop"]),
					[ LQ["Wanted: Pathaleon's Projector"] ] = inScrub(LQ["Wanted: Pathaleon's Projector"]),
					[ LQ["Wanted: Shaffar's Wondrous Pendant"] ] = inScrub(LQ["Wanted: Shaffar's Wondrous Pendant"]),
					[ LQ["Wanted: The Epoch Hunter's Head"] ] = inScrub(LQ["Wanted: The Epoch Hunter's Head"]),
					[ LQ["Wanted: The Exarch's Soul Gem"] ] = inScrub(LQ["Wanted: The Exarch's Soul Gem"]),
					[ LQ["Wanted: The Headfeathers of Ikiss"] ] = inScrub(LQ["Wanted: The Headfeathers of Ikiss"]),
					[ LQ["Wanted: The Heart of Quagmirran"] ] = inScrub(LQ["Wanted: The Heart of Quagmirran"]),
					[ LQ["Wanted: The Scroll of Skyriss"] ] = inScrub(LQ["Wanted: The Scroll of Skyriss"]),
					[ LQ["Wanted: The Warlord's Treatise"] ] = inScrub(LQ["Wanted: The Warlord's Treatise"]),
					[ LQ["Wanted: The Signet Ring of Prince Kael'thas"] ] = inScrub(LQ["Wanted: The Signet Ring of Prince Kael'thas"]),}
			},
		},
	}
	return t
	end ]]
	local t = loadstring(str)()(L, LQ, self, inScrub)
	return t
end


function module:FishingGet(info)
	return db.profile.qOptions[ LQ["Super Hot Stew"] ]
end

function module:FishingSet(info, val)
	local qOpt = db.profile.qOptions
	qOpt[ LQ["Super Hot Stew"] ] = val
	qOpt[ LQ["Soup for the Soul"] ] = val
	qOpt[ LQ["Revenge is Tasty"] ] = val
	qOpt[ LQ["Manalicious"] ] = val
end

function module:Brewfest_Racing_Gossip(info, value)
	if value == nil then	--get
		return db.profile.gossip[ GT["I'm ready to work for you today!  Give me that ram!"] ]
	else
		db.profile.gossip[ GT["Do you still need some help moving kegs from the crash site near Razor Hill?"] ] = value	--Horde
		db.profile.gossip[ GT["I'm ready to work for you today!  Give me that ram!"] ] = value	--Horde
		db.profile.gossip[ GT["Do you still need some help shipping kegs from Kharanos?"] ] = value	--Alliance
		db.profile.gossip[ GT["I'm ready to work for you today!  Give me the good stuff!"] ] = value
		
	end	
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

function module:GossipMulitGet(info, value, state)
	print("Gossip Get", info, value, state)
	if type(value) == "number" then
		print("return", db.profile.gossip[info.option.values[value] ] )
		return db.profile.gossip[info.option.values[value] ]
	else
		print("return", db.profile.gossip[value])
		return db.profile.gossip[value]
	end

end

function module:GossipMulitSet(info, value, state)
	print("Gossip Set", info, value, state)
	if type(value) == "number" then
		db.profile.gossip[info.option.values[value] ] = state
		print("Set", db.profile.gossip[info.option.values[value] ] )
	else
		db.profile.gossip[value] = state
		print("Set", db.profile.gossip[value] )
	end

end
