
local AddonName, AddonParent = ...

local module = AddonParent:NewModule("LDB", "AceEvent-3.0")
local SortedQuestList, questsCompleted = {}
local L = LibStub("AceLocale-3.0"):GetLocale(AddonName)

local SecondsToTime, GetQuestResetTime = SecondsToTime, GetQuestResetTime
local ldbObj, LibDataBroker, db, SpecialQuestResets, playerName, LibQTip

function module:Debug(...)
	local str = string.join(", ", tostringall(...) )
	str = str:gsub("([:=>]),", "%1")
	str = str:gsub(", ([%-])", " %1")
	ChatFrame5:AddMessage("SOCD-LDB: "..str)
	return str
end


function module:OnInitialize()
	self:Debug("OnInit")
	LibDataBroker = LibStub("LibDataBroker-1.1", true)
	LibQTip = LibStub('LibQTip-1.0', true)
end

function module:OnEnable()
	self:Debug("OnEnable")

	db = AddonParent.db
	questsCompleted = db.char.questsCompleted
	SpecialQuestResets = AddonParent.SpecialQuestResets

	self:CreateLDB()
	playerName = UnitName("player")
	assert(playerName)

end


function module:CreateLDB()
	if not LibDataBroker then
		LibDataBroker = LibStub("LibDataBroker-1.1", true)
		if not LibDataBroker then
			return
		end
	end
	local dailyTTL = {
		type = "data source",
		icon = "Interface\\Icons\\Achievement_Quests_Completed_Daily_08",
		label = L["Dailies reset in"]..": ",
		value = SecondsToTime(GetQuestResetTime(), true) or "~Updating~",
		OnEnter = OnEnter,
		OnLeave = OnLeave,
		--OnTooltipShow = OnTooltipShow,
		OnClick = OnClick,
	}
	dailyTTL.text = (dailyTTL.label)..(dailyTTL.value)
	ldbObj = LibDataBroker:NewDataObject("SOCD - Daily Reset", dailyTTL)
end