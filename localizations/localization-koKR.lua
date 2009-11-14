--[[
	Sick Of Clicking Dailies? - Locale file for koKR
	Written By: @project-author@
	
	Please Visit: http://www.wowace.com/addons/sick-of-clicking-dailies/pages/how-to-add-localizations/
	to contribute to localizations :)
]]--







----------------------------------------------------------------------------
--	General -- Used by all or most :)				  --
----------------------------------------------------------------------------

local L = LibStub("AceLocale-3.0"):NewLocale("SOCD_Core", "koKR", false)

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

--@localization(locale="koKR", format="lua_additive_table", same-key-is-true=true, namespace="Base_All", table-name="L")@

	end	

--All Quests Classified by orgin / content location

----------------------------------------------------------------------------
--	Classic, Populated by WoWAce-Curseforge Packager.		  --
----------------------------------------------------------------------------

local C = LibStub("AceLocale-3.0"):NewLocale("SOCD_Classic", "koKR", false)

	if C then

--@localization(locale="koKR", format="lua_additive_table", same-key-is-true=true, namespace="Classic", table-name="C")@

	end

----------------------------------------------------------------------------
--	TBC, Populated by WoWAce-Curseforge Packager.			  --
----------------------------------------------------------------------------	

local BC = LibStub("AceLocale-3.0"):NewLocale("SOCD_BC", "koKR", false)

	if BC then

--@localization(locale="koKR", format="lua_additive_table", same-key-is-true=true, namespace="BC", table-name="BC")@

	end

----------------------------------------------------------------------------
--	WOTLK, Populated by WoWAce-Curseforge Packager.			  --
----------------------------------------------------------------------------

local LK = LibStub("AceLocale-3.0"):NewLocale("SOCD_LK", "koKR", false)

	if LK then

--@localization(locale="koKR", format="lua_additive_table", same-key-is-true=true, namespace="Wrath", table-name="LK")@

	end

----------------------------------------------------------------------------
--	Gossip Texts, Populated by WoWAce-Curseforge Packager.			  --
----------------------------------------------------------------------------

local GT = LibStub("AceLocale-3.0"):NewLocale("SOCD_GossipText", "koKR", false)
	if GT then

--@localization(locale="koKR", format="lua_additive_table", same-key-is-true=true, namespace="GossipTexts", table-name="GT")@


		local GT_R = LibStub("AceLocale-3.0"):GetLocale("SOCD_GossipText")
		if genderMale then	--Masculine Context

GT["I'm ready to work for you today!  Give me the good stuff!"] = GT_R["I'm ready to work for you today!  Give me the good stuff!(M)"]:gsub("[%(MF%)]+$", "")
GT["I'm ready to work for you today!  Give me that ram!"] = GT_R["I'm ready to work for you today!  Give me that ram!(M)"]:gsub("[%(MF%)]+$", "")
GT["I'm ready to begin. What is the first ingredient you require?"] = GT_R["I'm ready to begin. What is the first ingredient you require?(M)"]:gsub("[%(MF%)]+$", "")

		else			--Feminine Context

GT["I'm ready to work for you today!  Give me the good stuff!"] = GT_R["I'm ready to work for you today!  Give me the good stuff!(F)"]:gsub("[%(MF%)]+$", "")
GT["I'm ready to work for you today!  Give me that ram!"] = GT_R["I'm ready to work for you today!  Give me that ram!(F)"]:gsub("[%(MF%)]+$", "")
GT["I'm ready to begin. What is the first ingredient you require?"] = GT_R["I'm ready to begin. What is the first ingredient you require?(F)"]:gsub("[%(MF%)]+$", "")

		end
	end


