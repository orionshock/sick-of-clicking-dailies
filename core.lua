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

local L = LibStub("AceLocale-3.0"):GetLocale("SOCD_Core")

SickOfClickingDailies = LibStub("AceAddon-3.0"):NewAddon("SickOfClickingDailies", "AceEvent-3.0", "AceConsole-3.0")
local addon = SickOfClickingDailies

--
--	Debug Func()
--
local debug = function() end
--@debug@
function D(...)
	if not addon.db.profile.debug then return end
	local str
	local arg = select(1, ...) or ""
	if string.find(arg, "%%") then
		str = (select(1, ...)):format(select(2,...))
	else
		str = string.join(", ", tostringall(...) )
		str = str:gsub(":,", ":")
	end
	print("|cff9933FFSOCD:|r "..str)
	return str
end
--@end-debug@


--
--	Addon Decleration & File Wide locals
--

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
		debug = false,
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
					--@debug@
					debug = { type = "toggle", name = "Enable Debug", get = function() return addon.db.profile.debug end, set = function(_, val) addon.db.profile.debug = val end },
					--@end-debug@
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

local npcBad, nextQuestFlag, questIndex, gossipPop = nil, false, 1, false

local stopFlag, s_title, s_npc = false	--Event Dispatching stuff..

function addon:GOSSIP_SHOW(event)
	D(event)
	local stopFlag, s_title, s_npc = false, nil, nil
	local npc = self:CheckNPC(event)
	if not npc then return end
	if (IsShiftKeyDown())then return end
	local sel, quest, status = self.OpeningCheckQuest(npc)
	D(event, "logic batterie")
	if sel then
		D("we have quest selection", sel, quest, status, "BadNPC?", npcBad)
		if npcBad then
			D("badNPC, gossipDive")
			self:DoGossipOptions( (event.."~quest~"..(sel or "")) )
			if not self.db.profile.questLoop then
				D("No QuestLooping, exit Func")
				return
			end
		else
			D("not BadNpc, interacting with NPC", status, sel, quest)
			if status == "Available" then
				return SelectGossipAvailableQuest(sel)
			elseif status == "Active" then
				return SelectGossipActiveQuest(sel)
			end
		end
	elseif not sel then
		D(event, "No quests?? just gossip")
		self:DoGossipOptions(event.."~notSel")
	end
end

function addon:DoGossipOptions(traceEvent)
	traceEvent = "GosOpt~"..(traceEvent or "")
	D(traceEvent)
	local hasGossip, index = self:AnalyzeGossipOptions( GetGossipOptions() )
	D(traceEvent, hasGossip, index)
	if hasGossip then
		D(traceEvent, hasGossip, index)
		npcBad =  false
		D(traceEvent, "selectingOpt", index)
		SelectGossipOption(index)
	end
end

function addon:QUEST_DETAIL(event)
	--D(event)
	if IsShiftKeyDown() then return end
	local npc = self:CheckNPC(event)
	local quest = addon.TitleCheck(npc)
	if npc and quest then
		AcceptQuest()
		return 
	end
end


function addon:QUEST_PROGRESS(event)
	D(event)
   	if IsShiftKeyDown() then return end
	local npc = self:CheckNPC(event)
	D(event, "NPC:", npc)
	local quest = addon.TitleCheck(npc)
	D(event, "Q:", quest)
	if npc and quest then
		if not IsQuestCompletable() then
			D("QuestNotCompleteable, set flag and DeclineQuest()")
			nextQuestFlag = true
			--if self.db.profile.questLoop then
				DeclineQuest()
				return 
			--end
			--return
		else
			D(event, "set nextQuestFlag to false")
			nextQuestFlag = false
		end
		return CompleteQuest() --HERE
    end
end

do
	function addon:QUEST_COMPLETE(event)
		stopFlag = false
		D(event, "nextQuestFlag to false")
		nextQuestFlag = false
		if IsShiftKeyDown() then return end
		local npc = self:CheckNPC(event)
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
	D(event, "Set nextQuestFlag to false")
	npcBad, nextQuestFlag, questIndex = false, false, 0
