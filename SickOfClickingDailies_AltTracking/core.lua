--[[
	Sick Of Clicking Dailies? - Alt Daily Quest Tracking
	purpose: to provide a LDB feed / Tooltip showing a summary of toon and what quests are completed for that toon
		currently it's all displayed in one tooltip, however it's know fact that if you do your dailies on more than 3
		chars that your going to fill your tooltip up.. 

		final goal here is to provide the lists of quests & what toons have not completed that quest.
	
	Written By: OrionShock
]]--

local AddoName, AddonParent = ..., LibStub("AceAddon-3.0"):GetAddon("SickOfClickingDailies")
local module = AddonParent:NewModule("AltTrack", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("SOCD_AltTracking")
local LibQTip
local unsortedPlayers, sortedPlayerList, sortedQuestList, totalQuests = {}, {}, {}, {}
local classColorTable = RAID_CLASS_COLORS
local specialQuests = setmetatable({}, { _index = AddonParent.IsWeeklyQuest } )
local db

--@debug@
function module:Debug(...)
	local str = string.join(", ", tostringall(...) )
	str = str:gsub("([:=>]),", "%1")
	str = str:gsub(", ([%-])", " %1")
	DEFAULT_CHAT_FRAME:AddMessage("SOCD-ALT: "..str)
	return str
end
--@end-debug@

function module:OnEnable()
	LibQTip = LibStub('LibQTip-1.0', true)
	classColorTable = CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS
	db = AddonParent.db.realm
	self:CreateLDB()
	--self:Debug("OnEnable")
end


function module:SOCD_DAILIY_QUEST_COMPLETE(event, quest, opt, id)
	self:UpdateSortedLists()
end

local tooltipIsSortedNow, LibQTipTooltip = nil


local qsort
local function uglySortByPlayer(questA,questB)
	if qsort[questA] and qsort[questB] then
		if specialQuests[questA] and specialQuests[questB] then
			return questA < questB
		elseif specialQuests[questA] and not specialQuests[questB] then
			return false
		elseif not specialQuests[questA] and specialQuests[questB] then
			return true
		else
			return questA < questB
		end
	elseif qsort[questA] and (not qsort[questB]) then
		return true
	elseif (not qsort[questA]) and qsort[questB] then
		return false
	else
		if specialQuests[questA] and specialQuests[questB] then
			return questA < questB
		elseif specialQuests[questA] and not specialQuests[questB] then
			return false
		elseif not specialQuests[questA] and specialQuests[questB] then
			return true
		else
			return questA < questB
		end
	end
end

local function default_Sort(a,b)
	if specialQuests[a] and specialQuests[b] then
		return a < b
	elseif specialQuests[a] and not specialQuests[b] then
		return false
	elseif not specialQuests[a] and specialQuests[b] then
		return true
	else
		return a < b
	end
end

function module:UpdateAllQuests()
	wipe(totalQuests)
	for toon, questLog in pairs(db.questLog) do
		unsortedPlayers[toon] = true
		if type(questLog) == "table" then
			for quest, ttl in pairs(questLog) do
				totalQuests[quest] = true
			end
		else
			local _, srcAddon = issecurevariable(db, toon)
			geterrorhander()("Invalid Table in questLog, came from addon: "..tostring(srcAddon) )
		end
	end
	wipe(sortedQuestList)
	for k in pairs(totalQuests) do
		tinsert(sortedQuestList, k)
	end

	if tooltipIsSortedNow then
		qsort = db.questLog[tooltipIsSortedNow]
		table.sort(sortedQuestList, uglySortByPlayer)
		qsort = nil
	else
		table.sort(sortedQuestList, default_Sort)
	end
	--
	wipe(sortedPlayerList)
	for k in pairs(unsortedPlayers) do
		tinsert(sortedPlayerList, k)
	end
	table.sort(sortedPlayerList)

end

local function TipOnClick(cell, arg, button)
	local self = module
	if unsortedPlayers[arg] then
		tooltipIsSortedNow = arg
		qsort = db.questLog[arg]
		table.sort(sortedQuestList, uglySortByPlayer)
		qsort = nil
		LibQTipTooltip:Clear()
		module:populateTooltip(LibQTipTooltip, tooltipIsSortedNow)
	else
		tooltipIsSortedNow = nil
		table.sort(sortedQuestList)
		LibQTipTooltip:Clear()
		module:populateTooltip(LibQTipTooltip, tooltipIsSortedNow)
	end
end

   
function module:populateTooltip(tip)
	self:UpdateAllQuests()
	tip:SetCellMarginV(2)
	tip:SetCellMarginH(2)
	tip:SetColumnLayout(#sortedPlayerList + 1)
	tip:AddHeader(L["Dailies for all Characters"])
	local yOffset, xOffset = tip:AddLine()
	tip:SetCell(yOffset, xOffset, " ")
	tip:SetCellScript(yOffset, xOffset, "OnMouseDown", TipOnClick, "default view" )
	for i = 1, #sortedPlayerList do
		--print("Add", sortedPlayerList[i], "row", yOffset, "col", xOffset+i )
		local class = db.chars[ sortedPlayerList[i] ]
		local ct = classColorTable[class]
		if ct then
			tip:SetCell( yOffset, xOffset+i, string.format("|cff%.2x%.2x%.2x%s|r", ct.r*255, ct.g*255, ct.b*255, sortedPlayerList[i] ) )
		else
			tip:SetCell( yOffset, xOffset+i, sortedPlayerList[i]  )
		end
		tip:SetCellScript(yOffset, xOffset+i, "OnMouseDown", TipOnClick, sortedPlayerList[i] )
	end
	for i = 1, #sortedQuestList do
		tip:AddLine()
		--print("Add:", sortedQuestList[i], "row", yOffset+i, "col", 1)
		if specialQuests[ sortedQuestList[i] ] then
			tip:SetCell(yOffset+i, 1, sortedQuestList[i], "RIGHT")
			tip:SetCellColor(yOffset+i, 1, .73, .55, .96, 1)
		else
			tip:SetCell(yOffset+i, 1, sortedQuestList[i], "RIGHT")
		end
	end
	
	for x, player in pairs(sortedPlayerList) do
		for y, quest in pairs(sortedQuestList) do
			if db.questLog[player] and db.questLog[player][quest] then
				--print("Set", quest, player, "row", y+yOffset, "col", x+xOffset)
				tip:SetCell( y+yOffset, x+xOffset, " ", "CENTER")
				tip:SetCellColor( y+yOffset, x+xOffset, 0, 1, 0)
				if player == tooltipIsSortedNow then
					tip:SetLineColor(y+yOffset, 0,0,1,1)
				end
			end
		end
	end
end



local function OnEnter(self)
	if LibQTipTooltip and LibQTipTooltip:IsShown() then
		return
	end
	local tooltip = LibQTip and LibQTip:Acquire("SOCD_ALT", #sortedPlayerList+1)
	if not tooltip then return end
	LibQTipTooltip = tooltip
	module:populateTooltip(tooltip)
	tooltip:SmartAnchorTo(self)
	tooltip:Show()
end

local delay, interval = 0, .5
local mouseovertimer = CreateFrame("Frame")
mouseovertimer:SetScript("OnUpdate", function(self, elapsed)
	if LibQTipTooltip and self.ldbObj then
		if MouseIsOver(LibQTipTooltip) or MouseIsOver(self.ldbObj) then
			delay = 0
		else
			delay = delay + elapsed
		end
		if delay > interval then
			LibQTip:Release(LibQTipTooltip)
			LibQTipTooltip = nil
			self.ldbObj = nil
			delay = 0
			self:Hide()
		end
	end
end)

local function OnLeave(self)
	if LibQTipTooltip then
		mouseovertimer.ldbObj = self
		mouseovertimer:Show()
	end
end


function module:CreateLDB()
	local trackLDB = {
		type = "data source",
		icon = "Interface\\Icons\\Achievement_Win_Wintergrasp",
		text = L["Dailies On Alts"],
		OnEnter = OnEnter,
		OnLeave = OnLeave,
	}
	self.ldb = LibStub("LibDataBroker-1.1"):NewDataObject("SOCD-AltTrack", trackLDB)
end



