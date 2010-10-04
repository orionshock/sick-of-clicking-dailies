--[[
Sick Of Clicking Dailies is a simple addon designed to pick up and turn in Dailiy Quests for WoW.

This version comes with a built in config system made with Ace3's Config GUI Libs.

@project-version@
@project-abbreviated-hash@

=====================================================================================================
 Copyright (c) 2010 by Orionshock

	see included "LICENSE.txt" file with zip for details on copyright.

=====================================================================================================
]]--
local addonName, AddonNS = ...

local projectVersion = "@project-version@"
local projectRevision = "@project-abbreviated-hash@"
if projectVersion:find("project") then
	projectVersion = "git"
	projectRevision = "dev"
end

_G[addonName] = LibStub("AceAddon-3.0"):NewAddon(AddonNS, addonName, "AceEvent-3.0", "AceConsole-3.0")
AddonNS.version = projectVersion.."-"..projectRevision
AddonNS.SpecialQuestResets = {}
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local addon = AddonNS
local db

local function Debug(...)

	local str = string.join(", ", tostringall(...) )
	str = str:gsub("([:=>]),", "%1")
	str = str:gsub(", ([%-])", " %1")

	if db and db.global.debug.core then
		print("SOCD-Debug-Core: ", str)
	end
	return str
end

local module_Proto = {
	Debug = function(self, ...)
		if db and db.global.debug[ self:GetName() ] then
			local str = string.join(", ", tostringall(...) )
			str = str:gsub("([:=>]),", "%1")
			str = str:gsub(", ([%-])", " %1")
			print("|cff9933FFSOCD-Debug-"..( self.GetName and self:GetName() or "")..":|r ", str)
		end
	end,
	SetQuestStatus = function(self, title, status)
		self:Debug("ToggleQuestStatus", title, status)		--Place Holder
		if type(status) ~= "boolean" then
			self:Debug("ToggleQuestStatus", title, "Not a boolen value, got:", status)
			return
		end
		db.profile.QuestStatus[title] = status

	end,
	SetQuestRewardOption = function(self, title, opt)
		self:Debug("SetQuestRewardOption", title, opt)		--Place Holder
		if type(opt) ~= "number" then
			self:Debug("SetQuestRewardOption", title, "Option not a number, got:", opt)
		end
		db.profile.QuestRewardOptions[title] = opt
	end,
	AddGossipAutoSelect = function(self, text, default)
		db.profile.GossipAutoSelect[text] = db.profile.GossipAutoSelect[text] or default
	end,
	GetSetGossipStatus = function(self, text, status)
		if status == nil then
			return db.profile.GossipAutoSelect[text]
		else
			db.profile.GossipAutoSelect[text] = status
		end
	end

}
addon:SetDefaultModulePrototype(module_Proto)

----------------------------------------------------------------------

local db_defaults = {
	char = {
		questsCompleted = {
		},
	},
	profile = {
		addonOpts = {
			--will populate later
		},
		QuestStatus = {
			-- By default all quests are Enabled, it's only after the user sees said quest that it can be turned off.
			-- Some quests are off by default, Such as ones that require you to pay money or like the faction switchers in solizar.
		},
		QuestRewardOptions = {
			-- -1 means stop, rest mean use, it's left up to the modules to make sure this works right.
		},
		GossipAutoSelect = {
		},
	},
	factionrealm = {
		chars = {
		},
	},
	global = {
		debug = {
			core = false,
			QuestScanner = false,
			Options = false,
			BC = false,
			LDB = false,
			LK = false,
		},
		QuestNameCache = {
		},	--Also used by Addon to see if the quest is a daily. this is a  { ["Localized Quest Name"] = true } table
		localeQuestNameByID = {
		},	---Use by Addon API to get localized quest name from ID. This is a  { [questID] = "Localized Quest Name" } table
	},
}

function addon.GetOptionsTable()
	local t = { name = addonName, type = "group", handler = addon,
		args = {
			info = {type = "description", name = L["MainOptionsDesc"], order = 1 },
			profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(db),
			--@alpha@
			debug = { type = "group", name = "Debug", order = -1,
				args = {
					masDebug = { type = "multiselect", name = "Enable / Disable Module Debug", order = 1,
						get = function(info, val) return addon.db.global.debug[ val ] end,
						set = function(info, opt, val) addon.db.global.debug[ opt ] = val end,
						values = {
							["core"] = "Core", ["QuestScanner"] = "Quest Scanner", ["Options"] = "Options",
							["BC"] = "BC Module", ["LDB"] = "LDB Module", ["LK"] = "LK Module",
						},
					},
				enableAll = { type = "execute", name = "Enable All", func = function(info) for k,v in pairs(addon.db.global.debug) do addon.db.global.debug[k] = true end end, },
				disableAll = { type = "execute", name = "Disable All", func = function(info) for k,v in pairs(addon.db.global.debug) do addon.db.global.debug[k] = false end end, },
				rescan = { type = "execute", name = "Rescan Quest Names", func = function(info) addon:GetModule("QuestScanner"):StartScan() end, order = -1,}
				},
			},
			--@end-alpha@
		},
	}
	t.args.profiles.order = -10
	--Debug("GetOptionsTable, itterating modules")
	for name, module in addon:IterateModules() do
		--Debug("Module:", name, module.options)
		if module.options then
			t.args[name] = module.options
		end
	end
	return t
