--[[
Major 6,  MinorSVN:  $Revision$

Sick Of Clicking Dailies is a simple addon designed to pick up and turn in Dailiy Quests for WoW.

This version comes with a built in config system made with Ace3's Config GUI Libs.

=====================================================================================================
 Copyright (c) 2007 by Orionshock

	see included "LICENSE.txt" file with zip for details on copyright.

=====================================================================================================
]]--

local projectVersion = "@project-version@"
local projectRevision = "@project-revision@"
local fileRevision = "@file-revision@"

local L = LibStub("AceLocale-3.0"):GetLocale("SOCD_Core")

SickOfClickingDailies = LibStub("AceAddon-3.0"):NewAddon("SickOfClickingDailies", "AceEvent-3.0", "AceConsole-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local addon = SickOfClickingDailies
addon.Version = projectVersion..projectRevision

--
--	Debug Func()
--
local D = function() end
--@alpha@
--@end-alpha@
function D(arg, ...)
	local str
	if string.find(tostring(arg), "%%") then
		str = arg:format(...)
	else
		str = string.join(", ", tostringall(arg, ...) )
		str = str:gsub(":,", ":"):gsub("=,", "=")
	end
	if addon.db.profile.debug then
		print("|cff9933FFSOCD:|r "..str)
	end
	return str
end
--@end-alpha@


--
--	Addon Decleration & File Wide locals
--

local moduleQLookup, moduleQOptions, questNPCs, moduleGossipOptions = {}, {}, {}, {}
addon.moduleQLookup = moduleQLookup
addon.moduleQOptions = moduleQOptions
addon.questNPCs = questNPCs
addon.moduleGossipOptions = moduleGossipOptions

--
--	Quest Name lookup func's
--

local function qTable(k)
	local f
	for _, questTable in pairs(moduleQLookup) do
		if questTable[k] then
			return questTable[k]
		elseif questTable[k] ~= nil then
			f = k
		end
	end
	return nil, f
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
	D("Quest Grouping %s registered", name)
	if gossip then
		assert(type(gossip) == "table")
		moduleGossipOptions[name] = gossip
		D("Gossip Options for %s registered", name)
	end
end

function addon:UnRegisterQuests(name)
	if moduleQLookup[name] then
		moduleQLookup[name] = nil
		moduleQOptions[name] = nil
		questNPCs[name] = nil
		moduleGossipOptions[name] = nil
--@alpha@
		D("Quest Grouping %s unregistered", name)
--@end-alpha@
	end
end

--
--	Options Table Defualts
--

local defaults = {
	char = {
		completedQuests = {},
		showExTT = false,
	},
	profile = {
		questLoop = true,
		modules = {},
		debug = false,
	},
}

--
--	Options Table & Module Methods for getting options tables
--

local function GetModuleOptions(Lname, mName)
	return { name = Lname, type = "toggle", get = "GetModuleState", set = "ToggleModule", arg = mName}
end

local function GetOptionsTable()
	local options = {
		name = L["Sick of Clicking Dailies"],
		type = "group",
		handler = addon,
		childGroups = "tab",
		args = {
			questLoop = { type = "toggle", name = L["Enable Quest Looping"], desc = L["questLoop_Desc"], get = "QuestLoop", set = "QuestLoop" },
			moduleControl = {
				name = L["Module Control"],
				type = "group", order = -1,
				args = {
					--@alpha@
					debug = { type = "toggle", name = "Enable Debug", get = function() return addon.db.profile.debug end, set = function(_, val) addon.db.profile.debug = val end },
					--@end-alpha@
				},
			},
		},
	}
	local i = 1
	for name, module in addon:IterateModules() do
		options.args[name] = (type(module.GetOptionsTable) == 'function' and module:GetOptionsTable()) or nil
		options.args.moduleControl.args[name] = GetModuleOptions(L[name], name)
		i = i + 1
	end
	return options
end

function addon:GetModuleState(info)
	return self.db.profile.modules[info.option.arg]
end
function addon:ToggleModule(info, value)
	local option = info.option.arg
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
	self:RegisterChatCommand("socd", function()
			if  AceConfigDialog.OpenFrames["SickOfClickingDailies"] then
				AceConfigDialog:Close("SickOfClickingDailies")
			else
				AceConfigDialog:Open("SickOfClickingDailies")
			end

		end )

	for name, module in self:IterateModules() do
		module:SetEnabledState(self.db.profile.modules[name])

	end
end

function addon:OnEnable()
	self:RegisterEvent("GOSSIP_SHOW")
	self:RegisterEvent("QUEST_GREETING")
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
--@alpha@
	D(event)
--@end-alpha@
	local stopFlag, s_title, s_npc = false, nil, nil
	local npc = self:CheckNPC(event)
	if not npc then
--@alpha@
		D(event, "no known npc")
--@end-alpha@
		return
	end
	if (IsShiftKeyDown()) then return end
	local sel, quest, status = self:OpeningCheckQuest(event)
--@alpha@
	D(event, "logic batterie sel:", sel, "quest:", quest, "status:", status)
--@end-alpha@
	if sel then
--@alpha@
		D(event, "We have quest selection", sel, quest, status, "| BadNPC:", npcBad)
--@end-alpha@
		if npcBad then
--@alpha@
			D(event, "badNPC, gossipDive")
--@end-alpha@
			self:DoGossipOptions(event.."~EoQ" )
			if not self.db.profile.questLoop then
--@alpha@
				D(event,"No QuestLooping, exit Func")
--@end-alpha@
				return
			end
		end
--@alpha@
		D(event, npcBad and "QuestLoopingEnabled" )
		D(event, "Interacting with NPC", status, sel, quest)
--@end-alpha@
		if status == "Available" then
			return SelectGossipAvailableQuest(sel)
		elseif status == "Active" then
			return SelectGossipActiveQuest(sel)
		end
	elseif not sel then
--@alpha@
		D(event, "No quests?? just gossip")
--@end-alpha@
		self:DoGossipOptions(event.."~NoQ")
	end
end

function addon:DoGossipOptions(te)
--@alpha@
	te = "GosOpt~"..te
	D(te)
--@end-alpha@
	local hasGossip, index = self:AnalyzeGossipOptions(te, GetGossipOptions() )
--@alpha@
	D(te, hasGossip, index)
--@end-alpha@
	if hasGossip then
--@alpha@
		D(te, hasGossip:sub(1,8), index)
--@end-alpha@
		npcBad =  false
--@alpha@
		D(te, "selectingOpt", index)
--@end-alpha@
		SelectGossipOption(index)
	end
end

function addon:QUEST_GREETING(event, ...)
	local stopFlag, s_title, s_npc = false, nil, nil
	local npc = self:CheckNPC(event)
	if not npc then
--@alpha@
		D(event, "no known npc")
--@end-alpha@
		return
	end
	if (IsShiftKeyDown()) then return end
	local numActiveQuests = GetNumActiveQuests();
	local numAvailableQuests = GetNumAvailableQuests();

	if numAvailableQuests > 0 then
		local selection, quest = self:QuestItteratePickUp(event, GetAvailableTitle(1), GetAvailableTitle(2), GetAvailableTitle(3), GetAvailableTitle(4), GetAvailableTitle(5), GetAvailableTitle(6) )
		if selection and quest then
			SelectAvailableQuest(selection)
			return
		end
	end

	if numActiveQuests > 0 then
		local selection, quest = self:QuestItterateTurnIn(event, GetActiveTitle(1), GetActiveTitle(2), GetActiveTitle(3), GetActiveTitle(4), GetActiveTitle(5), GetActiveTitle(6) )
		if selection and quest then
			SelectActiveQuest(selection)
			return
		end
	end


end

function addon:QUEST_DETAIL(event)
--@alpha@
	D(event)
--@end-alpha@
	if IsShiftKeyDown() then return end
	local npc = self:CheckNPC(event)
	local quest = self:TitleCheck(event)
--@alpha@
	D(event, "found:", npc, quest)
--@end-alpha@
	if npc and quest then
--@alpha@
		D(event,"Accepting Quest", quest, npc)
--@end-alpha@
		AcceptQuest()
		return
	end
end


function addon:QUEST_PROGRESS(event)
--@alpha@
	D(event)
--@end-alpha@
   	if IsShiftKeyDown() then return end
	local npc = self:CheckNPC(event)
	local quest = self:TitleCheck(event)
--@alpha@
	D(event, "found:", npc, quest)
--@end-alpha@
	if npc and quest then
		if not IsQuestCompletable() then
--@alpha@
			D(event, "QuestNotCompleteable, set flag and DeclineQuest()")
--@end-alpha@
			nextQuestFlag = true
			DeclineQuest()
			return
		else
--@alpha@
			D(event, "set nextQuestFlag to false")
--@end-alpha@
			nextQuestFlag = false
		end
--@alpha@
		D(event, "Turning in quest")
--@end-alpha@
		return CompleteQuest() --HERE
    end
end

do
	function addon:QUEST_COMPLETE(event)
		stopFlag = false
--@alpha@
		D(event, "nextQuestFlag to false")
--@end-alpha@
		nextQuestFlag = false
		if IsShiftKeyDown() then return end
		local npc = self:CheckNPC(event)
		local quest = self:TitleCheck(event)
		if npc and quest then
			local opt = qOptions(quest)
			if (opt and (opt == 5)) then
				stopFlag = true
				s_title, s_npc = quest, npc
--@alpha@
				D(event, "Has Option and time to stop", quest, opt)
--@end-alpha@
				return
			elseif opt and (opt >= 1 and opt <= 4 ) then
				stopFlag = false
--@alpha@
				D(event, "Getting Money!", opt)
--@end-alpha@
				GetQuestReward( opt )
				self:SendMessage("SOCD_DAILIY_QUEST_COMPLETE", quest, npc, opt)
				return
			end
--@alpha@
			D(event, "Getting Money!")
--@end-alpha@
			GetQuestReward(0)
			self:SendMessage("SOCD_DAILIY_QUEST_COMPLETE", quest, npc)
			return
	    end
	end

	local function SOCD_GetQuestRewardHook(opt)
		if stopFlag then
			addon:SendMessage("SOCD_DAILIY_QUEST_COMPLETE", s_title, s_npc, opt)
			stopFlag = false
			return
		end
		local enabled, present =  qTable(GetTitleText())
		local npcID = addon:CheckNPC("hook")
		if (not enabled) and (present and npcID) then
			addon:SendMessage("SOCD_DAILIY_QUEST_COMPLETE", present, npcID, opt)
		end
	end
	hooksecurefunc("GetQuestReward", SOCD_GetQuestRewardHook )

end

function addon:PLAYER_TARGET_CHANGED(event)
--@alpha@
	D(event, "Set nextQuestFlag to false")
--@end-alpha@
	npcBad, nextQuestFlag, questIndex = false, false, 0
end

function addon:CheckNPC(te)
--@alpha@
	te = "CkNPC~"..te
--@end-alpha@
	local npcID = UnitGUID("target") and tonumber( strsub( UnitGUID("target"), -12, -7), 16)
	if not npcID then
		npcID = (GossipFrameNpcNameText:GetParent():IsVisible() and GossipFrameNpcNameText:GetText()) or (QuestFrameNpcNameText:GetParent():IsVisible() and QuestFrameNpcNameText:GetText())
	end
	if not npcID then
--@alpha@
		D(te, "no npc/object found")
--@end-alpha@
		return
	end
	local f = false
	for i,v in pairs(questNPCs) do
		if v:find(npcID) then
			f = npcID
		end
	end
	if not f then
--@alpha@
		D(te, "no npc/object found")
--@end-alpha@
		nextQuestFlag, questIndex = false, 0
		return
	else
--@alpha@
		D(te, "found npc", f)
--@end-alpha@
		return f
	end
end

local function scrubQuests(title, lvl, triv, ...)
	if not (...) then return title end
	return title, scrubQuests(...)
end

function addon:QuestItteratePickUp(te, ...)
--@alpha@
	te = "QuPickUp~"..te
--@end-alpha@
	if (...) == nil then
--@alpha@
		D(te, "nil opening on the vargArg")
--@end-alpha@
		return
	end
	for i=1, select("#", ...) do
		local element = select(i, ...)
		if qTable(element) then
--@alpha@
			D(te, "found quest, index:", i , "Quest:", element )
--@end-alpha@
			return i , element
		end
	end
end
--[[
	logic:
		function is fed the varg arg with everything from GetGossipActiveQuests() looks like this.
		"Troll Patrol: The Alchemist's Apprentice", 76, nil,
		format: "QuestTitle", "QuestLvl", "Trivaial" =  GetGossipActiveQuests()
]]--

function addon:QuestItterateTurnIn(te, ...)
--@alpha@
	te = "QiTi~"..te
	D(te, ...)
--@end-alpha@
	if not (...) then return end
	local numQuests = select("#", ...)
--@alpha@
	D(te, "nextQuestFlag:", nextQuestFlag)
	if nextQuestFlag then	--Means we've been here before and we're moving on...
		nextQuestFlag = false	--don't want to fk with things
		questIndex = questIndex +1	--push the index up one so we can move on
--@alpha@
		D(te, "NextQuest, newIndex:",  questIndex)
--@end-alpha@
		if questIndex > numQuests then	--if our new index is greater than the available quests, flag it and return the first quest for looping
--@alpha@
			D(te, "Index is grater than Number, index:", questIndex, "total:", numQuests)
--@end-alpha@
			npcBad = true		--flag the NPC bad
			questIndex = 1		--reset the index to 1
--@alpha@
			D(te, "set flag true and index to 1")
--@end-alpha@
			for i = 1, numQuests do	--itterate the vars though
				if qTable(select(i,...)) then	--test quest
					questIndex = i	--if found set the index
--@alpha@
					D(te, "found quest", i, (select(i, ...)))
--@end-alpha@
					return questIndex, (select(i, ...))	--return the index and questName for debugging
				end
			end
		else		--means that we're still in the first round or we havn't hit the end yet
--@alpha@
			D(te, "index less than total, inner round, push next index for quest")
--@end-alpha@
			for i = questIndex, numQuests do		--start at our index, as we've allready bumpted it up to the next one in sequence
				if qTable(select(i,...)) then	--test quest
					questIndex = i	--if found set the index
--@alpha@
					D(te, "found quest", i, (select(i, ...)))
--@end-alpha@
					return questIndex, (select(i, ...))	--return the index and questName for debugging
				end
			end
		end
	else		-- Weee first quest - this is the likely senerio.
--@alpha@
		D(te, "First timers")
--@end-alpha@
		questIndex = 1
		for i = questIndex, numQuests do		--start at our index, as we've allready bumpted it up to the next one in sequence
			if qTable(select(i,...)) then	--test quest
				questIndex = i	--if found set the index
--@alpha@
				D(te, "found quest", i, (select(i, ...)))
--@end-alpha@
				return questIndex, (select(i, ...))	--return the index and questName for debugging
			end
		end
	end
end

function addon:OpeningCheckQuest(te)
--@alpha@
	te = "OpQu~"..te
--@end-alpha@
	local selection, quest = self:QuestItteratePickUp(te, scrubQuests(GetGossipAvailableQuests()))
	if quest then
			return selection, quest, "Available"
	else
		selection, quest = self:QuestItterateTurnIn(te, scrubQuests(GetGossipActiveQuests()))
		if quest then
			return selection, quest, "Active"
		end
	end
end

function addon:TitleCheck(te)
--@alpha@
	te = "TitleCk~"..te
	if qTable(GetTitleText()) then
--@alpha@
		D(te, GetTitleText())
--@end-alpha@
		return GetTitleText()
	end
end


function addon:AnalyzeGossipOptions(te, ...)
--@alpha@
	te = "EvalGossip~"..te
	D(te, "evaluating" )
--@end-alpha@
	local numArgs, count = select("#", ...), 0
	for i = 1, numArgs, 2 do
		local element = select(i+1, ...) == "gossip" and select(i, ...) or ""
--@alpha@
		D(te, "Found element:", element:sub(1,8), (i+1)/2)
--@end-alpha@
		if gossipOption(element) then
--@alpha@
			D(te, "Is one of ours")
--@end-alpha@
			return element, (i+1)/2
		end
	end
	return false, 0
end
