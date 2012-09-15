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
		self:Startup()
	end
end)
module:RegisterEvent("PLAYER_LOGIN")
module:RegisterEvent("ADDON_LOADED")

local questNameByID = {}
local questTypeByName = {}
local scannerStarted = false

--@debug@
function module:Debug(...)
	local str = string.join(", ", tostringall(...) )
	str = str:gsub("([:=>]),", "%1")
	str = str:gsub(", ([%-])", " %1")
	DEFAULT_CHAT_FRAME:AddMessage("SOCD-QS: "..str)
	return str
end
--@end-debug@

-- Builds the value for the SOCD_LocalizedQuestVersion saved variable.
-- Includes build version and change date of this file, so that the quests are rescanned after a
-- client patch or a change of this file.
local function GetCurrentLocalizedQuestVersion()
	local version, internalVersion = GetBuildInfo()
	return version.." "..internalVersion.." "..fileLastChanged
end

function module:Startup()
	-- Check the version of the saved localized quests
	if (not SOCD_LocalizedQuestDictionary) or (SOCD_LocalizedQuestVersion ~= GetCurrentLocalizedQuestVersion()) then
		-- Scan needed, don't enable the main addon until the scan has finished.
		self:StartQuestScan()
	else
		-- No scan needed, start the main addon now.
		questNameByID = SOCD_LocalizedQuestDictionary
		AddonParent:SendMessage("SOCD_FINISHED_QUEST_SCAN")
	end
end

local daily, weekly, repeatable = "d", "w", "r"

-- Only quests with reward options and ones which are disabled by default need to be scanned, the rest will be built as needed.
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
}

-- All selectable quest rewards need to be scanned.
-- Note: The tooltip for the items might show something like "requesting item information" if the
-- item isn't in the cache yet. This doesn't matter since the tooltip text of items isn't used.
-- We only need to set the tooltip so that the call to GetItemInfo later succeeds.
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
		--module:Debug("OnTooltipSetElement", self.k, self.v)
		
		if (not self.k) or (not self.v) then
			--module:Debug("Invalid Setup for SOCD Scanning")
			ttScanFrame:Hide()
		end
		
		if self.prefix == "quest:" then
			-- Scanning a quest. Get the title of it.
			local titleText = (ttlt:GetText() or ""):trim()

			questNameByID[ tonumber(self.k) ] = titleText
			questTypeByName[ titleText ] = self.v

			--module:Debug("Cached:", self.k, "-->", titleText)
		end

		self.count = self.count + 1

		local nextKey, nextValue = next(self.table, self.k)
		
		if (not nextKey) or (not nextValue) then
			--module:Debug("Reached end of Table. Total Scanned:", self.count)
			
			if self.nextFunc then
				--module:Debug("Calling nextFunc:", self.nextFunc)
				module[ self.nextFunc ](module)
			end
			
			return
		end
		
		self.k = nextKey
		self.v = nextValue
		--module:Debug("Showing scan frame")
		ttScanFrame:Show()
	end

	tt:SetScript("OnTooltipSetQuest", ScanTheTooltip)
	tt:SetScript("OnTooltipSetItem", ScanTheTooltip)

	local interval, currentDelay = .01, 0
	ttScanFrame:SetScript("OnUpdate", function(self, elapsed)
		--module:Debug("OnUpdate of SOCDQuestScanTT", currentDelay, elapsed, tt.questId)
		currentDelay = currentDelay + elapsed
		if currentDelay > interval then
			self:Hide()
			currentDelay = 0
			tt:SetHyperlink(tt.prefix..tt.k)
		end
	end)

end

function module:StartQuestScan()
	if scannerStarted then
		return
	end
	scannerStarted = true
	
	AddonParent:Print(L["QuestScanner started, Sick of Clicking Dailies can be used once it's finished."])
	
	-- Caution: Do not scan the items first! It seems like calling SetHyperlink() for a quest
	-- immediately after calling SetHyperlink() for an item doesn't work if the item isn't in the
	-- client cache yet.
	module:ScanQuestTooltips()
end

function module:StopScan(info)
	--module:Debug("Stopping Tooltip Scanning?")
	ttScanFrame:Hide()
end

function module:ScanQuestTooltips()
	--module:Debug("StartingTooltip Scan - QUESTS")
	local id, qtype = next(qTable)
	tt.table = qTable
	tt.k = id
	tt.v = qtype
	tt.count = 0
	tt.prefix = "quest:"
	tt.nextFunc = "ScanItemTooltips"
	
	--module:Debug("Setting first quest hyperlink", tt.prefix..tt.k)
	tt:SetHyperlink(tt.prefix..tt.k)
end

function module:ScanItemTooltips()
	--module:Debug("Starting Tooltip Scan - ITEMS")
	local id, name = next(iTable)
	tt.table = iTable
	tt.k = id
	tt.v = name
	tt.count = 0
	tt.prefix = "item:"
	tt.nextFunc = "SaveScannedQuestTitles"
	
	--module:Debug("Setting first item hyperlink", tt.prefix..tt.k)
	tt:SetHyperlink(tt.prefix..tt.k)
end


function module:SaveScannedQuestTitles()
	-- Save the scanned quest titles and update the saved version.
	SOCD_LocalizedQuestDictionary = questNameByID
	SOCD_LocalizedQuestVersion = GetCurrentLocalizedQuestVersion()
	
	AddonParent:SendMessage("SOCD_FINISHED_QUEST_SCAN")
	
	local questCache = AddonParent.db.global.questCache
	for k, v in pairs(questTypeByName) do
		questCache[k] = v
	end
	
	AddonParent:Print(L["QuestScanner finished, Sick of Clicking Dailies is now ready for use."])
end


function AddonParent.GetLocalizedQuestNameByID(self, id)
	if id then
		return questNameByID and questNameByID[id] or nil
	else
		id = tonumber(self)
		return questNameByID and questNameByID[id] or nil
	end
end