end

function addon:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("SOCD_SEVEN", db_defaults, true)
	db = self.db
end

function addon:OnEnable(event, addon)
	--Events
	self:RegisterEvent("GOSSIP_SHOW")
	self:RegisterEvent("QUEST_GREETING")
	self:RegisterEvent("QUEST_DETAIL")
	self:RegisterEvent("QUEST_PROGRESS")
	self:RegisterEvent("QUEST_COMPLETE")
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	self:RegisterEvent("ZONE_CHANGED", "ZONE_CHANGED_NEW_AREA")
	self:ZONE_CHANGED_NEW_AREA("OnEnable")

	--Options & Slash command

	local AceConfigDialog = LibStub("AceConfigDialog-3.0")
	LibStub("AceConfig-3.0"):RegisterOptionsTable(addonName, self.GetOptionsTable)
	self:RegisterChatCommand("socd", function()
		if self.QuestNameScanned then
			if  AceConfigDialog.OpenFrames[addonName] then
				AceConfigDialog:Close(addonName)
			else
				AceConfigDialog:Open(addonName)
			end
		else
			print("|cff9933FFSickOfClickingDailies|r --", L["Still Setting up localizations please wait"])
		end
	end)
end

--[[
	Gossip Show Event
		2 helper functions to scrub though the information.
		IMO this api sucks.
		Sadly when turning in quests, we don't know if they are daily's, but don't care about that now.
]]--
local function procGetGossipAvailableQuests(index, title, _, _, isDaily, isRepeatable, ...)
	--Debug("procGetGossipAvailableQuests", title, isDaily, isRepeatable)
	if ( addon:IsQuest(title) or (isDaily or isRepeatable) ) then
		addon:CaptureDailyQuest(title, ((isDaily and "D") or (isRepeatable and "R") ) )
		if addon:ShouldIgnoreQuest(title) then
			--Debug("Ignoring quest:", title, "finishing loop")
			if ... then
				return procGetGossipAvailableQuests(index + 1, ...)
			end
		else
			--Debug("found:", title)
			return index, title
		end
	elseif ... then
		--Debug("none found on index:", index)
		return procGetGossipAvailableQuests(index + 1, ...)
	end
	--Debug("nothing found")
end

local function procGetGossipActiveQuests(index, title, _, _, isComplete, ...)
	if  addon:IsQuest(title) and isComplete then
		return index, title
	elseif ... then
		return procGetGossipActiveQuests(index+1, ...)
	end
end

function addon:GOSSIP_SHOW(event)
	--Debug(event)
	if IsShiftKeyDown() then return end

	local index, title = procGetGossipAvailableQuests(1, GetGossipAvailableQuests() )
	if index then
		--Debug("Found Available, Quest:", title, "~ShouldIgnore:", self:ShouldIgnoreQuest(title) )
		return SelectGossipAvailableQuest(index)
	end

	local index, title = procGetGossipActiveQuests(1, GetGossipActiveQuests() )
	if index then
		--Debug("Found Active Quest that is Complete:", title, "~IsComplete:", isComplete, "~ShouldIgnore:", self:ShouldIgnoreQuest(title) )
		return SelectGossipActiveQuest(index)
	end
	--Debug("Proccessing Gossip ")
	self:ProccessGossipOptions( GetGossipOptions() )
end

function addon:ProccessGossipOptions( ... )
	for i = 1, select("#", ...), 2 do
		local txt, tpe = select(i, ...)
		if tpe == "gossip" then
			if db.profile.GossipAutoSelect[txt] then
				SelectGossipOption( i+1/2 )
			end
		end
	end
end
--[[
	Quest Greeting, npc's that don't want to talk give us this window. API here is Kinda Ugly.
]]--

function addon:QUEST_GREETING(event, ...)
	--Debug(event, ...)
	if IsShiftKeyDown() then return end
	local numActiveQuests = GetNumActiveQuests()
	local numAvailableQuests = GetNumAvailableQuests()
	--Debug("Looking @ AvailableQuests")
	for i = 1, numAvailableQuests do
		local title, _, isDaily, isRepeatable = GetAvailableTitle(i), GetAvailableQuestInfo(i)
		if procGetGossipAvailableQuests(i, title, nil, nil, isDaily, isRepeatable) then
			return SelectAvailableQuest(i)
		end
	end
	for i = 1, numActiveQuests do
		local title, isComplete = GetActiveTitle(i)
		--Debug("Quest:", title, "~isComplete:", isComplete, "~ShouldIgnore:", self:ShouldIgnoreQuest(title) )
		if procGetGossipActiveQuests(i, title, _, _, isComplete) then
			--Debug("turning in quest:", title)
			return SelectActiveQuest(i)
		end
	end
end

--[[
	Quest Detail Event
]]--

