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
addon.specialResetQuests = {}
--
--	Debug Func()
--
local D = function() end
--@alpha@
function D(arg, ...)
	local str
	if string.find(tostring(arg), "%%") then
		str = arg:format(...)
	else
		str = string.join(", ", tostringall(arg, ...) )
		str = str:gsub(":,", ":"):gsub("=,", "=")
	end
	if addon.db and addon.db.global.debug then
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
addon.D = D

--
--	Quest Name lookup func's
--

local function qTable(k)
	local f
	for _, questTable in pairs(moduleQLookup) do
		if questTable[k] then
			return questTable[k], k
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

function addon:RegisterQuests(name, questTable, options, gossip)
	--Quest Groupings
	assert(type(questTable) == "table")
	moduleQLookup[name] = questTable
	--Quest NPC ID's
--	assert(type(npcID) == "string")
--	questNPCs[name] = npcID
	--Quest Options
	assert(type(options) == "table")
	moduleQOptions[name] = options
--	D("Quest Grouping %s registered", name)
	if gossip then
		assert(type(gossip) == "table")
		moduleGossipOptions[name] = gossip
--		D("Gossip Options for %s registered", name)
	end
end

function addon:UnRegisterQuests(name)
	if moduleQLookup[name] then
		moduleQLookup[name] = nil
		moduleQOptions[name] = nil
		questNPCs[name] = nil
		moduleGossipOptions[name] = nil

--		D("Quest Grouping %s unregistered", name)

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
		modules = {
			["DailyLogoutWarning"] = false,
		},
	},
	global = {
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
			MiscOpt = {type = "group", name = L["Misc Options"], order = -2, args = {}, plugins = {} },
			moduleControl = {
				name = L["Module Control"],
				type = "group", order = -1,
				args = {
					--@alpha@
					debug = { type = "toggle", name = "Enable Debug", get = function() return addon.db.global.debug end, set = function(_, val) addon.db.global.debug = val end },
					--@end-alpha@
				},
			},
		},
	}
	local i = 1
	for name, module in addon:IterateModules() do
		options.args[name] = (type(module.GetOptionsTable) == 'function' and module:GetOptionsTable(options)) or nil
		if not module.noModuleControl then
			options.args.moduleControl.args[name] = GetModuleOptions(L[name], name)
		end
		i = i + 1
	end
	local profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(addon.db)
	profile.inline = true
	profile.order = 30
	options.args.MiscOpt.args.profile = profile
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
		if defaults.profile.modules[name] == nil then
			defaults.profile.modules[name] = true
		end
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
	self.QuestLogCache = {}
end

function addon:OnEnable()
	self:RegisterEvent("GOSSIP_SHOW")
	self:RegisterEvent("QUEST_GREETING")
	self:RegisterEvent("QUEST_DETAIL")
	self:RegisterEvent("QUEST_PROGRESS")
	self:RegisterEvent("QUEST_COMPLETE")
	self:RegisterEvent("PLAYER_TARGET_CHANGED")
	self:RegisterEvent("QUEST_LOG_UPDATE")
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
--	local npc = self:CheckNPC(event)
--	if not npc then
--		D(event, "no known npc")
--		return
--	end
	if (IsShiftKeyDown()) then return end
	local sel, quest, status = self:OpeningCheckQuest(event)
	D(event, "logic batterie sel:", sel, "quest:", quest, "status:", status)
	if sel then
		D(event, "We have quest selection", sel, quest, status, "| BadNPC:", npcBad)
		if npcBad then
			D(event, "badNPC, gossipDive")
			self:DoGossipOptions(event.."~EoQ" )
			if not self.db.profile.questLoop then
				D(event,"No QuestLooping, exit Func")
				return
			end
		end
		D(event, npcBad and "QuestLoopingEnabled" )
		D(event, "Interacting with NPC", status, sel, quest)
		if status == "Available" then
			return SelectGossipAvailableQuest(sel)
		elseif status == "Active" then
			return SelectGossipActiveQuest(sel)
		end
	elseif not sel then
		D(event, "No quests?? just gossip")
		self:DoGossipOptions(event.."~NoQ")
	end
