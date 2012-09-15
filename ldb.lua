--[[
	Sick Of Clicking Dailies? - DataBroker module
	Written By: OrionShock
]]--

local AddonName, AddonParent = ...

local module = AddonParent:NewModule("LDB", "AceEvent-3.0")
local SortedQuestList, questsCompleted = {}
local L = LibStub("AceLocale-3.0"):GetLocale(AddonName)
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

local SecondsToTime, GetQuestResetTime = SecondsToTime, GetQuestResetTime
local ldbObj, LibDataBroker, db, SpecialQuestResets, playerName, LibQTip

--@debug@
function module:Debug(...)
	local str = string.join(", ", tostringall(...) )
	str = str:gsub("([:=>]),", "%1")
	str = str:gsub(", ([%-])", " %1")
	DEFAULT_CHAT_FRAME:AddMessage("SOCD-LDB: "..str)
	return str
end
--@end-debug@


function module:OnInitialize()
	--self:Debug("OnInit")
	LibDataBroker = LibStub("LibDataBroker-1.1", true)
	LibQTip = LibStub('LibQTip-1.0', true)
end

function module:OnEnable()
	--self:Debug("OnEnable")

	db = AddonParent.db
	
	self:CreateLDB()
	playerName = UnitName("player")
	self:PruneDB()
	db.realm.chars[playerName] = select(2, UnitClass("player"))
	db.realm.questLog[playerName] = db.realm.questLog[playerName] or {}
	AddonParent.RegisterMessage(self, "SOCD_DAILIY_QUEST_COMPLETE")
	AddonParent.RegisterMessage(self, "SOCD_WEEKLY_QUEST_COMPLETE")
	
end

function module:SOCD_DAILIY_QUEST_COMPLETE(event, title, ttl)
	--self:Debug(event, title, ttl)
	if (not title) or (not ttl) then return end
	db.char[title] = ttl
	db.realm.questLog[playerName] = db.realm.questLog[playerName] or {}
	db.realm.questLog[playerName][title] = ttl
end
function module:SOCD_WEEKLY_QUEST_COMPLETE(event, title, ttl)
	--self:Debug(event, title, ttl)
	if (not title) or (not ttl) then return end
	db.char[title] = ttl
	db.realm.questLog[playerName][title] = ttl
end

do
	local tooltip, populateTooltip, Tooltip_OnClick_Sort, sortByFunction
	local classWeight = { ["d"] = 1, ["l"] = 2, ["p"] = 3, ["w"] = 4 }
	local sortByFuncs = {
		class = function(a,b)
			local typeA = db.global.questCache[a]	--Get Type
			local typeB = db.global.questCache[b]
			if typeA and typeB then	--If both Type
				local weightA = classWeight[typeA]	--Get Weight Class
				local weightB = classWeight[typeB]
				if weightA == weightB then	--if same Weight class then return Alphabetical - likely same TTL
					return a < b
				else		--else return one better than other
					return weightA < weightB
				end
			elseif (typeA) and (not typeB) then	--if A has class but B dosn't then A is first
				return true
			elseif (not typeA) and (typeB) then --else B is first if A is classless
				return false
			end
		end,
		element = function(a,b)
			return a < b
		end,
		ttl = function(a,b)
			local ttlA = db.char[a]
			local ttlB = db.char[b]
			if ttlA == ttlB then
				return a < b
			else
				return ttlA < ttlB
			end
		end,
	}

	local prefix = QUEST_LOG_DAILY_TOOLTIP:match( "\n(.+)" )
	function Tooltip_OnClick_Sort(self, sortBy, button)
		--module:Debug("TT_OnClick_Sort", self, sortBy, button)
		tooltip:Clear()
		sortByFunction = sortByFuncs[sortBy] or sortByFuncs["element"]
		populateTooltip(tooltip)		
	end
	local tmpSort = {}
	function populateTooltip(tooltip)
		tooltip:AddLine()
		tooltip:SetCell(1,1, AddonName, GameTooltipText, "LEFT", 3)
		tooltip:AddLine()
		tooltip:SetCell(2, 1, prefix:format( SecondsToTime(GetQuestResetTime()) ), GameTooltipText, "LEFT", 2)
		tooltip:SetCell(2, 3, QUEST_LOG_DAILY_COUNT_TEMPLATE:format(GetDailyQuestsCompleted()) , GameTooltipText, "RIGHT")
		----Element Listing Header
