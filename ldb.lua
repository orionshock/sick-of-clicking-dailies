local AddonParent = LibStub("AceAddon-3.0"):GetAddon("SickOfClickingDailies")

local D = AddonParent.D

local module = AddonParent:NewModule("LDB")
local L = LibStub("AceLocale-3.0"):GetLocale("SOCD_Core")
local db, completedQuests, specialResetQuests
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
module.sortedQuestTable = {}

function module:OnInitialize()
	db = AddonParent.db
	completedQuests = db.char.completedQuests
	LibStub("AceEvent-3.0").RegisterMessage(self, "SOCD_DAILIY_QUEST_COMPLETE")
	self:PruneHistory()
	module:SortQuestCompleTable()
	specialResetQuests = AddonParent.specialResetQuests
	self:CreateLDB()

	db.RegisterCallback(self, "OnProfileChanged", "RefreshConfig")
	db.RegisterCallback(self, "OnProfileCopied", "RefreshConfig")
	db.RegisterCallback(self, "OnProfileReset", "RefreshConfig")
end

function module:RefreshConfig(event, f_db, profileName)
	completedQuests = db.char.completedQuests
	D(self:GetName(), event, profileName)
end

function module:SOCD_DAILIY_QUEST_COMPLETE(event, quest, npc, opt, id)
	D(event, quest, npc, opt, id)
	id = id or "??"
	if specialResetQuests[quest] then
		completedQuests[quest.." ~ "..date()] = self[ specialResetQuests[quest] ](self)
	else
		completedQuests[quest] = time()+ GetQuestResetTime()
	end
	module:SortQuestCompleTable()
end


local ldbObj, SecondsToTime, GetQuestResetTime = nil, SecondsToTime, GetQuestResetTime
local prefix = QUEST_LOG_DAILY_TOOLTIP:match( "\n(.+)" )
local function OnTooltipShow(self)
	self:AddDoubleLine( prefix:format( SecondsToTime(GetQuestResetTime()) ),  QUEST_LOG_DAILY_COUNT_TEMPLATE:format(GetDailyQuestsCompleted(), GetMaxDailyQuests())  )
	if next(completedQuests) and db.char.showExTT then
		self:AddLine(" ")
		self:AddDoubleLine(QUESTS_COLON)
		for i, quest in pairs(module.sortedQuestTable) do
			self:AddDoubleLine(quest, date("%c", completedQuests[quest]) )
		end
	end
	self:AddLine(" ")
	self:AddDoubleLine( L["Click: Left for Quest Log"], L["Right for SOCD Options"] )
end

function module:SortQuestCompleTable()
	wipe(self.sortedQuestTable)
	for k, v in pairs(completedQuests) do
		tinsert( self.sortedQuestTable, k)
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




local frame = CreateFrame("frame")
local Group = frame:CreateAnimationGroup()
local Ani = Group:CreateAnimation("Animation")
Ani:SetDuration(60)
Ani:SetOrder(1)
Group:SetLooping("REPEAT")



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
	Group:Play()
end

local function UpdateLDB_Object(frame, elapsed)
	local ttl = GetQuestResetTime()
	ldbObj.value = SecondsToTime(ttl)
	ldbObj.text = (ldbObj.label)..(ldbObj.value)
	if ttl > 86300 or tonumber(date("%H%M")) < 359 then	--86390 is early in the day & 259 is 2:59am
		module:PruneHistory()
	end
end

Group:SetScript("OnLoop", UpdateLDB_Object)

function module:PruneHistory()
	for quest, ttl in pairs(completedQuests) do
		if time() > ttl then
			D("Pruning", quest, "Exired on:", date("%c", ttl), "current Time:", date() )
			completedQuests[quest] = nil
		end
	end
	self:SortQuestCompleTable()
end



------------


function module:GetOptionsTable(rootTable)
	local ldb_Options = {
		showExTT = { type = "toggle", name = L["Show Extended Daily Quest Info in LDB Tooltip"], width = "full",
		get = function(info) return db.char.showExTT end, set = function(info, val) db.char.showExTT = val end, order = 1,
		},
	}
	rootTable.args.MiscOpt.plugins.LDB = ldb_Options
	return nil
end


local diff_To_Tuesday = {
	[1] = 2,		--sunday
	[2] = 1,		--monday
	[3] = 4,		--tuesday*
	[4] = 3,		--wed	
	[5] = 2,		--thur
	[6] = 1,		--fri
	[7] = 3,		--sat	*
}

local diff = {}
function module:GetNextWGReset()

	local cur_day, cur_month, cur_year = tonumber(date("%d")), tonumber(date("%m")), tonumber(date("%Y"))
	local cur_wDay = tonumber(date("%w")) + 1
	for k, _ in pairs(diff) do diff[k] = nil end
--	{
--		day = 23,
--		hour = 20,
--		isdst = false,
--		min = 16,
--		month = 8,
--		sec = 25,
--		wday = 1,
--		yday = 235,
--		year = 2009
--	}
	local monthNumDay = select(3, CalendarGetMonth(0))
	local newDay = cur_day + diff_To_Tuesday[cur_wDay]
	if newDay > monthNumDay then
		newDay = newDay - monthNumDay
		diff.day = newDay
		if cur_month +1 > 12 then
			diff.month = 1
			diff.year = cur_year + 1
		else
			diff.month = cur_month +1
			diff.year = cur_year
		end
	else
		diff.day = newDay
		diff.year = cur_year
		diff.month = cur_month
		
	end
	diff.hour = date("%H", time() + GetQuestResetTime())
	diff.min = date("%M", time() + GetQuestResetTime())
	D("Found next tuesday on:", date("%c", time(diff) ) )
	return time(diff)
end