function addon:QUEST_DETAIL(event)
	local title = GetTitleText()
	--Debug(event, title)
	if IsShiftKeyDown() then return end
	if ( self:IsQuest(title) or QuestIsDaily() or QuestIsWeekly() ) then
		self:CaptureDailyQuest(title, ( (QuestIsDaily() and "D") or (QuestIsWeekly() and "W") ) )
		if self:ShouldIgnoreQuest(title) then
			--Debug("Ignoring Quest")
			return
		else
			--Debug("Accepting Quest:", title)
			return AcceptQuest()
		end
	end
end
--[[
	Quest Progress Event
]]--

function addon:QUEST_PROGRESS(event)
	local title = GetTitleText()
	--Debug(event, title, "~IsCompleteable:", IsQuestCompletable(), "~IsDaily/Weekly/Repeatable:" , self:IsQuest(title) or QuestIsDaily() or QuestIsWeekly(), "~ShouldIgnore:", self:ShouldIgnoreQuest(title) )
	if IsShiftKeyDown() then return end
	if not IsQuestCompletable() then return end
	if ( self:IsQuest(title) or QuestIsDaily() or QuestIsWeekly() ) then
		if self:ShouldIgnoreQuest(title) then return end
		--Debug("Completing Quest:", title)
		CompleteQuest()
	end
end


--[[
	Quest Complete Event
		--Can't get this far unless you can turn it in.
]]--

function addon:QUEST_COMPLETE(event)
	local title = GetTitleText()
	--Debug(event, title, "~IsDaily/Weekly:" , ( self:IsQuest(title) or QuestIsDaily() or QuestIsWeekly() ), "~ShouldIgnore:", self:ShouldIgnoreQuest(title) )
	if IsShiftKeyDown() then return end
	if ( self:IsQuest(title) or QuestIsDaily() or QuestIsWeekly() ) then
		if self:ShouldIgnoreQuest(title) then
			--Debug("Ignoring Quest")
			return
		end
		local rewardOpt = self:GetQuestRewardOption( title )
		if (GetQuestItemInfo("choice", 1) ~= "") and (not rewardOpt) then
			--Has quest option but we don't have a selection, means that this is a new quest that isn't in the DB.
			print(Debug("Sick Of Clicking Dailies: Found a new Quest:", title, " It has reward choices but is not yet added to the addon. Please report it at www.wowace.com"))
			return
		end
		if (rewardOpt and (rewardOpt == -1)) then
			--Debug(event, "Reward opt is -1")
			return
		elseif rewardOpt then
			--Debug(event, "Getting Reward:", (GetQuestItemInfo("choice", rewardOpt)) )
			GetQuestReward( rewardOpt )
			return
		end
		--Debug(event, "Getting Money!")
		GetQuestReward(0)
		return

	end
end

---Completion Hook :)
	function SOCD_GetQuestRewardHook(opt)
		local title = GetTitleText()
		--Debug("GetQuestRewardHook, IsDaily:", addon:IsQuest(title) )
		local isQuest, qtype = addon:IsQuest(title)
		if isQuest then	---Ignore repeatable quests here, as by nature don't have a lockout
			if qtype ~= "R" then
				addon:SendMessage("SOCD_DAILIY_QUEST_COMPLETE", title )
			end
		end
	end
	hooksecurefunc("GetQuestReward", SOCD_GetQuestRewardHook )
	function SOCD_TestDailyEventSend(title)
		addon:SendMessage("SOCD_DAILIY_QUEST_COMPLETE", title or "TestQuest"..time(), 0)
	end


local ignoreRLFD = {
	[258] = true,	--Classic Dungeon
	[259] = true,	--BC Dungeon
	[260] = true,	--BC Heroic Dungeon
}

function addon:ZONE_CHANGED_NEW_AREA(event, ...)
	local _, iType = GetInstanceInfo()
	Debug(event, iType)
	if iType == "none" then
		Debug("not in instance")
		for i = 1, GetNumRandomDungeons() do
			local id, name = GetLFGRandomDungeonInfo(i)
			local doneToday = GetLFGDungeonRewards(id)
			Debug(name, id, " - Done: ", doneToday, " - Ignore:", ignoreRLFD[id] )
			if doneToday and not ignoreRLFD[id] then
				addon:SendMessage("SOCD_DAILIY_QUEST_COMPLETE", name )
			end
		end
	else
		Debug("in broken area, don't scan random dungeosn")
	end
end

--[[
	General Support Functions
]]--

function addon:GetQuestRewardOption(title)
	title = title:trim()
	return db.profile.QuestRewardOptions[title] or nil
end

function addon:ShouldIgnoreQuest(title)
	title = title:trim()
	if db.global.QuestNameCache[title] == nil then
		return true
	end
	if db.profile.QuestStatus[title] == false then
		return true
	end
	return false
end

function addon:CaptureDailyQuest(title, qType)
	title = (title or ""):trim()
	if db then
		db.global.QuestNameCache[title] = db.global.QuestNameCache[title] or qType
	end
end

function addon:IsQuest(title)
	if title == nil then return end
	title = (title or ""):trim()
	return db.global.QuestNameCache[title] ~= nil, db.global.QuestNameCache[title]
end
