
local AddonName, AddonParent = ...

local module = AddonParent:NewModule("LDB", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale(AddonName)
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local SortedQuestList, questsCompleted = {}


local SecondsToTime, GetQuestResetTime = SecondsToTime, GetQuestResetTime
local ldbObj, LibDataBroker, db, SpecialQuestResets, playerName, LibQTip

function module:OnInitialize()
	self:Debug("OnInit")
	LibStub("AceEvent-3.0").RegisterMessage(self, "SOCD_DAILIY_QUEST_COMPLETE")

	db = AddonParent.db
	questsCompleted = db.char.questsCompleted
	SpecialQuestResets = AddonParent.SpecialQuestResets

	LibDataBroker = LibStub("LibDataBroker-1.1", true)
	LibQTip = LibStub('LibQTip-1.0', true)
end

function module:OnEnable()
	self:Debug("OnEnable")
	self:CreateLDB()
	playerName = UnitName("player")
	db.factionrealm[playerName] = db.factionrealm[playerName] or {}
end

local function specialSort(a,b)
	if SortedQuestList[a] and SortedQuestList[b] then
		return a < b
	end
	if SortedQuestList[a] and ( not SortedQuestList[b] ) then
		return false
	end
	if (not SortedQuestList[a]) and SortedQuestList[b] then
		return true
	end
	return a < b
end

function module:UpdateSortedList()
	wipe(SortedQuestList)
	for k, v in pairs( questsCompleted ) do
		SortedQuestList[ #SortedQuestList + 1] = k
	end
	table.sort(SortedQuestList, specialSort)	
end

function module:SOCD_DAILIY_QUEST_COMPLETE(event, quest, opt)
	self:Debug(event, quest, opt)
	local reset
	if SpecialQuestResets[quest] then
		reset = self[ SpecialQuestResets[quest] ](self)
	else
		reset = time()+GetQuestResetTime()-1
	end
	questsCompleted[quest] = reset
	db.factionrealm[playerName][quest] = reset
	self:Debug("Quest:", quest, "Resets at:", date("%c", reset) )

	self:UpdateSortedList()
end

local prefix = QUEST_LOG_DAILY_TOOLTIP:match( "\n(.+)" )
local function OnTooltipShow(self)
	self:AddDoubleLine( prefix:format( SecondsToTime(GetQuestResetTime()) ),  QUEST_LOG_DAILY_COUNT_TEMPLATE:format(GetDailyQuestsCompleted(), GetMaxDailyQuests())  )
	self:AddLine(" ")
	self:AddDoubleLine( L["Click: Left for Quest Log"], L["Right for SOCD Options"] )
end

local function PopulateLibQTip(self)
	local tip = LibQTip:Acquire("SOCD-LDBTip", 3, "LEFT", "CENTER", "RIGHT")
	module.tooltip = tip
	tip:AddHeader(AddonName)	
	local y, x = tip:AddLine(prefix:format( SecondsToTime(GetQuestResetTime()) ),"  ",  QUEST_LOG_DAILY_COUNT_TEMPLATE:format(GetDailyQuestsCompleted(), GetMaxDailyQuests()))
	tip:AddLine( " ", " ", " ")
	for i = 1, #SortedQuestList do
		local q = SortedQuestList[i]
		if SpecialQuestResets[q] then
			tip:AddLine( q, "*", date("%c", questsCompleted[ q ] ) )
		else
			tip:AddLine( q, "   ", date("%c", questsCompleted[ q ] ) )
		end
	end
	tip:AddLine( " ", " ", " ")
	tip:AddLine( L["Click: Left for Quest Log"], " ", L["Right for SOCD Options"] )
	tip:SmartAnchorTo(self)
	tip:Show()
end



local function OnEnter(self)
	if module.tooltip and module.tooltip:IsShown() then
		return
	end
	if LibQTip then
		PopulateLibQTip(self)
		return
	end
	GameTooltip:SetOwner(self, "ANCHOR_NONE")
	GameTooltip:SetPoint("TOPLEFT", self, "BOTTOMLEFT")
	GameTooltip:ClearLines()
	OnTooltipShow(GameTooltip)
	GameTooltip:Show()
end

local function OnLeave(self)
	if module.tooltip then
		LibQTip:Release(module.tooltip)
		module.tooltip = nil
		return
	end
	GameTooltip:Hide()
end

local function OnClick(frame, button)
	if button == "LeftButton" then
		ToggleFrame(QuestLogFrame)
	elseif button == "RightButton" then
		if  AceConfigDialog.OpenFrames[AddonName] then
			AceConfigDialog:Close(AddonName)
		else
			AceConfigDialog:Open(AddonName)
		end
	end
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
		OnTooltipShow = OnTooltipShow,
		OnClick = OnClick,
	}
	dailyTTL.text = (dailyTTL.label)..(dailyTTL.value)
	ldbObj = LibDataBroker:NewDataObject("SOCD - Daily Reset", dailyTTL)
end

function module:UpdateLDBText()
	local ttl = GetQuestResetTime()
	ldbObj.value = SecondsToTime(ttl, true)
	ldbObj.text = (ldbObj.label)..(ldbObj.value)
end

local TimerFrame = CreateFrame("frame")
module.TimerFrame = TimerFrame

local delay, interval = 50,60
local timeToEndOfDay
TimerFrame:SetScript("OnUpdate", function(self, elapsed)
	delay = delay + elapsed
	if delay > interval then
		module:UpdateLDBText()
		delay = 0
	end
end)

---------------------------------------------
-- Reset Functions
---------------------------------------------

function module:Exclude()
	return nil
end


do		-- === Wintergrasp Reset Function ===
	--Project Ticket #72;  --Code Attributed to ethancentaurai for reset interval being 1 day ahead of the US schedule.
	local diff_to_next_wg_reset = GetCVar("realmList"):find("^eu%.") and { -- Europe
		[1] = 3,	-- sunday
		[2] = 2,	-- monday
		[3] = 1,	-- tuesday
		[4] = 7,	-- wednesday *
		[5] = 6,	-- thursday
		[6] = 5,	-- friday
		[7] = 4,	-- saturday
	} or { -- the rest of the world
		[1] = 2,	-- sunday
		[2] = 1,	-- monday
		[3] = 7,	-- tuesday *
		[4] = 6,	-- wednesday
		[5] = 5,	-- thursday
		[6] = 4,	-- friday
		[7] = 3,	-- saturday
	}
	----End fix for ticket #72

	local diff = {}
	function module:GetNextWGReset()
		local cur_day, cur_month, cur_year = tonumber(date("%d")), tonumber(date("%m")), tonumber(date("%Y"))
		local cur_wDay = tonumber(date("%w")) + 1
		for k, _ in pairs(diff) do diff[k] = nil end

		local monthNumDay = select(3, CalendarGetMonth(0))
		local newDay = cur_day + diff_to_next_wg_reset[cur_wDay]
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
end
