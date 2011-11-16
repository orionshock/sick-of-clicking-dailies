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


LibStub("AceAddon-3.0"):NewAddon(addon, addonName, "AceEvent-3.0", "AceConsole-3.0")
addon.version = projectVersion.."-"..projectRevision

local db
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local function Debug(...)
	local str = string.join(", ", tostringall(...) )
	str = str:gsub("([:=>]),", "%1")
	str = str:gsub(", ([%-])", " %1")
	if db and db.global.debug.core then
		print("SOCD-Debug-Core: ", str)
	end
	return str
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


function addon:GOSSIP_SHOW(event, ...)
end

function addon:QUEST_GREETING(event, ...)
end

function addon:QUEST_DETAIL(event, ...)
end

function addon:QUEST_PROGRESS(event, ...)
end

function addon:QUEST_COMPLETE(event, ...)
end