end

function addon:DoGossipOptions(te)
	te = "GosOpt~"..te
	D(te)
	local hasGossip, index = self:AnalyzeGossipOptions(te, GetGossipOptions() )
	D(te, hasGossip, index)
	if hasGossip then
		D(te, hasGossip:sub(1,8), index)
		npcBad =  false
		D(te, "selectingOpt", index)
		SelectGossipOption(index)
	end
end

function addon:QUEST_GREETING(event, ...)
	local stopFlag, s_title, s_npc = false, nil, nil
--	local npc = self:CheckNPC(event)
--	if not npc then
--		D(event, "no known npc")
--		return
--	end
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
	D(event)
	if IsShiftKeyDown() then return end
--	local npc = self:CheckNPC(event)
	local quest = self:TitleCheck(event)
	D(event, "found:", npc, quest)
	if quest then	--	if npc and quest then
		D(event,"Accepting Quest", quest, npc)
		AcceptQuest()
		return
	end
end


function addon:QUEST_PROGRESS(event)
	D(event)
   	if IsShiftKeyDown() then return end
--	local npc = self:CheckNPC(event)
	local quest = self:TitleCheck(event)
	D(event, "found:", npc, quest)
	if quest then	--	if npc and quest then
		if not IsQuestCompletable() then
			D(event, "QuestNotCompleteable, set flag and DeclineQuest()")
			nextQuestFlag = true
			DeclineQuest()
			return
		else
			D(event, "set nextQuestFlag to false")
			nextQuestFlag = false
		end
		D(event, "Turning in quest")
		return CompleteQuest() --HERE
    end
end

do
	function addon:QUEST_COMPLETE(event)
		stopFlag = false
		D(event, "nextQuestFlag to false")
		nextQuestFlag = false
		if IsShiftKeyDown() then return end
--		local npc = self:CheckNPC(event)
		local quest = self:TitleCheck(event)
		if quest then	--	if npc and quest then
			local opt = qOptions(quest)
			if (opt and (opt == -1)) then
				stopFlag = true
				D(event, "Has Option and time to stop", quest, opt)
				return
			elseif opt then
				stopFlag = false
				D(event, "Getting Reward!", opt)
				GetQuestReward( opt )
				return
			end
			D(event, "Getting Money!")
			GetQuestReward(0)
			return
	    end
	end

	function SOCD_GetQuestRewardHook(opt)
		local enabled, present =  qTable(GetTitleText())
--		local npcID = addon:CheckNPC("hook")
		D("GetQuestRewardHook", enabled, present, npcID)
		if present then
			D("SOCD_DAILIY_QUEST_COMPLETE", present, npcID, opt, addon.QuestLogCache[present])
			addon:SendMessage("SOCD_DAILIY_QUEST_COMPLETE", present, npcID, opt, addon.QuestLogCache[present])
		end
	end
	hooksecurefunc("GetQuestReward", SOCD_GetQuestRewardHook )

end

function addon:QUEST_LOG_UPDATE(event)
	self:UnregisterEvent(event)
	D(event)
	for i  = 1, GetNumQuestLogEntries() do
               	local questTitle, level, questTag, suggestedGroup, isHeader , isCollapsed, isComplete, isDaily, questID = GetQuestLogTitle(i)
		self.QuestLogCache[questTitle] = (not isHeader) and questID
	end
			
	self:RegisterEvent(event)
end

function addon:PLAYER_TARGET_CHANGED(event)
	D(event, "Set nextQuestFlag to false")
	npcBad, nextQuestFlag, questIndex = false, false, 0
end

