--[[
	Alt Daily Quest Tracking
	purpose: to provide a LDB feed / Tooltip showing a summary of toon and what quests are completed for that toon
		currently it's all displayed in one tooltip, however it's know fact that if you do your dailies on more than 3
		chars that your going to fill your tooltip up.. 

		final goal here is to provide the lists of quests & what toons have not completed that quest.
]]--


local AddonParent = LibStub("AceAddon-3.0"):GetAddon("SickOfClickingDailies")
local LDBModule = AddonParent:GetModule("LDB")
local module = AddonParent:NewModule("Alt Tracking", "AceEvent-3.0")
module.noModuleControl = true
L = LibStub("AceLocale-3.0"):GetLocale("SOCD_AltTracking")

local playerName, completedQuests, db

function D(...)
	local str = string.join(", ", tostringall(...) )
	str = str:gsub("([=:]), ", "%1")

	if AddonParent.db and AddonParent.db.global.debug then
		print("|cff99ff66SOCD-AT:|r "..str)
	end
	return str
end

function module:OnInitialize()
	completedQuests = AddonParent.db.char.completedQuests
	self.db = AddonParent.db:RegisterNamespace("AltTracking", { realm = { chars = {} } } )
	db = self.db.realm
	playerName = UnitName("player")

	db[playerName] = db[playerName] or {}
	db.chars[playerName] = UnitFactionGroup("player")
	self.sortedPlayerList = {}
	for player in pairs(db.chars) do
		tinsert(self.sortedPlayerList, player)
	end
	table.sort(self.sortedPlayerList)



	D("OnInitialize")
end

function module:OnEnable()
	self:CreateLDB()
	D("OnEnable")
--	self:RegisterMessage("SOCD_DAILIY_QUEST_COMPLETE")
end

local old_LDB_DailieEvent = LDBModule.SOCD_DAILIY_QUEST_COMPLETE

function LDBModule:SOCD_DAILIY_QUEST_COMPLETE(event, quest, opt, id)
	old_LDB_DailieEvent(LDBModule, event, quest, opt, id)
	D("Tracking Hook",quest, "expires in",  date("%c", completedQuests[quest]))
	local ttd = completedQuests[quest] or completedQuests[quest.." ~ "..date()]
	local t = db[playerName] or {}
	t[quest] = ttd
	db[playerName] = t
end


local function OnTooltipShow(self)
	self:AddLine(L["Quests for All Toons"])
	self:AddLine(" ")
	for _, charName in ipairs(module.sortedPlayerList) do
		if db[charName] and next(db[charName]) then
			self:AddLine(charName.." - "..db.chars[charName])
			local sortedTable = module:SortQuestCompleTable( db[ charName ] )
			for _, quest in ipairs(sortedTable) do
				self:AddDoubleLine( "    "..quest, date("%c", db[charName][quest]) )
			end
			self:AddLine(" ")
		end
	end
end

do
	local t = {}
	function module:SortQuestCompleTable(completedQuests)
		wipe(t)
		for k, v in pairs(completedQuests) do
			tinsert( t , k)
		end
		table.sort(t)
		return t
	end
end

local function OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_NONE")
	GameTooltip:SetPoint("TOPLEFT", self, "BOTTOMLEFT")
	GameTooltip:ClearLines()
	OnTooltipShow(GameTooltip)
	GameTooltip:Show()
end

local function OnLeave(self)
	GameTooltip:Hide()
end


function module:CreateLDB()
	local trackLDB = {
		type = "data source",
		icon = "Interface\\Icons\\Achievement_Win_Wintergrasp",
		text = L["Dailies On Alts"],
		OnEnter = OnEnter,
		OnLeave = OnLeave,
		OnTooltipShow = OnTooltipShow,
	}
	self.ldb = LibStub("LibDataBroker-1.1"):NewDataObject(L["SOCD - Alts Tracking"], trackLDB)
end




--
do
	local TimeToResetGroup = select(2, LDBModule.AnimationFrame:GetAnimationGroups() )
	TimeToResetGroup.name = "TimeToResetGroup"
	local Ani = TimeToResetGroup:CreateAnimation()
	Ani.name = "ALtTrack-Animation"
	Ani:SetDuration(1)
	Ani:SetOrder(2)
	Ani:SetScript("OnFinished", function(self,...)
		D("AltTracking - Reset Animation, Pruning History")
	--	if GetQuestResetTime() > 86300 then return end
		for toon, qTable in pairs(db) do
			if toon ~= "chars" then
				D("Pruning toon", toon)
				for quest, ttl in pairs(qTable) do
					if time() > ttl then
						D("Pruning", quest, "Exired on:", date("%c", ttl), "current Time:", date() )
						qTable[quest] = nil
					end
				end
			end
		end
		for toon, qTable in pairs(db) do
			if not next(qTable) then
				D("removing", toon," from db, no quests")
				db[toon] = nil
			end
		end
	end)
	function SOCD_CheckTTND()
		local elapsed, duration = math.floor((TimeToResetGroup:GetAnimations()):GetElapsed()), TimeToResetGroup:GetDuration()
		print("Animation Time To new day. Elapsed:", elapsed, "Duration", duration, SecondsToTime( duration - elapsed) )
	end
end
