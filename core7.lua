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

local addonName, addon = ...

local projectVersion = "@project-version@"
local projectRevision = "@project-abbreviated-hash@"
if projectVersion:find("project") then
	projectVersion = "git"
	projectRevision = "dev"
end


SOCD = LibStub("AceAddon-3.0"):NewAddon(addon, addonName, "AceEvent-3.0", "AceConsole-3.0")
addon.version = projectVersion.."-"..projectRevision

local db
--local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local function Debug(...)
	local str = string.join(", ", tostringall(...) )
	str = str:gsub("([:=>]),", "%1")
	str = str:gsub(", ([%-])", " %1")
	ChatFrame5:AddMessage("SOCD-Debug: "..str)
	return str
end

addon.db_defaults = {
	char = {},	--basically the char table is the quest log of dailies/weeklys completed.
	profile = {},
	realm = {
		chars = {
			--[player] = class,
			},
		questLog = {
			--[player] = {
				--[QuestName] = TTL,
			--	},
			},
		},
	global = {
		questCache = {},
	},
}

addon:SetDefaultModuleState(false)

function addon:OnInitialize()
	self:SetEnabledState(false)
	self:RegisterMessage("SOCD_FINISH_QUEST_SCAN", 
			function(event, ...) 
				addon:Enable()
				for k,v in addon:IterateModules() do
					v:Enable()
				end
			end )
end

function addon:OnEnable(event)
	self.db = LibStub("AceDB-3.0"):New("SOCD_DB", self.db_defaults, true)
	db = self.db
	--Events
	self:RegisterEvent("GOSSIP_SHOW")
	self:RegisterEvent("QUEST_GREETING")
	self:RegisterEvent("QUEST_DETAIL")
	self:RegisterEvent("QUEST_PROGRESS")
	self:RegisterEvent("QUEST_COMPLETE")
--	self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
--	self:RegisterEvent("ZONE_CHANGED", "ZONE_CHANGED_NEW_AREA")
--	self:ZONE_CHANGED_NEW_AREA("OnEnable")

--Options & Slash command 
--	local AceConfigDialog = LibStub("AceConfigDialog-3.0")
--	LibStub("AceConfig-3.0"):RegisterOptionsTable(addonName, self.GetOptionsTable)
--	self:RegisterChatCommand("socd", function()
--		if self.QuestNameScanned then
--			if  AceConfigDialog.OpenFrames[addonName] then
--				AceConfigDialog:Close(addonName)
--			else
--				AceConfigDialog:Open(addonName)
--			end
--		else
--			print("|cff9933FFSickOfClickingDailies|r --", L["Still Setting up localizations please wait"])
--		end
--	end)

end

function addon:CacheQuestName(name, isDaily, isWeekly, isRepeatable)
	Debug("Caching QuestName", name, (isDaily and "d") or (isWeekly and "w") or (isRepeatable and "r") )
	if isDaily then
		db.global.questCache[name] = "d"
	elseif isWeekly then
		db.global.questCache[name] = "w"
	elseif isRepeatable then
		db.global.questCache[name] = "r"
	end
end

function addon:IsDailyQuest(name)
	Debug("API: IsDailyQuest:", name, db.global.questCache[name] == "d")
	return db.global.questCache[name] == "d"
end
function addon:IsWeeklyQuest(name)
	Debug("API: IsWeeklyQuest:", name, db.global.questCache[name] == "w")
	return db.global.questCache[name] == "w"
end
function addon:IsRepeatable(name)
	Debug("API: IsRepeatable:", name, db.global.questCache[name] == "r")
	return db.global.questCache[name] == "r"
end

function addon:IsDisabled(title)
	return false
end


--Shown when the NPC wants to talk..
local function procGetGossipAvailableQuests(index, title, _, _, isDaily, isRepeatable, ...)
	Debug("IttGossipAvail:", title, " ~IsDaily: ", isDaily and "true" or "false", "~IsRepeatable: ", isRepeatable and "true" or "false")
	if (index and title) and (isDaily or isRepeatable or addon:IsWeeklyQuest(title) ) then
		addon:CacheQuestName(title, isDaily, nil, isRepeatable)	--Only Cache Daily and Weekly Quests, this list will help with the LDB Tracker to filter out Repeatable Quests.
		if not addon:IsDisabled(title) then
			Debug("found:", title)
			return index, title
		elseif ... then
			Debug("indexing next quest")
			return procGetGossipAvailableQuests(index + 1, ...)
		else
			Debug("End of Quests")
			return
		end
	end
