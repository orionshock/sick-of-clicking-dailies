--
-- Classic WoW Dailies:
--	Wintersaber Quests
--	Battleground PvP
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
			print("SOCD-Classic: "..str)
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
local module = AddonParent:NewModule("Classic")
local L = LibStub("AceLocale-3.0"):GetLocale("SOCD_Core")
local LQ = LibStub("AceLocale-3.0"):GetLocale("SOCD_Classic")
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
	db = AddonParent.db:RegisterNamespace("Classic", module.defaults)
	self.db = db
end

function module:OnEnable()
	--D("OnEnable")
	AddonParent:RegisterQuests("Classic", db.profile, self.npcList, db.profile.qOptions)
	--assert(db.profile == AddonParent.moduleQLookup["Classic"])
end

function module:OnDisable()
	--D("OnDisable")
	AddonParent:UnRegisterQuests("Classic")
end

module.npcList = table.concat({
	"10618",	--Rivern Frostwind
	"15351",	--Alliance Brigadier General
	"15350",	--Horde Warbringer
	}, ":")


function module:GetOptionsTable()
	local options = {
		name = L["Classic WoW"],
		type = "group",
		handler = module,
		order = 1,
		get = "Multi_Get", set = "Multi_Set",
		args = {
			Wintersaber = { name = L["Wintersaber Trainers"], type = "multiselect", order = 2, 
				values = { LQ["Frostsaber Provisions"], LQ["Winterfall Intrusion"], LQ["Rampaging Giants"] },
			},--Wintersaber
			PvP = {
				name = L["PvP"], type = "multiselect", order = 1, width = "full",
				values = { LQ["Call to Arms: Warsong Gulch"], LQ["Call to Arms: Arathi Basin"], LQ["Call to Arms: Alterac Valley"] },
			}, --PvP
		}, --Top Lvl Args
	}--Top lvl options
	return options
end

function module:Multi_Get(info, value)
	return db.profile[info.option.values[value]]
end

function module:Multi_Set(info, value, state)
	db.profile[info.option.values[value]] = state
end