--		tooltip:SetColumnLayout(3, "RIGHT", "LEFT", "CENTER")
		tooltip:AddLine()
		tooltip:SetCell(3, 1, "", GameTooltipText, "RIGHT", nil, nil, nil, nil, 8, 0)
		tooltip:SetCellScript(3, 1, "OnMouseDown", Tooltip_OnClick_Sort, "class")
		tooltip:SetCell(3, 2, L["Quest"], GameTooltipText, "LEFT")
		tooltip:SetCellScript(3, 2, "OnMouseDown", Tooltip_OnClick_Sort, "element")
		tooltip:SetCell(3, 3, L["Expires"], GameTooltipText, "CENTER")
		tooltip:SetCellScript(3, 3, "OnMouseDown", Tooltip_OnClick_Sort, "ttl")
		----Elements of Listing

		for i=1, #tmpSort do tmpSort[i] = nil end
		for k,v in pairs(db.char) do
			tinsert(tmpSort, k)
		end
		table.sort(tmpSort, sortByFunction)
		for i = 1, #tmpSort do
			tooltip:AddLine("|TInterface\\Icons\\INV_Misc_Coin_01:0|t", tmpSort[i], date("%c", db.char[ tmpSort[i] ] ) )
		end

		tooltip:AddLine()
		local lastY, lastX = tooltip:AddLine()
		tooltip:SetCell(lastY, lastX, L["Click: Left for Quest Log"], GameTooltipText, "LEFT", 2)
		tooltip:SetCell(lastY, lastX+2, L["Right for SOCD Options"], GameTooltipText, "RIGHT" )	
	end
	
	local function OnEnter(self, ...)
		--module:Debug("OnEnter", self, ...)
		if tooltip and tooltip:IsShown() then return end
		tooltip = LibQTip:Acquire("SOCD_LDB_PlayerTrack", 3, "RIGHT", "LEFT", "CENTER")
		tooltip:SmartAnchorTo(self)
		tooltip:SetAutoHideDelay(0.25, self)
		
		populateTooltip(tooltip)
		
		tooltip:Show()
	end
	local function OnLeave(self, ...)
		--module:Debug("OnLeave", self, ...)
		-- Release the tooltip
		--LibQTip:Release(self.tooltip)
		--self.tooltip = nil
	end
	local function OnClick(self, button, ...)
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

function module:PruneDB(FoceClean)
	--self:Debug("Pruning non-existant DB")
	if FoceClean then
		--self:Debug("FORCE CLEAN, CLEARING DB")
		for k,v in pairs(db.char) do
			db.char[k] = nil
		end
		for char, questlog in pairs(db.realm.questLog) do
			for quest, ttl in pairs(questlog) do
				questlog[quest] = nil
			end
		end
		return --self:Debug("FORCE CLEAN COMPLETED")
	end
	--self:Debug("Clearing Char DB")
	for quest, ttl in pairs(db.char) do
		--self:Debug("Quest:", quest, "~TTL: ", date("%c", ttl) )
		if time() > ttl then
			--self:Debug("Quest Expired")
			db.char[quest] = nil
		end
	end
	--self:Debug("Clearing Realm Quest Log")
	for char, questLog in pairs(db.realm.questLog) do
		--self:Debug("Clearing Char:", char)
		for quest, ttl in pairs(questLog) do
			--self:Debug("Quest:", quest, "~TTL: ", date("%c", ttl) )
			if time() > ttl then
				--self:Debug("Quest Expired")
				questLog[quest] = nil
			end
		end
		if not next(questLog) then	--prune out the empty table to prevet the alt tracker from doing weird things..
			db.realm.questLog[char] = nil
		end
	end
end