--[[
	Alt Daily Quest Tracking
	purpose: to provide a LDB feed / Tooltip showing a summary of toon and what quests are completed for that toon
		currently it's all displayed in one tooltip, however it's know fact that if you do your dailies on more than 3
		chars that your going to fill your tooltip up.. 

		final goal here is to provide the lists of quests & what toons have not completed that quest.
]]--


local AddonParent = LibStub("AceAddon-3.0"):GetAddon("SickOfClickingDailies")
local LDBModule = AddonParent:GetModule("LDB")
local module = AddonParent:NewModule("Alt Tracking", "AceEvent-3.0")
module.noModuleControl = true
L = LibStub("AceLocale-3.0"):GetLocale("SOCD_AltTracking")

local playerName, completedQuests, db

function D(...)
	local str = string.join(", ", tostringall(...) )
	str = str:gsub("([=:]), ", "%1")

	if AddonParent.db and AddonParent.db.global.debug then
		print("|cff99ff66SOCD-AT:|r "..str)
	end
	return str
end

function module:OnInitialize()
	completedQuests = AddonParent.db.char.completedQuests
	self.db = AddonParent.db:RegisterNamespace("AltTracking", { realm = { chars = {} } } )
	db = self.db.realm
	playerName = UnitName("player")

	db[playerName] = db[playerName] or {}
	db.chars[playerName] = UnitFactionGroup("player")
	self.sortedPlayerList = {}
	self.unsortedPlayers = {}
	self.sortedQuestList = {}
	self.totalQuests = {}

	D("OnInitialize")
end

function module:OnEnable()
	self:CreateLDB()
	self:PruneHistory()
	D("OnEnable")
end

local old_LDB_DailieEvent = LDBModule.SOCD_DAILIY_QUEST_COMPLETE

function LDBModule:SOCD_DAILIY_QUEST_COMPLETE(event, quest, opt, id)
	old_LDB_DailieEvent(LDBModule, event, quest, opt, id)
	D("Tracking Hook",quest, "expires in",  date("%c", completedQuests[quest]))
	local ttd = completedQuests[quest] or completedQuests[quest.." ~ "..date()]
	local t = db[playerName] or {}
	t[quest] = ttd
	db[playerName] = t
	module.totalQuests[quest] = true
end

do
	local t = {}
	function module:SortQuestCompleTable(completedQuests)
		wipe(t)
		for k, v in pairs(completedQuests) do
			tinsert(t , k)
		end
		table.sort(t)
		return t
	end
end

local function OnTooltipShow(self)
	self:AddLine(L["Quests for All Toons"])
	self:AddLine(" ")
	for _, charName in ipairs(module.sortedPlayerList) do
		if db[charName] and next(db[charName]) then
			self:AddLine(charName.." - "..db.chars[charName])
			local sortedTable = module:SortQuestCompleTable( db[ charName ] )
			for _, quest in ipairs(sortedTable) do
				self:AddDoubleLine( "    "..quest, date("%c", db[charName][quest]) )
			end
			self:AddLine(" ")
		end
	end
end

	--Copied from LibQTip
local function GetTipAnchor(frame)
	local x,y = frame:GetCenter()
	if not x or not y then return "TOPLEFT", "BOTTOMLEFT" end
	local hhalf = (x > UIParent:GetWidth() * 2/3) and "RIGHT" or (x < UIParent:GetWidth() / 3) and "LEFT" or ""
	local vhalf = (y > UIParent:GetHeight() / 2) and "TOP" or "BOTTOM"
	return vhalf..hhalf, frame, (vhalf == "TOP" and "BOTTOM" or "TOP")..hhalf
end
	--[[	E	]]--


local LibQTip = LibStub('LibQTip-1.0', true)
local function OnEnter(self)
	LibQTip = LibStub('LibQTip-1.0', true)
	if LibQTip then
		local tooltip = LibQTip:Acquire("SOCD_ALT", #module.sortedPlayerList+1)
		self.tooltip = tooltip
		module:populateTooltip(tooltip)
		tooltip:SmartAnchorTo(self)
		tooltip:Show()
	else
		GameTooltip:ClearAllPoints()
		GameTooltip:SetOwner(self, "ANCHOR_NONE")
		GameTooltip:SetPoint( GetTipAnchor(self) )
		GameTooltip:ClearLines()
		OnTooltipShow(GameTooltip)
		GameTooltip:Show()
	end
--	print("sorted player list #", #module.sortedPlayerList)

end

local function OnLeave(self)
	if self.tooltip then
		LibQTip:Release(self.tooltip)
		self.tooltip = nil
	else
		GameTooltip:Hide()
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
	self.ldb = LibStub("LibDataBroker-1.1"):NewDataObject("SOCD - Alts Tracking", trackLDB)
end




--
function module:PruneHistory()
	D("AltTracking - Pruning History")
	for toon, qTable in pairs(db) do
		if toon ~= "chars" then
			D("Pruning toon", toon)
			for quest, ttl in pairs(qTable) do
				if time() > ttl then
					D("Pruning", quest, "Exired on:", date("%c", ttl), "current Time:", date() )
					qTable[quest] = nil
				end
			end
		end
	end
	wipe(self.sortedPlayerList)
	for toon, qTable in pairs(db) do
		if not next(qTable) then
			D("removing", toon," from db, no quests")
			db[toon] = nil
		else
			if toon ~= "chars" then
				tinsert(self.sortedPlayerList, toon)
			end
		end
	end
	table.sort(self.sortedPlayerList)
end


--LQT stuff
--	self.sortedPlayerList	self.totalQuests self.sortedQuestList
function module:UpdateAllQuests()
	for toon, qTable in pairs(db) do
		if toon ~= "chars" then
			for quest, _ in pairs(qTable) do
				self.totalQuests[quest] = true
				self.unsortedPlayers[toon] = true
			end
		end
	end
	wipe(self.sortedQuestList)
	for k in pairs(self.totalQuests) do
		tinsert(self.sortedQuestList, k)
	end
	table.sort(self.sortedQuestList)
	--
	wipe(self.sortedPlayerList)
	for k in pairs(self.unsortedPlayers) do
		tinsert(self.sortedPlayerList, k)
	end
	table.sort(self.sortedPlayerList)

end
   
function module:populateTooltip(tip)
	self:UpdateAllQuests()
	tip:SetColumnLayout(#self.sortedPlayerList + 1)
	tip:AddHeader(L["Quests for All Toons"])
--	tip:AddLine()
	local yOffset, xOffset = 2,1
	local rCount = 1
	tip:AddLine()
	for i = 1, #self.sortedPlayerList do
--		print("Add", self.sortedPlayerList[i], "row", yOffset, "col", xOffset+i )
		tip:SetCell( yOffset, xOffset+i, self.sortedPlayerList[i] )
	end
	for i = 1, #self.sortedQuestList do
		tip:AddLine()
--		print("Add:", self.sortedQuestList[i], "row", yOffset+i, "col", 1)
		tip:SetCell(yOffset+i, 1, self.sortedQuestList[i], "RIGHT")
	end
	
	local xOffset, yOffset = 1,1
	for x, player in pairs(self.sortedPlayerList) do
		for y, quest in pairs(self.sortedQuestList) do
			if db[player] and db[player][quest] then
--				print("Set", quest, player, "row", y+yOffset, "col", x+xOffset)
				tip:SetCell(1+y+yOffset, x+xOffset, "XX", "CENTER")
			end
		end
	end
end





