--
--	Template Module
--
--
--

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
		ChatFrame1:AddMessage("SOCD-Temp: "..str)
		for i = 1, #temp do
			temp[i] = nil
		end
	end
end

local AddonParent = LibStub("AceAddon-3.0"):GetAddon("SickOfClickingDailies")
local module = AddonParent:NewModule("TEMP")
local L = LibStub("AceLocale-3.0"):GetLocale("SOCD_Core")
local LQ = LibStub("AceLocale-3.0"):GetLocale("SOCD_TEMP")
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
end


function module:OnInitialize()
	D("OnInit")
	db = AddonParent.db:RegisterNamespace("TEMP", module.defaults)
	self.db = db
end

function module:OnEnable()
	D("OnEnable")
	AddonParent:RegisterQuests("TEMP", db.profile, self.npcList, db.profile.qOptions)
end

function module:OnDisable()
	D("OnDisable")
	AddonParent:UnRegisterQuests("TEMP")
end

module.npcList = table.concat({
	"00000"		--Don't forget to replace this

	}, ":")


local function GetGenericToggleOption(questName, order)
	return {name = questName, type = "toggle", get = "GetQuestEnabled", set = "SetQuestEnabled", order = order}
end

function module:GetOptionsTable()
	local options = {
		name = L["TEMP"],
		type = "group",
		handler = module,
		order = 1,
		args = {
			}, --Top Lvl Args
		}--Top lvl options
	return options
end

function module:GetQuestEnabled(info)
	return db.profile[info.option.name]
end

function module:SetQuestEnabled(info, val)
	db.profile[info.option.name] = val
end

function module:GetQuestOption(info)
	return db.profile.qOptions[info.option.name] and db.profile.qOptions[info.option.name] or 3
end

function module:SetQuestOption(info, val)
	db.profile.qOptions[info.option.name] = val
end

