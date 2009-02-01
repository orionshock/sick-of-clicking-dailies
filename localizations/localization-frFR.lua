--[[
	Sick Of Clicking Dailies? - Locale file for frFR
	Written By: @project-author@
	
	Please Visit: http://www.wowace.com/projects/sick-of-clicking-dailies/localization/frFR
	to contribute to localizations :)
]]--






----------------------------------------------------------------------------
--	General -- Used by all or most :)				  --
----------------------------------------------------------------------------

local L = LibStub("AceLocale-3.0"):NewLocale("SOCD_Core", "frFR", false)

	if L then
--These are not importable to WoWAce/Curseforge Locale system, as these are pulled directly from the client.
L["Battlegrounds"] = BATTLEFIELDS
L["Netural"] = FACTION_STANDING_LABEL4
L["Friendly"] = FACTION_STANDING_LABEL5
L["Honored"] = FACTION_STANDING_LABEL6
L["Revered"] = FACTION_STANDING_LABEL7
L["Faction"] = FACTION
L["None"] = LFG_TYPE_NONE
L["Quests"] = QUESTS_LABEL
L["Horde"] = FACTION_HORDE
L["Alliance"] = FACTION_ALLIANCE
L["Professions"] = TRADE_SKILLS
L["Cooking"] = (GetSpellInfo(2550))
L["Fishing"] = (GetSpellInfo(7733))
L["Jewelcrafting"] = (GetSpellInfo(25229))

--@localization(locale="frFR", format="lua_additive_table", same-key-is-true=true, namespace="Base_All", table-name="L")@

	end	

--All Quests Classified by orgin / content location

----------------------------------------------------------------------------
--	Classic, Populated by WoWAce-Curseforge Packager.		  --
----------------------------------------------------------------------------

local C = LibStub("AceLocale-3.0"):NewLocale("SOCD_Classic", "frFR", false)

	if C then

--@localization(locale="frFR", format="lua_additive_table", same-key-is-true=true, namespace="Classic", table-name="C")@

	end

----------------------------------------------------------------------------
--	TBC, Populated by WoWAce-Curseforge Packager.			  --
----------------------------------------------------------------------------	

local BC = LibStub("AceLocale-3.0"):NewLocale("SOCD_BC", "frFR", false)

	if BC then

--@localization(locale="frFR", format="lua_additive_table", same-key-is-true=true, namespace="BC", table-name="BC")@

	end

----------------------------------------------------------------------------
--	WOTLK, Populated by WoWAce-Curseforge Packager.			  --
----------------------------------------------------------------------------

local LK = LibStub("AceLocale-3.0"):NewLocale("SOCD_LK", "frFR", false)

	if LK then

--@localization(locale="frFR", format="lua_additive_table", same-key-is-true=true, namespace="Wrath", table-name="LK")@

	end
