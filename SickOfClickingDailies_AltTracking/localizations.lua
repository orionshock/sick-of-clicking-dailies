--[[
	Sick Of Clicking Dailies? - Locale file for alt tracking module
	Written By: OrionShock
	
	Please Visit: http://www.wowace.com/addons/sick-of-clicking-dailies/pages/how-to-add-localizations/
	to contribute to localizations :)
]]--

do
				--EnUS Base, Always Load--
	local silent = false
	--@debug@
	silent = true
	--@end-debug@

	----------------------------------------------------------------------------
	--	General -- Used by all or most :)				  --
	----------------------------------------------------------------------------

	local L = LibStub("AceLocale-3.0"):NewLocale("SOCD_AltTracking", "enUS", true, silent)

		if L then
	--These are not importable to WoWAce/Curseforge Locale system, as these are pulled directly from the client.
	L["PvP"] = PVP
	L["Quests"] = QUESTS_LABEL


	--@localization(locale="enUS", format="lua_additive_table", same-key-is-true=true, namespace="AltTrackingModule", table-name="L")@

		end
end

do	--deDE

	local L = LibStub("AceLocale-3.0"):NewLocale("SOCD_AltTracking", "deDE")

		if L then
	--These are not importable to WoWAce/Curseforge Locale system, as these are pulled directly from the client.
	L["PvP"] = PVP
	L["Quests"] = QUESTS_LABEL


	--@localization(locale="deDE", format="lua_additive_table", same-key-is-true=true, namespace="AltTrackingModule", table-name="L")@

		end
end

do	--esES

	local L = LibStub("AceLocale-3.0"):NewLocale("SOCD_AltTracking", "esES")

		if L then
	--These are not importable to WoWAce/Curseforge Locale system, as these are pulled directly from the client.
	L["PvP"] = PVP
	L["Quests"] = QUESTS_LABEL


	--@localization(locale="esES", format="lua_additive_table", same-key-is-true=true, namespace="AltTrackingModule", table-name="L")@

		end

end

do	--frFR
	local L = LibStub("AceLocale-3.0"):NewLocale("SOCD_AltTracking", "frFR")

		if L then
	--These are not importable to WoWAce/Curseforge Locale system, as these are pulled directly from the client.
	L["PvP"] = PVP
	L["Quests"] = QUESTS_LABEL


	--@localization(locale="frFR", format="lua_additive_table", same-key-is-true=true, namespace="AltTrackingModule", table-name="L")@

		end
end

do	--koKR

	local L = LibStub("AceLocale-3.0"):NewLocale("SOCD_AltTracking", "koKR")

		if L then
	--These are not importable to WoWAce/Curseforge Locale system, as these are pulled directly from the client.
	L["PvP"] = PVP
	L["Quests"] = QUESTS_LABEL


	--@localization(locale="koKR", format="lua_additive_table", same-key-is-true=true, namespace="AltTrackingModule", table-name="L")@

		end
end

do	--ruRU

	local L = LibStub("AceLocale-3.0"):NewLocale("SOCD_AltTracking", "ruRU")

		if L then
	--These are not importable to WoWAce/Curseforge Locale system, as these are pulled directly from the client.
	L["PvP"] = PVP
	L["Quests"] = QUESTS_LABEL


	--@localization(locale="ruRU", format="lua_additive_table", same-key-is-true=true, namespace="AltTrackingModule", table-name="L")@

		end
end

do	--zhTW

	local L = LibStub("AceLocale-3.0"):NewLocale("SOCD_AltTracking", "zhTW")

		if L then
	--These are not importable to WoWAce/Curseforge Locale system, as these are pulled directly from the client.
	L["PvP"] = PVP
	L["Quests"] = QUESTS_LABEL


	--@localization(locale="zhTW", format="lua_additive_table", same-key-is-true=true, namespace="AltTrackingModule", table-name="L")@

		end
end
