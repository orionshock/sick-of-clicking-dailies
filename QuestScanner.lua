--[[
	Sick Of Clicking Dailies? - Quest Scanner
	Written By: OrionShock
]]--

local projectVersion = "@project-version@"
local projectRevision = "@project-abbreviated-hash@"
if projectVersion:find("project") then
	projectVersion = "git"
	projectRevision = "dev"
end

local fileLastChanged = "@file-date-integer@"

local AddonName, AddonParent = ...
local L = LibStub("AceLocale-3.0"):GetLocale(AddonName)
local module = CreateFrame("frame")

module:SetScript("OnEvent", function(self, event, ...)
	if IsLoggedIn() then
		self:UnregisterEvent("PLAYER_LOGIN")
		self:UnregisterEvent("ADDON_LOADED")
		self:PLAYER_LOGIN("Good Morning!")
	end
end)
module:RegisterEvent("PLAYER_LOGIN")
module:RegisterEvent("ADDON_LOADED")

local localeQuestNameByID
local scannerStarted = false


--function module:Debug(...)
--	local str = string.join(", ", tostringall(...) )
--	str = str:gsub("([:=>]),", "%1")
--	str = str:gsub(", ([%-])", " %1")
--	DEFAULT_CHAT_FRAME:AddMessage("SOCD-QS: "..str)
--	return str
--end

-- Builds the value for the SOCD_LocalizedQuestVersion saved variable.
-- Includes build version and change date of this file, so the quests are rescanned after a
-- client patch or a change of this file.
local function GetCurrentLocalizedQuestVersion()
	version, internalVersion = GetBuildInfo()
	return version.." "..internalVersion.." "..fileLastChanged
end

function module:PLAYER_LOGIN(event,...)
	SOCD_LocalizedQuestDictionary = SOCD_LocalizedQuestDictionary or {}	--Prime the Global Varg
	localeQuestNameByID = SOCD_LocalizedQuestDictionary	--Make global Varg local...
	if SOCD_LocalizedQuestVersion ~= GetCurrentLocalizedQuestVersion() then	--check version
		return self:StartQuestScan()
	else
		AddonParent:SendMessage("SOCD_FINISH_QUEST_SCAN")
	end
end

local daily, weekly, repeatable = "d", "w", "r"
	--Ony quests with reward options and ones which are disabled by default need to be scanned, the rest will be built as needed.
local qTable = {
		--== Burning Crusade ==--
		[11545] = daily,	--"A Charitable Donation" --Gold for rep quest
		[11548] = daily,	--"Your Continued Support" --Gold for rep quest
		[11379] = daily,	--"Super Hot Stew"
		[11381] = daily,	--"Soup for the Soul"
		[11377] = daily,	--"Revenge is Tasty"
		[11380] = daily,	--"Manalicious"
		[11515] = daily,	--"Blood for Blood"
		[11544] = daily,	--"Ata'mal Armaments"
		
		--== Wrath of the Lich King ==--
		--Argent Tourny
		[13789] = daily,	--"Taking Battle To The Enemy"
		[13861] = daily,	--"Battle Before The Citadel"
		[13682] = daily,	--"Threat From Above"
		[13790] = daily,	--"Among the Champions"
		
		--Thx Holliday
		[14061] = daily,	--"Can't Get Enough Turkey"
		[14062] = daily,	--"Don't Forget The Stuffing!"
		[14060] = daily,	--"Easy As Pie",
		[14058] = daily,	--"She Says Potato"
		[14059] = daily,	--"We're Out of Cranberry Chutney Again?"
		
		--Misc disabled Quests
		[12689] = daily,	--"Hand of the Oracles"	--Disabled by request of "Fisker-" in IRC, these 2 quests switch faction
		[12582] = daily,	--"Frenzyheart Champion"	--Disabled by request of "Fisker-" in IRC, these 2 quests switch faction
		[13846] = daily,	-- "Contributin' To The Cause"	--AC gold for rep quest
}	--End of name Scanner Master Table

