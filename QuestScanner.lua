--[[
 

]]

local projectVersion = "@project-version@"
local projectRevision = "@project-abbreviated-hash@"
if projectVersion:find("project") then
	projectVersion = "git"
	projectRevision = "dev"
end

local lastChanged = "@file-date-integer@"

local AddonName, AddonParent = ...
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


--function module:Debug(...)
--	local str = string.join(", ", tostringall(...) )
--	str = str:gsub("([:=>]),", "%1")
--	str = str:gsub(", ([%-])", " %1")
--	ChatFrame5:AddMessage("SOCD-QS: "..str)
--	return str
--end

function module:PLAYER_LOGIN(event,...)
	LocalizedQuestDictionary = LocalizedQuestDictionary or {}	--Prime the Global Varg
	localeQuestNameByID = LocalizedQuestDictionary	--Make global Varg local...
	if LocalizedQuestVersion ~= lastChanged then	--check version
		return self:StartQuestScan()
	else
		AddonParent:SendMessage("SOCD_FINISH_QUEST_SCAN")
		AddonParent.QuestNameScanned = true
	end
end

local daily, weekly, repeatable = "d", "w", "r"
	--In Effect only Weekly quests and ones with reward options need to be scanned, the rest will be built as needed.
local qTable = {
		--== Classic ==--
		--== Burrning Crusade ==--
		[11545] = daily,	--"A Charitable Donation"
		[11548] = daily,	--"Your Continued Support"
		[11379] = daily, --SuperHotStew
		[11381] = daily, --SoupForTheSoul
		[11377] = daily, --RevengeIsTasty
		[11380] = daily, --Manalicious
		[11515] = daily, --BloodForBlood
		[11544] = daily, --AtamalArmaments
		--== Wrath Of the Lich King ==--
		--WG Weekly Quests
		[13195] = weekly,	--"A Rare Herb"
		[13199] = weekly,	--"Bones and Arrows"
		[13222] = weekly,	--"Defend the Siege"
		[13191] = weekly,	--"Fueling the Demolishers"
		[13201] = weekly,	--"Healing with Roses"
		[13202] = weekly,	--"Jinxing the Walls"
		[13177] = weekly,	--"No Mercy for the Merciless"
		[13178] = weekly,	--"Slay them all!"
		[13186] = weekly,	--"Stop the Siege"
		[13181] = weekly,	--"Victory in Wintergrasp"
		[13192] = weekly,	--"Warding the Walls"
		[13198] = weekly,	--"Warding the Warriors"
		[13538] = weekly,	--"Southern Sabotage"
		[13539] = weekly,	--"Toppling the Towers"

		--Raid Weekly Quests
		[24580] = weekly,	--"Anub'Rekhan Must Die!"
		[24585] = weekly,	--"Flame Leviathan Must Die!"
		[24587] = weekly,	--"Ignis the Furnace Master Must Die!"
		[24582] = weekly,	--"Instructor Razuvious Must Die!"
		[24589] = weekly,	--"Lord Jaraxxus Must Die!"
		[24590] = weekly,	--"Lord Marrowgar Must Die!"
		[24584] = weekly,	--"Malygos Must Die!"
		[24581] = weekly,	--"Noth the Plaguebringer Must Die!"
		[24583] = weekly,	--"Patchwerk Must Die!"
		[24586] = weekly,	--"Razorscale Must Die!"
		[24579] = weekly,	--"Sartharion Must Die!"
		[24588] = weekly,	--"XT-002 Deconstructor Must Die!"

		--ICC Weekly Quests
		[24879] = weekly,	--"Blood Quickening"
		[24875] = weekly,	--"Deprogramming"
		[24878] = weekly,	--"Residue Rendezvous"
		[24880] = weekly,	--"Respite for a Tormented Soul"
		[24877] = weekly,	--"Securing the Ramparts"
		
		--Argent Tourny
		[13789] = daily, --"Taking Battle To The Enemy"
		[13861] = daily, --"Battle Before The Citadel"
		[13682] = daily, --"Threat From Above"
		[13790] = daily, --"Among the Champions"
		--Thx Holliday
		[14061] = daily,	--"Can't Get Enough Turkey"
		[14062] = daily,	--"Don't Forget The Stuffing!"
		[14060] = daily,	--"Easy As Pie",
		[14058] = daily,	--"She Says Potato"
		[14059] = daily,	--"We're Out of Cranberry Chutney Again?"
		
		[11548] = daily,	--"Hand of the Oracles"	--Disabled by request of "Fisker-" in IRC, these 2 quests switch faction
		[12582] = daily,	--"Frenzyheart Champion"	--Disabled by request of "Fisker-" in IRC, these 2 quests switch faction
		[13846] = daily,	-- "Contributin' To The Cause"	--AC gold for rep quest

		--== Cata ==--		
	
}	--End of name Scanner Master Table

local iTable = {
		--BC
	[30809] = "Aldor Mark",
	[30810] = "Scryer Mark",
	[34538] = "Melee weapon",
	[34539] = "Caster weapon",
	[33844] = "Barrel of Fish",
	[33857] = "Crate Of Meat",
		--Wrath
	[46114] = "Champion's Writ",
	[45724] = "Champion's Purse",

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
--		module:Debug("OnUpdate", delay, elapsed, tt.questId)
		delay = delay + elapsed
		if delay > interval then
			delay = 0
			self:Hide()
			return tt:SetHyperlink(tt.prefix..tt.k)
		end
	end)

end
function module:StartQuestScan()
	--self:Debug("StartingTooltip Scan - QUEST")
	local id, qtype = next(qTable)
	tt.t = qTable
	tt.k = id
	tt.v = qtype
	tt.dba = localeQuestNameByID
	tt.dbb = {}
	tt.count = 0
	tt.prefix = "quest:"
	tt.NextScanFunc = "StartItemScan"
	tt.finishfunc = function()
			LocalizedQuestVersion = lastChanged
			AddonParent:SendMessage("SOCD_FINISH_QUEST_SCAN")
			local questCache = AddonParent.db.global.questCache
			for k,v in pairs(tt.dbb) do
				questCache[k] = v
			end
		end
	return tt:SetHyperlink(tt.prefix..tt.k)
end

function module:StartItemScan()
	--self:Debug("Starting Tooltip Scan - ITEMS")
	local id, name = next(iTable)
	tt.t = iTable
	tt.k = id
	tt.v = qtype
	tt.dba = nil
	tt.dbb = nil
	tt.count = 0
	tt.prefix = "item:"
	tt.NextScanFunc = nil
	tt.finishfunc = nil
	return tt:SetHyperlink(tt.prefix..tt.k)
end

function module:StopScan(info)
	--self:Debug("Stopping Tooltip Scanning?")
	ttScanFrame:Hide()
end



function AddonParent.GetLocalizedQuestNameByID(self, id)
	if id then
		return localeQuestNameByID and localeQuestNameByID[id] or nil
	else
		id = tonumber(self)
		return localeQuestNameByID and localeQuestNameByID[id] or nil
	end
end
