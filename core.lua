--[[
Major 6,  MinorSVN:  $Revision$

Sick Of Clicking Dailys is a simple addon designed to pick up and turn in Dailiy Quests for WoW.

This version comes with a built in config system made with Ace3's Config GUI Libs.

=====================================================================================================
 Copyright (c) 2007 by Orionshock

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.
The rights to the Software's "Name", official version of the Software
as well as the right to host and distribute the official version
are reserved by the copyright holder.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.


All other files are licenced under their respective terms.

=====================================================================================================
]]--

--
--	Debug Func()
--
local function D(...)
	local str
	local arg = select(1, ...) or ""
	if string.find(arg, "%%") then
		str = (select(1, ...)):format(select(2,...))
	else
		str = string.join(", ", tostringall(...) )
		str = str:gsub(":,", ":")
	end
	print("SOCD: "..str)
	return str
end



--
--	Addon Decleration & File Wide locals
--
local L = LibStub("AceLocale-3.0"):GetLocale("SOCD_Core")

SickOfClickingDailies = LibStub("AceAddon-3.0"):NewAddon("SickOfClickingDailies", "AceEvent-3.0", "AceConsole-3.0")
local addon = SickOfClickingDailies
addon.version = tostring("$Revision$")
addon.author = "Orionshock"
local moduleQLookup, moduleQOptions, questNPCs, moduleGossipOptions = {}, {}, {}, {}
addon.moduleQLookup = moduleQLookup
addon.moduleQOptions = moduleQOptions
addon.questNPCs = questNPCs
addon.moduleGossipOptions = moduleGossipOptions

--
--	Quest Name lookup func's
--

local function qTable(k)
	for _, questTable in pairs(moduleQLookup) do
		if questTable[k] then
			return questTable[k]
		end
	end
end

local function qOptions(k)
	for _,oTable in pairs(moduleQOptions) do
		if oTable[k] then
			return oTable[k]
		end
	end
end

local function gossipOption(opt)
	for _, gTable in pairs(moduleGossipOptions) do
		if gTable[opt] then
			return gTable[opt]
		end
	end
end

function addon:RegisterQuests(name, questTable, npcID, options, gossip)
	--Quest Groupings
	assert(type(questTable) == "table")
	moduleQLookup[name] = questTable
	--Quest NPC ID's
	assert(type(npcID) == "string")
	questNPCs[name] = npcID
	--Quest Options
	assert(type(options) == "table")
	moduleQOptions[name] = options
	--D("Quest Grouping %s registered", name)
	if gossip then
		assert(type(gossip) == "table")
		moduleGossipOptions[name] = gossip
		--D("Gossip Options for %s registered", name)
	end
end

function addon:UnRegisterQuests(name)
	if moduleQLookup[name] then
		moduleQLookup[name] = nil
		moduleQOptions[name] = nil
		--D("Quest Grouping %s unregistered", name)
	end
end

--
--	Options Table Defualts
--

local defaults = {
	profile = {
		questLoop = true,
		modules = {},
	},
}

--
--	Options Table & Module Methods for getting options tables
--

local function GetModuleOptions(name, order)
	return { name = name, type = "toggle", get = "GetModuleState", set = "ToggleModule", order = order}
end

local function GetOptionsTable()
	local options = {
		name = L["Sick Of Clicking Dailies"],
		type = "group",
		handler = addon,
		childGroups = "tab",
		args = {
			questLoop = { type = "toggle", name = L["Enable Quest Looping"], desc = L["questLoop_Desc"], get = "QuestLoop", set = "QuestLoop" },
			moduleControl = {
				name = L["Module Control"],
				type = "group", order = -1,
				args = {
				},
			},
		},
	}
	local i = 1
	for name, module in addon:IterateModules() do
		options.args[name] = (type(module.GetOptionsTable) == 'function' and module:GetOptionsTable()) or nil
		options.args.moduleControl.args[name] = GetModuleOptions(name, i)
		i = i + 1
	end
	return options
