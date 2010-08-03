--[[
	Alt Daily Quest Tracking
	purpose: to provide a LDB feed / Tooltip showing a summary of toon and what quests are completed for that toon
		currently it's all displayed in one tooltip, however it's know fact that if you do your dailies on more than 3
		chars that your going to fill your tooltip up.. 

		final goal here is to provide the lists of quests & what toons have not completed that quest.
]]--

local AddoName, AddonParent = ...
local module = AddonParent:NewModule("AltTrack", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale(AddoName)
local LibQTip
local unsortedPlayers, sortedPlayerList, sortedQuestList, totalQuests = {}, {}, {}, {}


function module:OnInitialize()
	LibQTip = LibStub('LibQTip-1.0', true)

	db = AddonParent.db.factionrealm
	self:Debug("OnInitialize")
end

function module:OnEnable()
	LibQTip = LibStub('LibQTip-1.0', true)

	self:CreateLDB()
	self:Debug("OnEnable")
end


function module:SOCD_DAILIY_QUEST_COMPLETE(event, quest, opt, id)
	self:UpdateSortedLists()
end

local tooltipIsSortedNow, LibQTipTooltip = nil


local qsort
local function uglySortByPlayer(questA,questB)
	if qsort[questA] and qsort[questB] then
		return questA < questB
	end
	if qsort[questA] and (not qsort[questB]) then
		return true
	end
	if (not qsort[questA]) and qsort[questB] then
		return false
	end
	if (not qsort[questA]) and (not qsort[questB]) then
		return questA < questB
	end
end

function module:UpdateAllQuests()
	for toon, qTable in pairs(db) do
		if toon ~= "chars" then
			for quest, _ in pairs(qTable) do
				totalQuests[quest] = true
				unsortedPlayers[toon] = true
			end
		end
	end
	wipe(sortedQuestList)
	for k in pairs(totalQuests) do
		tinsert(sortedQuestList, k)
	end

	if tooltipIsSortedNow then
		qsort = db[tooltipIsSortedNow]
		table.sort(sortedQuestList, uglySortByPlayer)
		qsort = nil
	else
		table.sort(sortedQuestList)
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
		qsort = db[arg]
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
	tip:SetColumnLayout(#sortedPlayerList + 1)
	tip:AddHeader(L["Dailies for all Characters"])
	local yOffset, xOffset = tip:AddLine()
	tip:SetCell(yOffset, xOffset, " ")
	tip:SetCellScript(yOffset, xOffset, "OnMouseDown", TipOnClick, "default view" )

	for i = 1, #sortedPlayerList do
		--print("Add", sortedPlayerList[i], "row", yOffset, "col", xOffset+i )
		tip:SetCell( yOffset, xOffset+i, sortedPlayerList[i] )
		tip:SetCellScript(yOffset, xOffset+i, "OnMouseDown", TipOnClick, sortedPlayerList[i] )
	end
	for i = 1, #sortedQuestList do
		tip:AddLine()
		--print("Add:", sortedQuestList[i], "row", yOffset+i, "col", 1)
		tip:SetCell(yOffset+i, 1, sortedQuestList[i], "RIGHT")
	end
	
	for x, player in pairs(sortedPlayerList) do
		for y, quest in pairs(sortedQuestList) do
			if db[player] and db[player][quest] then
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
	local tooltip = LibQTip:Acquire("SOCD_ALT", #sortedPlayerList+1)
	LibQTipTooltip = tooltip
	module:populateTooltip(tooltip)
	tooltip:SmartAnchorTo(self)
	tooltip:Show()
end

local delay, interval = 0,1
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
--		OnTooltipShow = OnTooltipShow,
	}
	self.ldb = LibStub("LibDataBroker-1.1"):NewDataObject("SOCD-AltTrack", trackLDB)
end



