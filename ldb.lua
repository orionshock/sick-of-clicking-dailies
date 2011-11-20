
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
	
	self:CreateLDB()
	playerName = UnitName("player")
	self:PruneDB()
	db.realm.chars[playerName] = select(2, UnitClass("player"))
	db.realm.questLog[playerName] = db.realm.questLog[playerName] or {}
	
end

function module:SOCD_DAILIY_QUEST_COMPLETE(event, title, ttl)
	if (not title) or (not ttl) then return end
	db.char[title] = ttl
	db.realm.questLog[playerName][title] = ttl
end
function module:SOCD_WEEKLY_QUEST_COMPLETE(event, title, ttl)
	if (not title) or (not ttl) then return end
	db.char[title] = ttl
	db.realm.questLog[playerName][title] = ttl
end


do
	local tooltip
	local prefix = QUEST_LOG_DAILY_TOOLTIP:match( "\n(.+)" )
	local function Tooltip_OnClick_Sort(self, sortBy, button)
		module:Debug("TT_OnClick_Sort", self, sortBy, button)
	end
	local function OnEnter(self, ...)
		module:Debug("OnEnter", self, ...)
		if tooltip and tooltip:IsShown() then return end
		tooltip = LibQTip:Acquire("SOCD_LDB_PlayerTrack", 3, "RIGHT", "LEFT", "CENTER")
		tooltip:SmartAnchorTo(self)
		tooltip:SetAutoHideDelay(0.25, self)
		
		tooltip:AddHeader("")
		tooltip:SetCell(1,1, AddonName, nil, "LEFT", 3)
		tooltip:AddLine("","","")
		tooltip:SetCell(2, 1, prefix:format( SecondsToTime(GetQuestResetTime()) ), nil, "LEFT", 2)
		tooltip:SetCell(2, 3, QUEST_LOG_DAILY_COUNT_TEMPLATE:format(GetDailyQuestsCompleted(), GetMaxDailyQuests()) , nil, "RIGHT")
		----Element Listing Header
		tooltip:SetColumnLayout(3, "RIGHT", "LEFT", "CENTER")
		tooltip:AddHeader()
		tooltip:SetCell(3, 1, "T", nil, "RIGHT", nil, nil, nil, nil, 16)
		tooltip:SetCellScript(3, 1, "OnMouseDown", Tooltip_OnClick_Sort, "class")
		tooltip:SetCell(3, 2, "Element", nil, "LEFT")
		tooltip:SetCellScript(3, 2, "OnMouseDown", Tooltip_OnClick_Sort, "element")
		tooltip:SetCell(3, 3, "TTL", nil, "CENTER")
		tooltip:SetCellScript(3, 3, "OnMouseDown", Tooltip_OnClick_Sort, "ttl")
		----Elements of Listing

		for j=1,25 do 
			tooltip:AddLine( "|TInterface\\Icons\\INV_Misc_Coin_01:0|t", "Test Quest with long title", "2011/12/31 00:00:00")
		end	

		local lastY, lastX = tooltip:AddLine()
		tooltip:SetCell(lastY, lastX, L["Click: Left for Quest Log"], nil, "LEFT", 2)
		tooltip:SetCell(lastY, lastX+2, L["Right for SOCD Options"] )
		
		tooltip:Show()
	end
	local function OnLeave(self, ...)
		module:Debug("OnLeave", self, ...)
		-- Release the tooltip
		--LibQTip:Release(self.tooltip)
		--self.tooltip = nil
	end
	local function OnClick(self, ...)
		module:Debug("OnClick", self, ...)
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
			OnClick = OnClick,
		}
		dailyTTL.text = (dailyTTL.label)..(dailyTTL.value)
		ldbObj = LibDataBroker:NewDataObject("SOCD - Daily Reset", dailyTTL)
	end

	local interval, delay = 1, 0
	local updateFrame = CreateFrame("frame")
	updateFrame:SetScript("OnUpdate", function(self, elapsed)
		if not ldbObj then return end
		delay = delay + elapsed
		if delay > interval then
			ldbObj.value = SecondsToTime(GetQuestResetTime())
			ldbObj.text = (ldbObj.label)..(ldbObj.value)
			delay = 0
			if GetQuestResetTime() > 86280 then
				module:PruneDB()
			end
		end
	end)
end

function module:PruneDB()
	self:Debug("Pruning non-existant DB")
end