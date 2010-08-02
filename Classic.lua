--
-- Classic WoW Dailies:
--	Wintersaber Quests
--	Battleground PvP
--
local AddonName, AddonParent = ...

local L = LibStub("AceLocale-3.0"):GetLocale(AddonName)

local function SetupModule(event)
	local GetLocalizedQuestNameByID = AddonParent.GetLocalizedQuestNameByID
	local moduleSpecialQuests = {
		[ GetLocalizedQuestNameByID(4970) ] = "Exclude",	--Frostsaber Provisions
		[ GetLocalizedQuestNameByID(5201) ] = "Exclude",	--Winterfall Intrusion
		[ GetLocalizedQuestNameByID(5981) ] = "Exclude",	--Rampaging Giants
	}
	for k,v in pairs(moduleSpecialQuests) do
		AddonParent.SpecialQuestResets[k] = v
	end
end

AddonParent.RegisterMessage("ClassicModule", "SOCD_QuestByID_Ready", SetupModule)
