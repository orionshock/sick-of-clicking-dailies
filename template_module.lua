--
--	Template Module
--
--
--

local AddonParent = LibStub("AceAddon-3.0"):GetAddon("SickOfClickingDailies")

local D		--Basic Debug
do
	function D(...)
		local str = ""
		str = string.join(", ", tostringall(...) )
		str = str:gsub("([:=]),", "%1")
		if AddonParent.db and AddonParent.db.global.debug then		
			print("|cff9933FFSOCD-TEMP:|r "..str)
		end
		return str
	end
end

local module = AddonParent:NewModule("TEMP")
local L = LibStub("AceLocale-3.0"):GetLocale("SOCD_Core")
local LQ = LibStub("AceLocale-3.0"):GetLocale("SOCD_TEMP")
local GT = LibStub("AceLocale-3.0"):GetLocale("SOCD_GossipText")
local db

module.defaults = {
	profile = {
		quests = {
			--This Table will get auto gened by the next block from the locale data
		},
		qOptions = {
			--This section has to be manually set with the localized quest name and a default option of off (-1)
			--not very many of these quests so it won't matter :D
		},
		gossip = {
			--This section has to be manually set with the localized gossip text and a default option of true
			--not very many of these quests so it won't matter :D
		},
	},
}
do
	local profile = module.defaults.profile.quests
	for k,v in pairs(LQ) do
		profile[v] = true
	end
	local module_specialQuests = {	--These quests reset on a regular bassis and follow the format of
		--[ LQ["<QuestName>"] ] = "<Type Of Reset>",
					--Use "Exclude" to make repeateable quests that don't reset show up here.
	}
	for k,v in pairs(module_specialQuests) do
		AddonParent.specialResetQuests[k] = v
	end
end


function module:OnInitialize()
	--D("OnInit")
	db = AddonParent.db:RegisterNamespace("TEMP", self.defaults)
	self.db = db
	db.RegisterCallback(self, "OnProfileChanged", "RefreshConfig")
	db.RegisterCallback(self, "OnProfileCopied", "RefreshConfig")
	db.RegisterCallback(self, "OnProfileReset", "RefreshConfig")
end

function module:RefreshConfig(event, db, newProfile)
	D(self:GetName(), event, newProfile)
	if self:IsEnabled() then
		AddonParent:UnRegisterQuests("TEMP")
		AddonParent:RegisterQuests("TEMP", db.profile.quests, db.profile.qOptions, db.profile.gossip)
	end
end


function module:OnEnable()
	--D("OnEnable")
	AddonParent:RegisterQuests("TEMP", db.profile.quests, db.profile.qOptions, db.profile.gossip)
end

function module:OnDisable()
	--D("OnDisable")
	AddonParent:UnRegisterQuests("TEMP")
end


function module:GetOptionsTable()
	local str = [[
	return function(L, module, LQ, GT)
		local t = {
			name = L["TEMP"],
			type = "group",
			handler = module,
			get = "Multi_Get",
			set = "Multi_Set",
			order = 1,
			args = {
				}, --Top Lvl Args
			}--Top lvl options
		return t
	end]]
	local t = loadstring(str)()(L, self, LQ, GT)
	return t
end

--Included for sake of Completeness for single edged quests.
function module:GetQuestEnabled(info)
	return db.profile.quests[info.option.name]
end

function module:SetQuestEnabled(info, val)
	db.profile.quests[info.option.name] = val
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
