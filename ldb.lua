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
local db
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

function module:OnInitialize()
	self:CreateLDB()
	db = AddonParent.db.char
	LibStub("AceEvent-3.0").RegisterMessage(self, "SOCD_DAILIY_QUEST_COMPLETE")
	self:PruneHistory()
end

function module:SOCD_DAILIY_QUEST_COMPLETE(event, quest, npc, opt)
	db[quest] = time()+ GetQuestResetTime()
	print(event,"Q:",quest, "TTL", db[quest], "//", date(db[quest]) )

end


local ldbObj, SecondsToTime, GetQuestResetTime = nil, SecondsToTime, GetQuestResetTime
local prefix = QUEST_LOG_DAILY_TOOLTIP:match( "\n(.+)" )
local function OnTooltipShow(self)
	self:AddLine( prefix:format( SecondsToTime(GetQuestResetTime()) ) )
	self:AddLine( QUEST_LOG_DAILY_COUNT_TEMPLATE:format(GetDailyQuestsCompleted(), GetMaxDailyQuests()) )
	self:AddLine(" ")
	self:AddDoubleLine( L["Left Click to Toggle Quest Log"], L["Right Click to Toggle SOCD Options"] )
	if next(db) then	
		self:AddLine(" ")
		self:AddDoubleLine("Quest", "Reset Time")
		for quest, eta in pairs(db) do
			self:AddDoubleLine(quest, date("%c", eta) )
		end
	end	
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
	for quest, ttl in pairs(db) do
		if time() > ttl then
			db[quest] = nil
		end
	end
end
