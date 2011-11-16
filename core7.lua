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
--	return str
end


function addon:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("SOCD_DB", {}, true)
	db = self.db

end

function addon:OnEnable(event, addon)
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

--Shown when the NPC wants to talk..
local function procGetGossipAvailableQuests(index, title, _, _, isDaily, isRepeatable, ...)
	Debug("procGetGossipAvailableQuests", title, " ~IsDaily: ", isDaily and "true" or "false", "~IsRepeatable: ", isRepeatable and "true" or "false")
	if index and title and (isDaily or isRepeatable) then
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
	if  addon:IsQuest(title) and isComplete then
		return index, title
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

--	local index, title = procGetGossipActiveQuests(1, GetGossipActiveQuests() )
--	if index then
		--Debug("Found Active Quest that is Complete:", title, "~IsComplete:", isComplete, "~ShouldIgnore:", self:ShouldIgnoreQuest(title) )
--		return SelectGossipActiveQuest(index)
--	end

	--Debug("Proccessing Gossip ")
--	proccessGossipOptions( GetGossipOptions() )
end

--Shown when the NPC Dosn't want to talk
function addon:QUEST_GREETING(event, ...)
	Debug(event,...)
	if IsShiftKeyDown() then return end
end



--Shown to Accept Quest
function addon:QUEST_DETAIL(event, ...)
	local title = GetTitleText()
	Debug(event, title, ...)
	if IsShiftKeyDown() then return end
	Debug(event, title, "~IsDaily:", QuestIsDaily() and "true" or "false", "~QuestIsWeekly:", QuestIsWeekly() and "true" or "false")
	if QuestIsDaily() or QuestIsWeekly() then
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
	if IsShiftKeyDown() then return end
end

--Shown when Selecting reqward for quest.
function addon:QUEST_COMPLETE(event, ...)
	Debug(event,...)
	if IsShiftKeyDown() then return end
end

function addon:IsDisabled(title)
	return false
end