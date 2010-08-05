--[[
	Sick Of Clicking Dailies? - Locale file for koKR
	Written By: @project-author@
	
	Please Visit: http://www.wowace.com/addons/sick-of-clicking-dailies/pages/how-to-add-localizations/
	to contribute to localizations :)
]]--
local addonName = ...





local genderMale = UnitSex("player") == 2

local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "koKR", false)

if L then

--@localization(locale="koKR", format="lua_additive_table", same-key-is-true=true, handle-subnamespaces="none", table-name="L")@

end

local GT = LibStub("AceLocale-3.0"):NewLocale(addonName.."GossipText", "koKR", true, debug)
	if GT then

--@localization(locale="koKR", format="lua_additive_table", same-key-is-true=true, namespace="GossipText", table-name="GT")@


	local GT_R = LibStub("AceLocale-3.0"):GetLocale(addonName.."GossipText")
	if genderMale then	--Masculine Context
		GT["I'm ready to begin. What is the first ingredient you require?"] = GT_R["I'm ready to begin. What is the first ingredient you require?(M)"]:gsub("[%(MF%)]+$", "")
		GT["I am ready to fight!"] = GT_R["I am ready to fight!(M)"]:gsub("[%(MF%)]+$", "")

	else			--Feminine Context
		GT["I'm ready to begin. What is the first ingredient you require?"] = GT_R["I'm ready to begin. What is the first ingredient you require?(F)"]:gsub("[%(MF%)]+$", "")
		GT["I am ready to fight!"] = GT_R["I am ready to fight!(F)"]:gsub("[%(MF%)]+$", "")
	end
end



---Localization Counter-- Bump to generate new zip for locale changes = 16