end


local function procGetGossipActiveQuests(index, title, _, _, isComplete, ...)
	Debug("IttGossipActive:", index, title, "~IsComplete:", isComplete, "~IsDaily:", addon:IsDailyQuest(title) or addon:IsWeeklyQuest(title))
	if (addon:IsDailyQuest(title) or addon:IsWeeklyQuest(title)) and isComplete then
		return index, title, isComplete
	elseif ... then
		return procGetGossipActiveQuests(index+1, ...)
	end
end

--local function proccessGossipOptions( ... )
--	for i = 1, select("#", ...), 2 do
--		local txt, tpe = select(i, ...)
--		if tpe == "gossip" then
--			if db.profile.GossipAutoSelect[txt] then
--				SelectGossipOption( i+1/2 )
--			end
--		end
--	end
--end

function addon:GOSSIP_SHOW(event)
	Debug(event)
	if IsShiftKeyDown() then return end

	local index, title = procGetGossipAvailableQuests(1, GetGossipAvailableQuests() )
	if index then
		Debug("Found Available, Quest:", title, "~IsDisabled:", self:IsDisabled(title) )
		return SelectGossipAvailableQuest(index)
	end

	local index, title, isComplete = procGetGossipActiveQuests(1, GetGossipActiveQuests() )
	if index then
		Debug("Found Active Quest that is Complete:", title, "~IsComplete:", isComplete, "~IsDisabled:", self:IsDisabled(title) )
		return SelectGossipActiveQuest(index)
	end

	--Debug("Proccessing Gossip ")
--	proccessGossipOptions( GetGossipOptions() )
end

--Shown when the NPC Dosn't want to talk
function addon:QUEST_GREETING(event, ...)
	Debug(event, ...)
	if IsShiftKeyDown() then return end
	local numActiveQuests = GetNumActiveQuests()
	local numAvailableQuests = GetNumAvailableQuests()
	Debug("Looking @ AvailableQuests")
	for i = 1, numAvailableQuests do
		local title, _, isDaily, isRepeatable = GetAvailableTitle(i), GetAvailableQuestInfo(i)
		if procGetGossipAvailableQuests(i, title, nil, nil, isDaily, isRepeatable) then
			return SelectAvailableQuest(i)
		end
	end
	for i = 1, numActiveQuests do
		local title, isComplete = GetActiveTitle(i)
		Debug("Quest:", title, "~isComplete:", isComplete, "~IsDisabled:", self:IsDisabled(title) )
		if procGetGossipActiveQuests(i, title, _, _, isComplete) then
			Debug("turning in quest:", title)
			return SelectActiveQuest(i)
		end
	end
end



--Shown to Accept Quest
function addon:QUEST_DETAIL(event, ...)
	local title = GetTitleText()
	Debug(event, title, ...)
	if IsShiftKeyDown() then return end
	Debug(event, title, "~IsDaily:", QuestIsDaily() and "true" or "false", "~QuestIsWeekly:", QuestIsWeekly() and "true" or "false", "~IsRepeatable:", addon:IsRepeatable(title) and "true" or "false" )
	if QuestIsDaily() or QuestIsWeekly() or addon:IsRepeatable(title) then
		addon:CacheQuestName(title, QuestIsDaily(), QuestIsWeekly() )
		if self:IsDisabled(title) then
			Debug("Ignoring Quest")
			return
		else
			Debug("Accepting Quest:", title)
			return AcceptQuest()
		end
	end
end

--Shown when Quest is being turned in
function addon:QUEST_PROGRESS(event, ...)
	Debug(event,...)
	local title = GetTitleText()
	Debug(event, title, "~IsCompleteable:", IsQuestCompletable(),"~IsDaily:", QuestIsDaily() and "true" or "false", "~QuestIsWeekly:", QuestIsWeekly() and "true" or "false", "~IsRepeatable:", addon:IsRepeatable(title) and "true" or "false" )
	if IsShiftKeyDown() then return end
	if not IsQuestCompletable() then return end
	if self:IsDisabled(title) then return end
	if ( QuestIsDaily() or QuestIsWeekly() or addon:IsRepeatable(title) ) then
		Debug("Completing Quest:", title)
		CompleteQuest()
	end
end

