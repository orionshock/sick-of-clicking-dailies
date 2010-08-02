
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

local projectVersion = "@project-version@"
local projectRevision = "@project-abbreviated-hash@"
if projectVersion:find("project") then
	projectVersion = "git"
	projectRevision = "dev"
end

SOCD  = LibStub("AceAddon-3.0"):NewAddon("SickOfClickingDailies", "AceEvent-3.0", "AceConsole-3.0")
SOCD.version = projectVersion.."-"..projectRevisiion

local addon = SOCD
local db

local function Debug(...)
	if db and db.global.debug.core then
		local str = string.join(", ", tostringall(...) )
		str = str:gsub("[:=],", "%1")
		print("SOCD-Debug-Core: ", str)
	end
end

local module_Proto = {
	Debug = function(self, ...)
		if db and db.global.debug[ self:GetName() ] then
			local str = string.join(", ", tostringall(...) )
			str = str:gsub("[:=],", "%1")
			print("|cff9933FFSOCD-Debug-"..( self.GetName and self:GetName() or "")..":|r ", str)
		end
	end,
	ToggleQuestStatus = function(self, title, status)
		self:Debug("ToggleQuestStatus", title, status)		--Place Holder
		if type(status) ~= "boolen" then
			self:Debug("ToggleQuestStatus", title, "Not a boolen value, got:", status)
			return
		end
		db.profile.QuestStatus[title] = status
		
	end
	SetQuestRewardOption = function(self, title, opt)
		self:Debug("SetQuestRewardOption", title, opt)		--Place Holder
		if type(opt) ~= "number" then
			self:Debug("SetQuestRewardOption", title, "Option not a number, got:", opt)
		end
		db.profile.QuestRewardOptions[title] = opt
	end
	
}
SOCD:SetDefaultModulePrototype(module_Proto)

---------------------------------------------------------------------------

local db_defaults = {
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
		}
	},
	global = {
		debug = {
			core = true,
		},
		QuestNameCache = {
		},
	},
}

function addon:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("SOCD_SEVEN", db_defaults)
	db = self.db

end

function addon:OnEnable(event, addon)

	self:RegisterEvent("GOSSIP_SHOW")
	self:RegisterEvent("QUEST_GREETING")
	self:RegisterEvent("QUEST_DETAIL")
	self:RegisterEvent("QUEST_PROGRESS")
	self:RegisterEvent("QUEST_COMPLETE")

	self:RegisterChatCommand("socd", function()
			print("SOCD Slash Command Place Holder")
	end)
	if db.global.currentRev ~= self.version then
		--self:GetModule("QuestScanner"):Update()
		--db.global.currentRev = self.version
	end
end

--[[
	Gossip Show Event
		2 helper functions to scrub though the information.
		IMO this api sucks.
		Sadly when turning in quests, we don't know if they are daily's, but don't care about that now.
]]--
local function procGetGossipAvailableQuests(index, title, _, _, isDaily, _, ...)
	if title and isDaily then
		if not addon:ShouldIgnoreQuest(title) then
			return index, title, isDaily
		end
	elseif ... then
		return procGetGossipAvailableQuests(index + 1, ...)
	end
end

local function procGetGossipActiveQuests(index, title, _, _, isComplete, ...)
	if title and isComplete then
		if not addon:ShouldIgnoreQuest(title) then
			return index, title, isComplete
		end
	elseif ... then
		return procGetGossipActiveQuests(index+1, ...)
	end
end

function addon:GOSSIP_SHOW(event)
	if IsShiftKeyDown() then return end
	Debug(event)
	local index, title, isDaily = procGetGossipAvailableQuests(1, GetGossipAvailableQuests() )
	if index then
		Debug("Found Available, Quest:", title, "~IsDaily:",isDaily, "~ShouldIgnore:", self:ShouldIgnoreQuest(title) )
		return SelectGossipAvailableQuest(index)
	end
	local index, title, isComplete = procGetGossipActiveQuests(1, GetGossipActiveQuests() )
	if index then
		Debug("Found Active Quest that is Complete:", title, "~IsComplete:", isComplete, "~ShouldIgnore:", self:ShouldIgnoreQuest(title) )
		return SelectGossipActiveQuest(index)
	end
