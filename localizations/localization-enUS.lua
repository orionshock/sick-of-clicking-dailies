--[[
	Sick Of Clicking Dailies? - Locale file for enUS
	Written By: @project-author@
	
	Please Visit: http://www.wowace.com/projects/sick-of-clicking-dailies/localization/
	to contribute to localizations :)
]]--

local debug = false
--@debug@
debug = true
--@end-debug@

----------------------------------------------------------------------------
--	General -- Used by all or most :)				  --
----------------------------------------------------------------------------

local L = LibStub("AceLocale-3.0"):NewLocale("SOCD_Core", "enUS", true, debug)

	if L then
--These are not importable to WoWAce/Curseforge Locale system, as these are pulled directly from the client.
L["Alliance"] = FACTION_ALLIANCE
L["Battlegrounds"] = BATTLEFIELDS
L["Cooking"] = (GetSpellInfo(2550))
L["Dungeon"] = LFG_TYPE_DUNGEON
L["Doungeons"] = BUG_CATEGORY3
L["Faction"] = FACTION
L["Fishing"] = (GetSpellInfo(63275))
L["Friendly"] = FACTION_STANDING_LABEL5
L["Heroic Dungeon"] = LFG_TYPE_HEROIC_DUNGEON
L["Honored"] = FACTION_STANDING_LABEL6
L["Horde"] = FACTION_HORDE
L["Jewelcrafting"] = (GetSpellInfo(25229))
L["None"] = LFG_TYPE_NONE
L["Netural"] = FACTION_STANDING_LABEL4
L["Professions"] = TRADE_SKILLS
L["PvP"] = PVP
L["Quests"] = QUESTS_LABEL
L["Revered"] = FACTION_STANDING_LABEL7
L["Wintergrasp"] = PVPBATTLEGROUND_WINTERGRASPTIMER:match("(.+)|n")

--@localization(locale="enUS", format="lua_additive_table", same-key-is-true=true, namespace="Base_All", table-name="L")@

	end	

--All Quests Classified by orgin / content location

----------------------------------------------------------------------------
--	Classic, Populated by WoWAce-Curseforge Packager.		  --
----------------------------------------------------------------------------

local C = LibStub("AceLocale-3.0"):NewLocale("SOCD_Classic", "enUS", true, debug)

	if C then

--@localization(locale="enUS", format="lua_additive_table", same-key-is-true=true, namespace="Classic", table-name="C")@

	end

----------------------------------------------------------------------------
--	TBC, Populated by WoWAce-Curseforge Packager.			  --
----------------------------------------------------------------------------	

local BC = LibStub("AceLocale-3.0"):NewLocale("SOCD_BC", "enUS", true, debug)

	if BC then

--@localization(locale="enUS", format="lua_additive_table", same-key-is-true=true, namespace="BC", table-name="BC")@

	end

----------------------------------------------------------------------------
--	WOTLK, Populated by WoWAce-Curseforge Packager.			  --
----------------------------------------------------------------------------

local LK = LibStub("AceLocale-3.0"):NewLocale("SOCD_LK", "enUS", true, debug)

	if LK then

--@localization(locale="enUS", format="lua_additive_table", same-key-is-true=true, namespace="Wrath", table-name="LK")@

		local LK_R = LibStub("AceLocale-3.0"):GetLocale("SOCD_LK")
		LK["I'm ready to begin. What is the first ingredient you require?"] = ( UnitSex("player") == 2 and LK_R["I'm ready to begin. What is the first ingredient you require?(M)"] or LK_R["I'm ready to begin. What is the first ingredient you require?(F)"] ):gsub("%([MF]%)$", "")
	end

---Localization Counter-- Bump to generate new zip for locale changes = 6
