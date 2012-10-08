--[[
	Sick Of Clicking Dailies? - Quest Scanner
	Written By: OrionShock
	
	This file makes sure that all needed localized quest titles are available before the main addon
	is enabled. Quest titles are scanned from tooltips.
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
		self:ScanQuestTooltips()
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
	[12689] = daily,	--"Hand of the Oracles" --Disabled by request of "Fisker-" in IRC, these 2 quests switch faction
	[12582] = daily,	--"Frenzyheart Champion" --Disabled by request of "Fisker-" in IRC, these 2 quests switch faction
	[13846] = daily,	-- "Contributin' To The Cause" --AC gold for rep quest
	
	--== Mists of Pandaria ==--
	--The Tillers
	--Non-ideal Blue Feather gifts
	[30382] = repeatable,	--"A Blue Feather for Ella"
	[30419] = repeatable,	--"A Blue Feather for Farmer Fung"
	[30425] = repeatable,	--"A Blue Feather for Fish"
	[30388] = repeatable,	--"A Blue Feather for Gina"
	[30412] = repeatable,	--"A Blue Feather for Haohan"
	[30437] = repeatable,	--"A Blue Feather for Jogu"
	[30406] = repeatable,	--"A Blue Feather for Sho"
	[30431] = repeatable,	--"A Blue Feather for Tina"
	--Non-ideal Jade Cat gifts
	[30399] = repeatable,	--"A Jade Cat for Chee Chee"
	[30418] = repeatable,	--"A Jade Cat for Farmer Fung"
	[30387] = repeatable,	--"A Jade Cat for Gina"
	[30411] = repeatable,	--"A Jade Cat for Haohan"
	[30436] = repeatable,	--"A Jade Cat for Jogu"
	[30393] = repeatable,	--"A Jade Cat for Old Hillpaw"
	[30405] = repeatable,	--"A Jade Cat for Sho"
	[30430] = repeatable,	--"A Jade Cat for Tina"
	--Non-ideal Lovely Apple gifts
	[30398] = repeatable,	--"A Lovely Apple for Chee Chee"
	[30189] = repeatable,	--"A Lovely Apple for Ella"
	[30417] = repeatable,	--"A Lovely Apple for Farmer Fung"
	[30423] = repeatable,	--"A Lovely Apple for Fish"
	[30380] = repeatable,	--"A Lovely Apple for Gina"
	[30410] = repeatable,	--"A Lovely Apple for Haohan"
	[30392] = repeatable,	--"A Lovely Apple for Old Hillpaw"
	[30429] = repeatable,	--"A Lovely Apple for Tina"
	--Non-ideal Ruby Shard gifts
	[30397] = repeatable,	--"A Ruby Shard for Chee Chee"
	[30160] = repeatable,	--"A Ruby Shard for Ella"
	[30416] = repeatable,	--"A Ruby Shard for Farmer Fung"
	[30422] = repeatable,	--"A Ruby Shard for Fish"
	[30379] = repeatable,	--"A Ruby Shard for Gina"
	[30434] = repeatable,	--"A Ruby Shard for Jogu"
	[30391] = repeatable,	--"A Ruby Shard for Old Hillpaw"
	[30403] = repeatable,	--"A Ruby Shard for Sho"
	--Non-ideal Marsh Lily gifts
	[30401] = repeatable,	--"A Marsh Lily for Chee Chee"
	[30383] = repeatable,	--"A Marsh Lily for Ella"
	[30426] = repeatable,	--"A Marsh Lily for Fish"
	[30413] = repeatable,	--"A Marsh Lily for Haohan"
	[30438] = repeatable,	--"A Marsh Lily for Jogu"
	[30395] = repeatable,	--"A Marsh Lily for Old Hillpaw"
	[30407] = repeatable,	--"A Marsh Lily for Sho"
	[30432] = repeatable,	--"A Marsh Lily for Tina"
}


local tt = CreateFrame("GameTooltip", "SOCDQuestScanTT", UIParent, "GameTooltipTemplate")
local ttlt = _G[tt:GetName().."TextLeft1"]
local ttScanFrame = CreateFrame("frame")
ttScanFrame:Hide()
do
	local function ScanTheTooltip(self, ...)
		--module:Debug("OnTooltipSetQuest", self.k)
		
		if (not self.k) or (not self.v) then
			--module:Debug("Invalid Setup for SOCD Scanning")
			ttScanFrame:Hide()
		end
		
		local titleText = (ttlt:GetText() or ""):trim()

		questNameByID[ tonumber(self.k) ] = titleText
		questTypeByName[ titleText ] = self.v

		--module:Debug("Cached:", self.k, "-->", titleText)

		self.count = self.count + 1

		local nextKey, nextValue = next(self.table, self.k)
		
		if (not nextKey) or (not nextValue) then
			--module:Debug("Reached end of Table. Total Scanned:", self.count)
			module:SaveScannedQuestTitles()
			return
		end
		
		self.k = nextKey
		self.v = nextValue
		--module:Debug("Showing scan frame")
		ttScanFrame:Show()
	end

	tt:SetScript("OnTooltipSetQuest", ScanTheTooltip)

	local interval, currentDelay = .01, 0
	ttScanFrame:SetScript("OnUpdate", function(self, elapsed)
		--module:Debug("OnUpdate of SOCDQuestScanTT", currentDelay, elapsed, tt.questId)
		currentDelay = currentDelay + elapsed
		if currentDelay > interval then
			self:Hide()
			currentDelay = 0
			tt:SetHyperlink("quest:"..tt.k)
		end
	end)

end

function module:ScanQuestTooltips()
	if scannerStarted then return end
	scannerStarted = true
	
	AddonParent:Print(L["QuestScanner started, Sick of Clicking Dailies can be used once it's finished."])
	
	local id, qtype = next(qTable)
	tt.table = qTable
	tt.k = id
	tt.v = qtype
	tt.count = 0
	
	--module:Debug("Setting first quest hyperlink")
	tt:SetHyperlink("quest:"..tt.k)
end

function module:StopScan(info)
	--module:Debug("Stopping Tooltip Scanning?")
	ttScanFrame:Hide()
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