local iTable = {
	--BC
	[30809] = "Mark of Sargeras",
	[30810] = "Sunfury Signet",
	[34538] = "Blessed Weapon Coating",
	[34539] = "Righteous Weapon Coating",
	[33844] = "Barrel of Fish",
	[33857] = "Crate of Meat",
	--Wrath
	[46114] = "Champion's Writ",
	[45724] = "Champion's Purse",
	--Thx Holliday
	[46723] = "Pilgrim's Hat",
	[46800] = "Pilgrim's Attire",
	[44785] = "Pilgrim's Dress",
	[46824] = "Pilgrim's Robe",
	[44788] = "Pilgrim's Boots",
	[44812] = "Turkey Shooter",
}


local tt = CreateFrame("GameTooltip", "SOCDQuestScanTT", UIParent, "GameTooltipTemplate")
local ttlt = _G[tt:GetName().."TextLeft1"]
local ttScanFrame = CreateFrame("frame")
ttScanFrame:Hide()
do
		local function ScanTheTooltip(self, ...)
		--module:Debug("OnTooltipSetElement", self.k)
		if (not self.k) or (not self.v) then
			--module:Debug("Invalid Setup for SOCD Scanning")
			ttScanFrame:Hide()
		end
		local titleText = (ttlt:GetText() or ""):trim()

		if tt.dba then
			tt.dba[ tonumber(self.k) ] = titleText
		end
		if tt.dbb then
			tt.dbb[ titleText ] = tt.v
		end

		self.count = self.count + 1

		--module:Debug("Cached:", self.k, "-->", titleText )

		local id, qtype = next(self.t, self.k)
		if not id or not qtype then
			--module:Debug("Reached end of Table. Total Scanned:", self.count)
			if self.finishfunc then
				self.finishfunc()
			end
			if self.NextScanFunc then
				return module[ self.NextScanFunc ](module)
			end
			return
		end
		self.k = id
		self.v = qtype
		--module:Debug("Showing scan frame:")
		ttScanFrame:Show()
		return
	end

	tt:SetScript("OnTooltipSetQuest", ScanTheTooltip)
	tt:SetScript("OnTooltipSetItem", ScanTheTooltip)

	local interval, delay = .01, 0
	ttScanFrame:SetScript("OnUpdate", function(self, elapsed)
		--module:Debug("OnUpdate", delay, elapsed, tt.questId)
		delay = delay + elapsed
		if delay > interval then
			delay = 0
			self:Hide()
			return tt:SetHyperlink(tt.prefix..tt.k)
		end
	end)

end

function module:StartQuestScan()
	if scannerStarted then
		return
	end
	scannerStarted = true
	
	AddonParent:Print(L["QuestScanner started, Sick of Clicking Dailies can be used once it's finished."])
	
	module:ScanItemTooltips()
end

function module:StopScan(info)
	--self:Debug("Stopping Tooltip Scanning?")
	ttScanFrame:Hide()
end

function module:ScanItemTooltips()
	--self:Debug("Starting Tooltip Scan - ITEMS")
	local id, name = next(iTable)
	tt.t = iTable
	tt.k = id
	tt.v = qtype
	tt.dba = nil
	tt.dbb = nil
	tt.count = 0
	tt.prefix = "item:"
	tt.NextScanFunc = "ScanQuestTooltips"
	tt.finishfunc = nil
	return tt:SetHyperlink(tt.prefix..tt.k)
end

function module:ScanQuestTooltips()
	--self:Debug("StartingTooltip Scan - QUEST")
	local id, qtype = next(qTable)
	tt.t = qTable
	tt.k = id
	tt.v = qtype
	tt.dba = localeQuestNameByID
	tt.dbb = {}
	tt.count = 0
	tt.prefix = "quest:"
	tt.NextScanFunc = nil
	tt.finishfunc = function()
			SOCD_LocalizedQuestVersion = GetCurrentLocalizedQuestVersion()
			AddonParent:SendMessage("SOCD_FINISH_QUEST_SCAN")
			local questCache = AddonParent.db.global.questCache
			for k,v in pairs(tt.dbb) do
				questCache[k] = v
			end
			AddonParent:Print(L["QuestScanner finished, Sick of Clicking Dailies is now ready for use."])
		end
	return tt:SetHyperlink(tt.prefix..tt.k)
end



function AddonParent.GetLocalizedQuestNameByID(self, id)
	if id then
		return localeQuestNameByID and localeQuestNameByID[id] or nil
	else
		id = tonumber(self)
		return localeQuestNameByID and localeQuestNameByID[id] or nil
	end
end