--function addon:CheckNPC(te)
--	te = "CkNPC~"..te
--	local npcID = UnitGUID("target") and tonumber( strsub( UnitGUID("target"), -12, -7), 16)
--	if not npcID then
--		npcID = (GossipFrameNpcNameText:GetParent():IsVisible() and GossipFrameNpcNameText:GetText()) or (QuestFrameNpcNameText:GetParent():IsVisible() and QuestFrameNpcNameText:GetText())
--	end
--	if not npcID then
--		D(te, "no npc/object found")
--		return
--	end
--	local f = false
--	for i,v in pairs(questNPCs) do
--		if v:find(npcID) then
--			f = npcID
--		end
--	end
--	if not f then
--		D(te, "no npc/object found")
--		nextQuestFlag, questIndex = false, 0
--		return
--	else
--		D(te, "found npc", f)
--		return f
--	end
--end

local function scrubQuests(title, lvl, triv, ...)
	if not (...) then return title end
	return title, scrubQuests(...)
end

function addon:QuestItteratePickUp(te, ...)
	te = "QuPickUp~"..te
	if (...) == nil then
		D(te, "nil opening on the vargArg")
		return
	end
	for i=1, select("#", ...) do
		local element = select(i, ...)
		if qTable(element) then
			D(te, "found quest, index:", i , "Quest:", element )
			return i , element
		end
	end
end
--[[
	logic:
		function is fed the varg arg with the titles from GetGossipActiveQuests() looks like this.
--		"Troll Patrol: The Alchemist's Apprentice", 76, nil,
--		format: "QuestTitle", "QuestLvl", "Trivaial" =  GetGossipActiveQuests()
]]--

function addon:QuestItterateTurnIn(te, ...)
	te = "QiTi~"..te
	D(te, ...)
	if not (...) then return end
	local numQuests = select("#", ...)
	D(te, "nextQuestFlag:", nextQuestFlag)
	if nextQuestFlag then	--Means we've been here before and we're moving on...
		nextQuestFlag = false	--don't want to fk with things
		questIndex = questIndex +1	--push the index up one so we can move on
		D(te, "NextQuest, newIndex:",  questIndex)
		if questIndex > numQuests then	--if our new index is greater than the available quests, flag it and return the first quest for looping
			D(te, "Index is grater than Number, index:", questIndex, "total:", numQuests)
			npcBad = true		--flag the NPC bad
			questIndex = 1		--reset the index to 1
			D(te, "set flag true and index to 1")
			for i = 1, numQuests do	--itterate the vars though
				if qTable(select(i,...)) then	--test quest
					questIndex = i	--if found set the index
					D(te, "found quest", i, (select(i, ...)))
					return questIndex, (select(i, ...))	--return the index and questName for debugging
				end
			end
		else		--means that we're still in the first round or we havn't hit the end yet
			D(te, "index less than total, inner round, push next index for quest")
			for i = questIndex, numQuests do		--start at our index, as we've allready bumpted it up to the next one in sequence
				if qTable(select(i,...)) then	--test quest
					questIndex = i	--if found set the index
					D(te, "found quest", i, (select(i, ...)))
					return questIndex, (select(i, ...))	--return the index and questName for debugging
				end
			end
		end
	else		-- Weee first quest - this is the likely senerio.
		D(te, "First timers")
		questIndex = 1
		for i = questIndex, numQuests do		--start at our index, as we've allready bumpted it up to the next one in sequence
			if qTable(select(i,...)) then	--test quest
				questIndex = i	--if found set the index
				D(te, "found quest", i, (select(i, ...)))
				return questIndex, (select(i, ...))	--return the index and questName for debugging
			end
		end
	end
end

function addon:OpeningCheckQuest(te)
	te = "OpQu~"..te
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
	te = "TitleCk~"..te
	if qTable(GetTitleText()) then
		D(te, GetTitleText())
		return GetTitleText()
	end
end


function addon:AnalyzeGossipOptions(te, ...)
	te = "EvalGossip~"..te
	D(te, "evaluating" )
	local numArgs, count = select("#", ...), 0
	for i = 1, numArgs, 2 do
		local element = select(i+1, ...) == "gossip" and select(i, ...) or ""
		D(te, "Found element:", element:sub(1,8), (i+1)/2)
		if gossipOption(element) then
			D(te, "Is one of ours")
			return element, (i+1)/2
		end
	end
	return false, 0
end