--Shown when Selecting reqward for quest.
function addon:QUEST_COMPLETE(event, ...)
	Debug(event,...)
	if IsShiftKeyDown() then return end
	local title = GetTitleText()
	if self:IsDisabled(title) then return end
	if QuestIsDaily() or QuestIsWeekly() or self:IsRepeatable(title) then
		Debug("Quest Enabled & Daily/Weekly/Repeatable")
		local rewardOpt = self:IsChoiceQuest(title)
			--Has quest option but we don't have a selection, means that this is a new quest that isn't in the DB.
		if (GetQuestItemInfo("choice", 1) ~= "") and (not rewardOpt) then
			if not self:IsRepeatable(title) then
				print(Debug("Sick Of Clicking Dailies: Found a new Quest:", title, " It has reward choices but is not yet added to the addon. Please report it at www.wowace.com"))
				return
			else
				return
			end
		end
		if (rewardOpt and (rewardOpt == -1)) then
			Debug(event, "Reward opt is -1, do nothing")
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

---Completion Hook :)
	function SOCD_GetQuestRewardHook(opt)
		local title = GetTitleText()
		Debug("GetQuestRewardHook, IsDaily:", addon:IsQuest(title) )
		if addon:IsRepeatable(title) then return end
		
		if addon:IsDailyQuest(title) then
			addon:SendMessage("SOCD_DAILIY_QUEST_COMPLETE", title, time()+GetQuestResetTime() )
		elseif addon:IsWeeklyQuest(title) then
			addon:SendMessage("SOCD_WEEKLY_QUEST_COMPLETE", title, addon:GetNextWeeklyReset() )
		end
	end
	hooksecurefunc("GetQuestReward", SOCD_GetQuestRewardHook )
	function SOCD_TestDailyEventSend(title)
		addon:SendMessage("SOCD_DAILIY_QUEST_COMPLETE", title or "TestQuest"..time(), 0)
	end
	
do		-- === Weekly Reset Function ===
		--Testing needed to make sure reset schedule is correct. On My Server in the US, first day of the week is on monday.
	local diff_to_next_wk_reset = GetCVar("realmList"):find("^eu%.") and { 
				-- Europe
		[7] = 3,	-- sunday
		[1] = 2,	-- monday
		[2] = 1,	-- tuesday
		[3] = 7,	-- wednesday *Reset Day
		[4] = 6,	-- thursday
		[5] = 5,	-- friday
		[6] = 4,	-- saturday
	} or { 		-- Rest of the world
		[7] = 2,	-- sunday
		[1] = 1,	-- monday
		[2] = 7,	-- tuesday *Reset Day
		[3] = 6,	-- wednesday
		[4] = 5,	-- thursday
		[5] = 4,	-- friday
		[6] = 3,	-- saturday
	}
	----End fix for ticket #72

	local diff = {}
	function addon:GetNextWeeklyReset()
		local cur_day, cur_month, cur_year, cur_wDay = tonumber(date("%d")), tonumber(date("%m")), tonumber(date("%Y")), tonumber(date("%w"))
		local monthNumDay = select(3, CalendarGetMonth(0))
		if (cur_wDay == 2) or ( (GetCVar("realmList"):find("^eu%.")) and (cur_wDay == 3) ) then	--If on Reset Day
			if cur_day == date("%d", time()+GetQuestResetTime() ) then	--and Next Quest Reset is on today
				return GetQuestResetTime()	-- Return Next Daily Reset because it will happen then regardless.
			end
		end
		for k, _ in pairs(diff) do diff[k] = nil end	--Clear our temp table time() only accepts a table for new stuff like this...
		
		local newDay = cur_day + diff_to_next_wk_reset[cur_wDay]	--Get next Day reset will happen on.
		if newDay > monthNumDay then	--if the next day is in next month
			newDay = newDay - monthNumDay	--Subtract the number of days in this month, we get the right day :)
			diff.day = newDay
			if cur_month +1 > 12 then	--If next reset next month is in the next year, then add a year and set month to 1
				diff.month = 1
				diff.year = cur_year + 1
			else
				diff.month = cur_month +1	--else just set to next month same year.
				diff.year = cur_year
			end
		else	--else if we're all in the same month then just set the values accordingly :)
			diff.day = newDay	
			diff.year = cur_year
			diff.month = cur_month
		end
		
		diff.hour = date("%H", time() + GetQuestResetTime())	--Rip the next Hour and Min of the reset from the API.
		diff.min = date("%M", time() + GetQuestResetTime())
		return time(diff)
	end
end