end

function addon:GetModuleState(info)
	return self.db.profile.modules[info.option.name]
end
function addon:ToggleModule(info, value)
	local option = info.option.name
	if value then
		self:EnableModule(option)
		self.db.profile.modules[option] = true
	else
		self:DisableModule(option)
		self.db.profile.modules[option] = false
	end
end

function addon:QuestLoop(info, value)
	if value == nil then
		--Get
		return self.db.profile.questLoop
	else
		--Set
		self.db.profile.questLoop = value
	end
end


--
--	Main Addon Functions
--

function addon:OnInitialize()
	for name, _ in self:IterateModules() do
		defaults.profile.modules[name] = true
	end

	addon.db = LibStub("AceDB-3.0"):New("SOCD_SIX", defaults)
	LibStub("AceConfig-3.0"):RegisterOptionsTable("SickOfClickingDailies", GetOptionsTable)
	self:RegisterChatCommand("socd", function() LibStub("AceConfigDialog-3.0"):Open("SickOfClickingDailies") end )

	for name, module in self:IterateModules() do
		module:SetEnabledState(self.db.profile.modules[name])

	end
end

function addon:OnEnable()
	self:RegisterEvent("GOSSIP_SHOW")
	self:RegisterEvent("QUEST_DETAIL")
	self:RegisterEvent("QUEST_PROGRESS")
	self:RegisterEvent("QUEST_COMPLETE")
	self:RegisterEvent("PLAYER_TARGET_CHANGED")
end

function addon:OnDisable()
	--self:UnregisterAllEvents()
end

--
--	Quest Handlers
--

local npcBad, nextQuestFlag, questIndex = nil, false, 0

local stopFlag, s_title, s_npc = false	--Event Dispatching stuff..

function addon:GOSSIP_SHOW(event)
	---D(event)
	local npc = addon.CheckNPC()
	local stopFlag, s_title, s_npc = false, nil, nil
	if (IsShiftKeyDown())then return end
	if (not self.db.profile.questLoop) and npcBad then
		--Do nothing... go to gossip options?
	else
		local sel, quest, status = addon.OpeningCheckQuest(npc)
		if npc and quest then
			if status == "Available" then
				return SelectGossipAvailableQuest(sel)
			elseif status == "Active" then
				return SelectGossipActiveQuest(sel)
			end
		end
	end
	--D(event, "Gossip Time? do we got NPC?", npc)
	--Thinking about Dialouge Options too... like the Intestinal Fortitude and Alchy's Thing..
	local hasGossip, index = self:AnalyzeGossipOptions( GetGossipOptions() )
	if hasGossip and npc then
		--D("We have a Gossiper~", hasGossip, index)
		SelectGossipOption(index)
	end
end

function addon:QUEST_DETAIL(event)
	--D(event)
	if IsShiftKeyDown() then return end
	local npc = addon.CheckNPC()
	local quest = addon.TitleCheck(npc)
	if npc and quest then
		AcceptQuest()
		return 
	end
end


function addon:QUEST_PROGRESS(event)
   	if IsShiftKeyDown() then return end
	local npc = addon.CheckNPC()
	local quest = addon.TitleCheck(npc)
	if npc and quest then
		if not IsQuestCompletable() then
			nextQuestFlag = true
			--if self.db.profile.questLoop then
				DeclineQuest()
				return 
			--end
			--return
		else
			nextQuestFlag = false
		end
		return CompleteQuest() --HERE
    end
end

