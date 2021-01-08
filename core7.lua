--[[
Sick Of Clicking Dailies is a simple addon designed to pick up and turn in Dailiy Quests for WoW.

This version comes with a built in config system made with Ace3's Config GUI Libs.

@project-version@
@project-abbreviated-hash@

=====================================================================================================
 Copyright (c) 2010 by OrionShock

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


local LE_QUEST_FREQUENCY_DAILY=1
local LE_QUEST_FREQUENCY_DEFAULT=0
local LE_QUEST_FREQUENCY_WEEKLY=2

SOCD = LibStub("AceAddon-3.0"):NewAddon(addon, addonName, "AceEvent-3.0", "AceConsole-3.0")
addon.version = projectVersion.."-"..projectRevision

local db
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

--@debug@
local function Debug(...)
	local str = string.join(", ", tostringall(...) )
	str = str:gsub("([:=>]),", "%1")
	str = str:gsub(", ([%-])", " %1")
	DEFAULT_CHAT_FRAME:AddMessage("SOCD-Debug: "..str)
	return str
end
--@end-debug@

addon.db_defaults = {
	char = {},	--basically the char table is the quest log of dailies/weeklys completed.
	profile = {
			--status = {},
			enabledGossip = {},
		},
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
		questCache = {
			["Test Weekly Quest"] = "w",
			["Test Daily Quest"] = "d",
			["Test PvP Element"] = "p",
			["Test LFG Element"] = "l",
		},
	},
}

addon:SetDefaultModuleState(false)

function addon:OnInitialize()
	self:SetEnabledState(false)
	
	self:RegisterMessage("SOCD_FINISHED_QUEST_SCAN", function(event, ...) 
		addon:Enable()
		for k,v in addon:IterateModules() do
			v:Enable()
		end
	end )
end

function addon:OnEnable(event)
	self.db = LibStub("AceDB-3.0"):New("SOCD_DB", self.db_defaults, true)
	db = self.db
	
	hooksecurefunc("GetQuestReward", SOCD_GetQuestRewardHook )
	
	--Events
	self:RegisterEvent("GOSSIP_SHOW")
	self:RegisterEvent("QUEST_GREETING")
	self:RegisterEvent("QUEST_DETAIL")
	self:RegisterEvent("QUEST_PROGRESS")
	self:RegisterEvent("QUEST_COMPLETE")

--Options & Slash command 
	local AceConfigDialog = LibStub("AceConfigDialog-3.0")
	LibStub("AceConfig-3.0"):RegisterOptionsTable(addonName, self.GetOptionsTable)
	self:RegisterChatCommand("socd", function()
		if  AceConfigDialog.OpenFrames[addonName] then
			AceConfigDialog:Close(addonName)
		else
			AceConfigDialog:Open(addonName)
		end
	end)

end

function addon:CacheQuestName(name, isDaily, isWeekly, isRepeatable)
	--Debug("Caching QuestName", name, (isDaily and "d") or (isWeekly and "w") or (isRepeatable and "r") )
	if not name then return end
	if isDaily then
		db.global.questCache[name] = "d"
	elseif isWeekly then
		db.global.questCache[name] = "w"
	elseif isRepeatable then
		db.global.questCache[name] = "r"
	end
end

function addon:IsDailyQuest(name)
	--Debug("API: IsDailyQuest:", name, db.global.questCache[name] == "d")
	return db.global.questCache[name] == "d"
end
function addon:IsWeeklyQuest(name)
	--Debug("API: IsWeeklyQuest:", name, db.global.questCache[name] == "w")
	return db.global.questCache[name] == "w"
end
function addon:IsRepeatable(name)
	--Debug("API: IsRepeatable:", name, db.global.questCache[name] == "r")
	return db.global.questCache[name] == "r"
end

function addon:IsDisabled(title)
	return db.profile.status[title] == false
end


--Shown when the NPC wants to talk..
local function procGetGossipAvailableQuests(index, title, level, isTrivial, frequency, isRepeatable, isLegendary, ...)
	local isDaily = frequency == LE_QUEST_FREQUENCY_DAILY
	local isWeekly = frequency == LE_QUEST_FREQUENCY_WEEKLY
	--Debug("IttGossipAvail:", index, title, "~Frequency", frequency, "~IsDaily:", isDaily, "~IsWeekly:", isWeekly, "~IsRepeatable:", isRepeatable)
	if (index and title) and (isDaily or isWeekly or isRepeatable or addon:SpecialFixQuest(GetQuestID())) then
		addon:CacheQuestName(title, isDaily, isWeekly, isRepeatable)	--Only Cache Daily and Weekly Quests, this list will help with the LDB Tracker to filter out Repeatable Quests.
		if not addon:IsDisabled(title) then
			--Debug("found:", title)
			return index, title
		end
	end
	if ... then
		--Debug("indexing next quest")
		return procGetGossipAvailableQuests(index + 1, ...)
	else
		--Debug("End of Quests")
		return
	end
end


local function procGetGossipActiveQuests(index, title, level, isTrivial, isComplete, isLegendary, ...)
	--Debug("IttGossipActive:", index, title, "~IsComplete:", isComplete, "~IsDaily:", addon:IsDailyQuest(title), "~IsWeekly:", addon:IsWeeklyQuest(title))
	if (index and title) and (addon:IsDailyQuest(title) or addon:IsWeeklyQuest(title) or addon:SpecialFixQuest(GetQuestID())) and isComplete then
		return index, title, isComplete
	elseif ... then
		return procGetGossipActiveQuests(index + 1, ...)
	end
end

local function scanQuestsAvailable(title, level, isTrivial, frequency, isRepeatable, isLegendary, ...)
	local isDaily = frequency == LE_QUEST_FREQUENCY_DAILY
	local isWeekly = frequency == LE_QUEST_FREQUENCY_WEEKLY
	--Debug("scanQuestsAvailable:", title, "~Frequency", frequency, "~IsDaily:", isDaily, "~IsWeekly:", isWeekly, "~IsRepeatable:", isRepeatable)
	if title and (isDaily or isWeekly or isRepeatable) then
		addon:CacheQuestName(title, isDaily, isWeekly, isRepeatable)	--Only Cache Daily and Weekly Quests, this list will help with the LDB Tracker to filter out Repeatable Quests.
	else
		return
	end
	return scanQuestsAvailable(...)
end

local function proccessGossipOptions( )
	local options = C_GossipInfo.GetOptions()

	for i = 1, table.getn(options) do
		local GossipOptionUIInfo = options[i]
		--print(GossipOptionUIInfo.type)
		if GossipOptionUIInfo.type == "gossip" then
			--print(GossipOptionUIInfo.name)
			if db.profile.enabledGossip[GossipOptionUIInfo.name] then
				--Debug("Found gossip we should click:", GossipOptionUIInfo.name)
				C_GossipInfo.SelectOption( (i+1)/2 )
			end
		end
	end
end


--These functions are really hacky, but much easier then refactoring the functions the datas used to feed into
local function unpackGetAvailableQuests(GossipQuestUIInfo)

	local tabl = {}
	local avail =  GossipQuestUIInfo;
	for i = 1, #avail do
		table.insert(tabl,avail[i].title)
		table.insert(tabl,avail[i].questLevel)
		table.insert(tabl,avail[i].isTrivial)
		table.insert(tabl,avail[i].frequency)
		table.insert(tabl,avail[i].repeatable)
		table.insert(tabl,avail[i].isLegendary)
	end

	return unpack(tabl)
end

local function unpackGetActiveQuests(GossipQuestUIInfo)

	local tabl = {}
	local avail =  GossipQuestUIInfo;
	for i = 1, #avail do
		table.insert(tabl,avail[i].title)
		table.insert(tabl,avail[i].questLevel)
		table.insert(tabl,avail[i].isTrivial)
		table.insert(tabl,avail[i].isComplete)
		table.insert(tabl,avail[i].isLegendary)
	end

	return unpack(tabl)
end

function addon:GOSSIP_SHOW(event)
	--Debug(event)
	

	
	local Nindex, Ntitle = procGetGossipAvailableQuests(1, unpackGetAvailableQuests(C_GossipInfo.GetAvailableQuests()) )
	local Aindex, Atitle, AisComplete = procGetGossipActiveQuests(1, unpackGetActiveQuests(C_GossipInfo.GetActiveQuests()) )
	
	if IsShiftKeyDown() then 
		scanQuestsAvailable(C_GossipInfo.GetAvailableQuests())
		return
	end
	if Nindex then
		--Debug("Found Available, Quest:", Ntitle, "~IsDisabled:", self:IsDisabled(Ntitle) )
		return C_GossipInfo.SelectAvailableQuest(Nindex)
	end


	if Aindex then
		--Debug("Found Active Quest that is Complete:", Atitle, "~IsComplete:", AisComplete, "~IsDisabled:", self:IsDisabled(Atitle) )
		return C_GossipInfo.SelectActiveQuest(Aindex)
	end

	--Debug("Proccessing Gossip ")
	proccessGossipOptions( )
end

--Shown when the NPC Dosn't want to talk
function addon:QUEST_GREETING(event, ...)
	--Debug(event, ...)
	local numActiveQuests = GetNumActiveQuests()
	local numAvailableQuests = GetNumAvailableQuests()
	--Debug("Looking @ AvailableQuests")
	for i = 1, numAvailableQuests do
		local title = GetAvailableTitle(i)
		local isTrivial, frequency, isRepeatable, isLegendary = GetAvailableQuestInfo(i)
		if procGetGossipAvailableQuests(i, title, nil, isTrivial, frequency, isRepeatable, isLegendary) then
			if not IsShiftKeyDown() then
				return SelectAvailableQuest(i)
			end
		end
	end
	for i = 1, numActiveQuests do
		local title, isComplete = GetActiveTitle(i)
		--Debug("Quest:", title, "~isComplete:", isComplete, "~IsDisabled:", self:IsDisabled(title) )
		if procGetGossipActiveQuests(i, title, nil, nil, isComplete) then
			--Debug("turning in quest:", title)
			if not IsShiftKeyDown() then
				return SelectActiveQuest(i)
			end
		end
	end
end



--Shown to Accept Quest
function addon:QUEST_DETAIL(event, ...)
	local title = GetTitleText()
	--Debug(event, title, "~IsDaily:", QuestIsDaily() and "true" or "false", "~QuestIsWeekly:", QuestIsWeekly() and "true" or "false", "~IsRepeatable:", addon:IsRepeatable(title) and "true" or "false" )
	if QuestIsDaily() or QuestIsWeekly() or addon:IsRepeatable(title) or addon:SpecialFixQuest( GetQuestID() ) then
		addon:CacheQuestName(title, QuestIsDaily(), QuestIsWeekly() )
		if IsShiftKeyDown() then return end
		if self:IsDisabled(title) then
			--Debug("Ignoring Quest")
			return
		else
			--Debug("Accepting Quest:", title)
			return AcceptQuest()
		end
	end
end

--Shown when Quest is being turned in
function addon:QUEST_PROGRESS(event, ...)
	--Debug(event,...)
	local title = GetTitleText()
	--Debug(event, title, "~IsCompleteable:", IsQuestCompletable(),"~IsDaily:", QuestIsDaily() and "true" or "false", "~QuestIsWeekly:", QuestIsWeekly() and "true" or "false", "~IsRepeatable:", addon:IsRepeatable(title) and "true" or "false" )
	if IsShiftKeyDown() then return end
	if not IsQuestCompletable() then return end
	if self:IsDisabled(title) then return end
	if ( QuestIsDaily() or QuestIsWeekly() or addon:IsRepeatable(title) or addon:SpecialFixQuest( GetQuestID() ) ) then
		self:CacheQuestName(title, QuestIsDaily(), QuestIsWeekly() )
		--Debug("Completing Quest:", title)
		CompleteQuest()
	end
end

--Shown when Selecting reqward for quest.
function addon:QUEST_COMPLETE(event, ...)
	--Debug(event, ...)
	if IsShiftKeyDown() then return end
	local title = GetTitleText()
	if self:IsDisabled(title) then return end
	
	if QuestIsDaily() or QuestIsWeekly() or self:IsRepeatable(title) or addon:SpecialFixQuest(GetQuestID()) then
		--Debug(event, "Quest Enabled & Daily/Weekly/Repeatable")
		local numQuestChoices = GetNumQuestChoices()
		--Debug(event, "NumQuestChoices:", numQuestChoices)
		local userChosenReward = self:IsChoiceQuest(title)
		
		if numQuestChoices > 1 then
			if not userChosenReward then
				--Has quest option but we don't have a selection, means that this is a new quest that isn't in the DB.
				if not self:IsRepeatable(title) then
					self:Print(L["Found a new Quest:"].." "..title)
					self:Print(L["It has reward choices but is not yet added to the addon. Please report it at http://www.wowace.com/addons/sick-of-clicking-dailies/tickets/"])
				end
				return
			end
		
			if userChosenReward == -1 then
				--Debug(event, "userChosenReward is -1, do nothing")
				return
			end
			
			--Debug(event, "Getting userChosenReward, index:", userChosenReward, "item:", (GetQuestItemInfo("choice", userChosenReward)))
			GetQuestReward(userChosenReward)
			return
		end
		
		if numQuestChoices == 1 then
			--Debug(event, "Getting only possible Reward:", (GetQuestItemInfo("choice", 1)))
			GetQuestReward(1)
			return
		end
		
		--Debug(event, "Getting Money!")
		GetQuestReward()
		return
	end
end

---Completion Hook :)
	function SOCD_GetQuestRewardHook(opt, forceName)
		local title = forceName or GetTitleText()
		--Debug("GetQuestRewardHook, IsDaily:", addon:IsDailyQuest(title), "~IsWeekly:", addon:IsWeeklyQuest(title), "~IsRepeatable:",  addon:IsRepeatable(title))
		if addon:IsRepeatable(title) then
			--Debug("QuestIsRepeatable, not pushing Events")
			return
		end
		
		if addon:IsDailyQuest(title) then
			--Debug("Quest Was Daily, Pushing Event::", "SOCD_DAILIY_QUEST_COMPLETE", title, (time()+GetQuestResetTime()) - ( (time()+GetQuestResetTime()) % 60 ) )
			addon:SendMessage("SOCD_DAILIY_QUEST_COMPLETE", title, (time()+GetQuestResetTime()) - ( (time()+GetQuestResetTime()) % 60 ) )
		elseif addon:IsWeeklyQuest(title) then
			--Debug("Quest Was Weekly, Pushing Event::", "SOCD_WEEKLY_QUEST_COMPLETE", title, addon:GetNextWeeklyReset() )
			addon:SendMessage("SOCD_WEEKLY_QUEST_COMPLETE", title, addon:GetNextWeeklyReset() )
		end
	end
	
	-- function SOCD_TestDailyEventSend()
		--Debug("Firing Test Events")
		-- SOCD_GetQuestRewardHook(opt, "Test Daily Quest")
		-- SOCD_GetQuestRewardHook(opt, "Test Weekly Quest")
	-- end
	
do		-- === Weekly Reset Function ===
		--Testing needed to make sure reset schedule is correct. On My Server in the US, first day of the week is on monday.
	local is_eu = GetCVar("portal"):lower() == "eu"
	local diff_to_next_wk_reset = is_eu and { 
				-- Europe
		[0] = 3,	-- sunday
		[1] = 2,	-- monday
		[2] = 1,	-- tuesday
		[3] = 7,	-- wednesday *Reset Day
		[4] = 6,	-- thursday
		[5] = 5,	-- friday
		[6] = 4,	-- saturday
	} or { 		-- Rest of the world
		[0] = 2,	-- sunday
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
		local monthInfo = C_Calendar.GetMonthInfo(0)
		local monthNumDay = monthInfo.numDays
		if (cur_wDay == 2) or ( is_eu and (cur_wDay == 3) ) then	--If on Reset Day
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
		diff.min = date("%M", time() + GetQuestResetTime())		-- will eventually use (time()+GetQuestResetTime()) - ( (time()+GetQuestResetTime()) % 60 ) if needed.
		return time(diff)
	end
end