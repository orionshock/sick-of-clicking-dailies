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
			print("SOCD-LDB: "..str)
		end
		return str
	end
end


local module = AddonParent:NewModule("LDB")
local L = LibStub("AceLocale-3.0"):GetLocale("SOCD_Core")
local db, completedQuests
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
module.sortedQuestTable = {}

function module:OnInitialize()
	self:CreateLDB()
	db = AddonParent.db.char
	completedQuests = db.completedQuests
	LibStub("AceEvent-3.0").RegisterMessage(self, "SOCD_DAILIY_QUEST_COMPLETE")
	self:PruneHistory()
	module:SortQuestCompleTable()
end

function module:SOCD_DAILIY_QUEST_COMPLETE(event, quest, npc, opt)
	completedQuests[quest] = time()+ GetQuestResetTime()
	module:SortQuestCompleTable()
end


local ldbObj, SecondsToTime, GetQuestResetTime = nil, SecondsToTime, GetQuestResetTime
local prefix = QUEST_LOG_DAILY_TOOLTIP:match( "\n(.+)" )
local function OnTooltipShow(self)
	self:AddDoubleLine( prefix:format( SecondsToTime(GetQuestResetTime()) ),  QUEST_LOG_DAILY_COUNT_TEMPLATE:format(GetDailyQuestsCompleted(), GetMaxDailyQuests())  )
	if next(completedQuests) and db.showExTT then
		self:AddLine(" ")
		self:AddDoubleLine(QUESTS_COLON)
		for i, quest in pairs(module.sortedQuestTable) do
			self:AddDoubleLine(quest, date("%x", completedQuests[quest]) )
		end
	end
	self:AddLine(" ")
	self:AddDoubleLine( L["Click: Left for Quest Log"], L["Right for SOCD Options"] )
end

function module:SortQuestCompleTable()
	wipe(self.sortedQuestTable)
	for k, v in pairs(completedQuests) do
		if not AddonParent.specialResetQuests[k] then
			tinsert( self.sortedQuestTable, k)
		end
	end
	table.sort(self.sortedQuestTable)
end

local function OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_NONE")
	GameTooltip:SetPoint("TOPLEFT", self, "BOTTOMLEFT")
	GameTooltip:ClearLines()
	OnTooltipShow(GameTooltip)
	GameTooltip:Show()
end

local function OnLeave(self)
	GameTooltip:Hide()
end

local function OnClick(frame, button)
	if button == "LeftButton" then
		ToggleFrame(QuestLogFrame)
	elseif button == "RightButton" then
		if  AceConfigDialog.OpenFrames["SickOfClickingDailies"] then
			AceConfigDialog:Close("SickOfClickingDailies")
		else
			AceConfigDialog:Open("SickOfClickingDailies")
		end
	end
end

function module:CreateLDB()
	local ldb = LibStub("LibDataBroker-1.1", true)
	if not ldb then
		self.ldb = false
		return
	end
	local dailyTTL = {
		type = "data source",
		icon = "Interface\\Icons\\Achievement_Quests_Completed_Daily_08",
		label = L["Dailies reset in"]..": ",
		value = SecondsToTime(GetQuestResetTime()) or "~Updating~",
		OnEnter = OnEnter,
		OnLeave = OnLeave,
		OnTooltipShow = OnTooltipShow,
		OnClick = OnClick,
	}
	dailyTTL.text = (dailyTTL.label)..(dailyTTL.value)
	self.ldb = ldb:NewDataObject("SOCD Dailies Reset Timmer", dailyTTL)
	ldbObj = self.ldb
end

local frame = CreateFrame("frame")
local delay, interval = 50, 60
local lastttl
frame:SetScript("OnUpdate", function(frame, elapsed)
	delay = delay + elapsed
	local ttl = GetQuestResetTime()
	if delay > interval then
		ldbObj.value = SecondsToTime(ttl)
		ldbObj.text = (ldbObj.label)..(ldbObj.value)
		delay = 0
	end
	if ttl > 86390 then
		module:PruneHistory()
	end
end)


function module:PruneHistory()
	for quest, ttl in pairs(completedQuests) do
		if time() > ttl then
			completedQuests[quest] = nil
		end
	end
end



------------


function module:GetOptionsTable()
	local t = {
		name = L["LDB Options"],
		type = "group",
		args = {
			showExTT = {type = "toggle", name = L["Show Extended Tooltip"], get = function(info) return db.showExTT end, set = function(info, val) db.showExTT = val end, },
		},
	}
	return t
end