end

function addon:CheckNPC(traceEvent)
	traceEvent = "CkNPC~"..(traceEvent or "?")
	D(traceEvent)
	local npcID = UnitGUID("target") and tonumber( strsub( UnitGUID("target"), -12, -7), 16)
	if npcID then
		D(traceEvent, "type = GUID")
	end
	if not npcID then
		npcID = (GossipFrameNpcNameText:GetParent():IsVisible() and GossipFrameNpcNameText:GetText()) or (QuestFrameNpcNameText:GetParent():IsVisible() and QuestFrameNpcNameText:GetText())
		D(traceEvent, "type =", ( GossipFrameNpcNameText:GetText() and "Gossip Frame") or ( QuestFrameNpcNameText:GetText() and "QuestFrame" ) )
	end
	if not npcID then return end
	local f = false
	for i,v in pairs(questNPCs) do
		if v:find(npcID) then
			f = npcID
		end
	end
	if not f then
		D(traceEvent, "set nextQuestFlag false")
		nextQuestFlag, questIndex = false, 0
		return
	else
		D(traceEvent, "found npc", f)
		return f
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
--[[
	logic:
		function is fed the varg arg with everything from GetGossipActiveQuests() looks like this.
		"Troll Patrol: The Alchemist's Apprentice", 76, nil, "QuestTitle", "QuestLvl", "Trivaial" =  GetGossipActiveQuests()
]]--

function scrubQuests(title, lvl, triv, ...)
	if not (...) then return title end
	return title, scrubQuests(...)
end

local function QuestItterateTurnIn(npc, ...)
	local e = "QiTi"
	D(e, ...)
	if not (...) then return end
	local numQuests = select("#", ...)
	D(e, "nextQuestFlag:", nextQuestFlag)
	if nextQuestFlag then	--Means we've been here before and we're moving on...
		nextQuestFlag = false	--don't want to fk with things
		questIndex = questIndex +1	--push the index up one so we can move on
		D(e, "NextQuest, newIndex:",  questIndex)
		if questIndex > numQuests then	--if our new index is greater than the available quests, flag it and return the first quest for looping
			D(e, "Index is grater than Number, index:", questIndex, "total:", numQuests)
			npcBad = true		--flag the NPC bad
			questIndex = 1		--reset the index to 1
			D(e, "set flag true and index to 1")
			for i = 1, numQuests do	--itterate the vars though
				if qTable(select(i,...)) then	--test quest
					questIndex = i	--if found set the index
					D(e, "found quest", i, (select(i, ...)))
					return questIndex, (select(i, ...))	--return the index and questName for debugging
				end
			end
		else		--means that we're still in the first round or we havn't hit the end yet
			D(e, "index less than total, inner round, push next index for quest")
			for i = questIndex, numQuests do		--start at our index, as we've allready bumpted it up to the next one in sequence
				if qTable(select(i,...)) then	--test quest
					questIndex = i	--if found set the index
					D(e, "found quest", i, (select(i, ...)))
					return questIndex, (select(i, ...))	--return the index and questName for debugging
				end
			end
		end
	else		-- Weee first quest - this is the likely senerio.
		D(e, "First timers")
		questIndex = 1
		for i = questIndex, numQuests do		--start at our index, as we've allready bumpted it up to the next one in sequence
			if qTable(select(i,...)) then	--test quest
				questIndex = i	--if found set the index
				D(e, "found quest", i, (select(i, ...)))
				return questIndex, (select(i, ...))	--return the index and questName for debugging
			end
		end
	end
end
				


local function old_QuestItterateTurnIn(npc, ...)
	local e = "QuestItterateTurnIn"
	D(e, ...)
	if (...) == nil then return end
	local numArgs = select("#", ...)
	D(e, "numArgs:", numArgs)
	if nextQuestFlag then
		D(e, "hasNextQuestFlag, questIndex:", questIndex)
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
		selection, quest = QuestItterateTurnIn(npc, scrubQuests(GetGossipActiveQuests()))
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