do
	function addon:QUEST_COMPLETE(event)
		stopFlag = false
		nextQuestFlag = false
		if IsShiftKeyDown() then return end
		local npc = addon.CheckNPC()
		local quest = addon.TitleCheck(npc)
		if npc and quest then
			local opt = qOptions(quest)
			if (opt and (opt == 5)) then
				stopFlag = true
				s_title, s_npc = quest, npc
				return
			elseif opt and (opt >= 1 and opt <= 4 ) then
				stopFlag = false
				GetQuestReward( opt )
				self:SendMessage("SOCD_DAILIY_QUEST_COMPLETE", quest, npc, opt)
				return
			end
			GetQuestReward(0)
			self:SendMessage("SOCD_DAILIY_QUEST_COMPLETE", quest, npc)
			return
	    end
	end
	hooksecurefunc("GetQuestReward", function(opt)
		if stopFlag then
			addon:SendMessage("SOCD_DAILIY_QUEST_COMPLETE", s_title, s_npc, opt)
			stopFlag = false
		end
	end)

end

function addon:PLAYER_TARGET_CHANGED(event)
	npcBad, nextQuestFlag, questIndex = false, false, 0
end

function addon.CheckNPC()
	local npcID = UnitGUID("target") and tonumber( strsub( UnitGUID("target"), -12, -7), 16)
--	if npcID then
--		D("CheckNPC: type = GUID")
--	end
	if not npcID then
		npcID = (GossipFrameNpcNameText:GetParent():IsVisible() and GossipFrameNpcNameText:GetText()) or (QuestFrameNpcNameText:GetParent():IsVisible() and QuestFrameNpcNameText:GetText())
		--D("CheckNPC: type =", ( GossipFrameNpcNameText:GetText() and "Gossip Frame") or ( QuestFrameNpcNameText:GetText() and "QuestFrame" ) )
	end
	if not npcID then return end
	for i,v in pairs(questNPCs) do
		if v:find(npcID) then
			--D("CheckNPC - found", npcID)
			return npcID
		else
			nextQuestFlag, questIndex = false, 0
		end
	end
end

local function QuestItteratePickUp(npc, ...)
	if (...) == nil then return end
	for i=1, select("#", ...), 3 do
		if qTable(select(i, ...)) then
			return (i+2)/3 , select(i, ...)
		end
	end
end

local function QuestItterateTurnIn(npc, ...)
	if (...) == nil then return end
	local numArgs = select("#", ...)
	if nextQuestFlag then
		nextQuestFlag = false
		questIndex = questIndex + 1
		if questIndex > (numArgs /3) then
			npcBad = true
			questIndex = 1
			for i=1, numArgs , 3 do
				if qTable(select(i, ...)) then
					questIndex = (i+2)/3
					return (i+2)/3 , (select(i, ...))
				end
			end
		else
			for i = ((questIndex*3)-2) , numArgs  do
				if qTable(select(i, ...)) then
					questIndex = (i+2)/3
					--D("Quest Found:", (select(i, ...)) )
					return (i+2)/3 , (select(i, ...))
				end
			end
		end
	end
	if questIndex >= (numArgs/3)  then npcBad = true end
	for i=1, numArgs , 3 do
		if qTable(select(i, ...)) then
			questIndex = (i+2)/3
			--D("Quest Found:", (select(i, ...)) )
			return (i+2)/3 , select(i, ...)
		end
	end
end

function addon.OpeningCheckQuest(npc)
	if npc == nil then return end
	local selection, quest = QuestItteratePickUp(npc, GetGossipAvailableQuests())
	if quest then
			return selection, quest, "Available"
	else
		selection, quest = QuestItterateTurnIn(npc, GetGossipActiveQuests())
		if quest then
			return selection, quest, "Active"
		end
	end
end

function addon.TitleCheck(npc)
	if not npc then return end
	if qTable(GetTitleText()) then
		--D("Title Check", GetTitleText())
		return GetTitleText()
	end
end


function addon:AnalyzeGossipOptions(...)
	D("AnalyzeGossipOptions", ...)
	local numArgs, count = select("#", ...), 0
	D("AnalyzeGossipOptions, DIVE")
	for i = 1, numArgs, 2 do
		local element = select(i+1, ...) == "gossip" and select(i, ...)
		count = count + 1
		D("Found element:", element, count)
		if gossipOption(element) then
			D("Is one of ours")
			return element, count
		end
	end
	return false
end