--	Debug("Proccess Gossip Options here")		
end

--[[
	Quest Greeting, npc's that don't want to talk give us this window. API here is Kinda Ugly.
]]--

function addon:QUEST_GREETING(event, ...)
	if IsShiftKeyDown() then return end
	Debug(event, ...)
	local numActiveQuests = GetNumActiveQuests()
	local numAvailableQuests = GetNumAvailableQuests()
	Debug("AvailableQuests")
	for i = 1, numAvailableQuests do
		local title, _, isDaily = GetAvailableTitle(i), GetAvailableQuestInfo(i)
		Debug("Quest:", title, "~IsDaily:", isDaily, "~ShouldIgnore:", self:ShouldIgnoreQuest(title) )
		if (title and isDaily) and ( not self:ShouldIgnoreQuest(title) ) then
			Debug("picking up quest:", title)
			SelectAvailableQuest(i)
		end
	end
	for i = 1, numActiveQuests do
		local title, isComplete = GetActiveTitle(i)
		Debug("Quest:", title, "~isComplete:", isComplete, "~ShouldIgnore:", self:ShouldIgnoreQuest(title) )
		if (title and isComplete) and ( not self:ShouldIgnoreQuest(title) ) then
			Debug("turning in quest:", title)
			SelectActiveQuest(i)
		end
	end
end

--[[
	Quest Detail Event
]]--

function addon:QUEST_DETAIL(event)
	if IsShiftKeyDown() then return end
	local title = GetTitleText()
	Debug(event, title, "~IsDaily/Weekly:" , QuestIsDaily() or QuestIsWeekly(), "~ShouldIgnore:", self:ShouldIgnoreQuest(title) )

	if ( QuestIsDaily() or QuestIsWeekly() ) then
		self:CaptureDailyQuest(title)
		if self:ShouldIgnoreQuest(title) then return end
		Debug("Accepting Daily/Weekly Quest:", title)
		return AcceptQuest()
	end
end
--[[
	Quest Progress Event
]]--

function addon:QUEST_PROGRESS(event)
	if IsShiftKeyDown() then return end
	local title = GetTitleText()

	Debug(event, title, "~IsCompleteable:", IsQuestCompletable(), "~IsDaily/Weekly:" , QuestIsDaily() or QuestIsWeekly(), "~ShouldIgnore:", self:ShouldIgnoreQuest(title) )

	if not IsQuestCompletable() then return end
	if ( QuestIsDaily() or QuestIsWeekly() ) and ( not self:ShouldIgnoreQuest(title) ) then
		Debug("Completing Quest:", title)
		CompleteQuest()
	end
end


--[[
	Quest Complete Event
		--Can't get this far unless you can turn it in.
]]--

function addon:QUEST_COMPLETE(event)
	if IsShiftKeyDown() then return end
	local title = GetTitleText()

	Debug(event, title, "~IsDaily/Weekly:" , QuestIsDaily() or QuestIsWeekly(), "~ShouldIgnore:", self:ShouldIgnoreQuest(title) )

	if ( QuestIsDaily() or QuestIsWeekly() ) and ( not self:ShouldIgnoreQuest(title) ) then
		local rewardOpt = self:GetQuestRewardOption( title )
		if (rewardOpt and (rewardOpt == -1)) then
			return
		elseif rewardOpt then
			Debug(event, "Getting Reward:", (GetQuestItemInfo("choice", rewardOpt)) )
			GetQuestReward( rewardOpt )
			return
		end
		Debug(event, "Getting Money!")
		GetQuestReward(0)
		return

	end
end




--[[
	General Support Functions
]]--

function addon:GetQuestRewardOption(title)
	--function broken atm during dev--
	return db.profile.QuestRewardOptions[title] or nil
end

function addon:ShouldIgnoreQuest(title)
	if db.global.QuestNameCache[title] == nil then
		return true
	end
	if db.profile.QuestStatus[title] == false then
		return true
	end
	return false
end

function addon:CaptureDailyQuest(title)
	if db then
		db.global.QuestNameCache[title] = true
	end
end
