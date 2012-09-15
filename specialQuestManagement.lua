--[[
	Sick Of Clicking Dailies? - Special quest management module
	This "module" will handle the special quests / quest with rewards.
	Repeatable Quests w/ Selectable Rewards will not be supported for auto complete, but will still work as normal.
		--it will be posible to manually add the repeatable quest to the LUA & will note where to do it :)
	
	Written By: OrionShock
]]--

local addonName, addon = ...
local GetLocalizedQuestNameByID = addon.GetLocalizedQuestNameByID

--@debug@
local function Debug(...)
	local str = string.join(", ", tostringall(...) )
	str = str:gsub("([:=>]),", "%1")
	str = str:gsub(", ([%-])", " %1")
	DEFAULT_CHAT_FRAME:AddMessage("SOCD-SQM: "..str)
	return str
end
--@end-debug@

local function load()

	addon.db_defaults.profile.status = {	--Quests that should be disabled by Default for one reason or another
		--== Burning Crusade ==--
		[ GetLocalizedQuestNameByID(11545) ] = false,	--"A Charitable Donation" --Gold for rep quest
		[ GetLocalizedQuestNameByID(11548) ] = false,	--"Your Continued Support" --Gold for rep quest
	
		--== Wrath of the Lich King ==--
		[ GetLocalizedQuestNameByID(12689) ] = false,	--"Hand of the Oracles"	--Disabled by request of "Fisker-" in IRC, these 2 quests switch faction
		[ GetLocalizedQuestNameByID(12582) ] = false,	--"Frenzyheart Champion"	--Disabled by request of "Fisker-" in IRC, these 2 quests switch faction
		[ GetLocalizedQuestNameByID(13846) ] = false,	-- "Contributin' To The Cause"	--AC gold for rep quest
	}

	addon.db_defaults.profile.reward = {	--DB Defaults for ones with selectable rewards
		--== Burning Crusade ==--
		[ GetLocalizedQuestNameByID(11379) ] = -1,	--"Super Hot Stew"
		[ GetLocalizedQuestNameByID(11381) ] = -1,	--"Soup for the Soul"
		[ GetLocalizedQuestNameByID(11377) ] = -1,	--"Revenge is Tasty"
		[ GetLocalizedQuestNameByID(11380) ] = -1,	--"Manalicious"
		[ GetLocalizedQuestNameByID(11515) ] = -1,	--"Blood for Blood"
		[ GetLocalizedQuestNameByID(11544) ] = -1,	--"Ata'mal Armaments"
	
		--== Wrath of the Lich King ==--
		[ GetLocalizedQuestNameByID(13789) ] = -1,	--"Taking Battle To The Enemy"
		[ GetLocalizedQuestNameByID(13861) ] = -1,	--"Battle Before The Citadel"
		[ GetLocalizedQuestNameByID(13682) ] = -1,	--"Threat From Above"
		[ GetLocalizedQuestNameByID(13790) ] = -1,	--"Among the Champions"
		
		--Thx Holliday
		[ GetLocalizedQuestNameByID(14061) ] = -1,	--"Can't Get Enough Turkey"
		[ GetLocalizedQuestNameByID(14062) ] = -1,	--"Don't Forget The Stuffing!"
		[ GetLocalizedQuestNameByID(14060) ] = -1,	--"Easy As Pie",
		[ GetLocalizedQuestNameByID(14058) ] = -1,	--"She Says Potato"
		[ GetLocalizedQuestNameByID(14059) ] = -1,	--"We're Out of Cranberry Chutney Again?"
	}

	--=== Multi-Quest Reward Tables===--
	--== Burning Crusade ==--
	-- 33844 "Barrel of Fish"
	-- 33857 "Crate of Meat"
	local bc_cookingRewards = { [-1] = NONE, 33844, 33857 }
	
	-- 30809 "Mark of Sargeras"
	-- 30810 "Sunfury Signet"
	local ssoRewards = { [-1] = NONE, 30809, 30810 }
	
	-- 34538 "Blessed Weapon Coating"
	-- 34539 "Righteous Weapon Coating"
	local atamalRewards = { [-1] = NONE, 34538, 34539 }
	
	--== Wrath of the Lich King ==--
	-- 46114 "Champion's Writ"
	-- 45724 "Champion's Purse"
	local champQuestRewards = { [-1] = NONE, 46114, 45724 }
	
	-- 46723 "Pilgrim's Hat"
	-- 46800 "Pilgrim's Attire"
	-- 44785 "Pilgrim's Dress"
	-- 46824 "Pilgrim's Robe"
	-- 44788 "Pilgrim's Boots"
	-- 44812 "Turkey Shooter"
	local thxgivingRewards = { [-1] = NONE, 46723, 46800, 44785, 46824, 44788, 44812 }

	addon.db_defaults.global.reward = {	--DB Globals for reward list
		--== Burning Crusade ==--
		--Cooking
		[ GetLocalizedQuestNameByID(11379) ] = bc_cookingRewards, --"Super Hot Stew"
		[ GetLocalizedQuestNameByID(11381) ] = bc_cookingRewards, --"Soup for the Soul"
		[ GetLocalizedQuestNameByID(11377) ] = bc_cookingRewards, --"Revenge is Tasty"
		[ GetLocalizedQuestNameByID(11380) ] = bc_cookingRewards, --"Manalicious"
		
		--SSO
		[ GetLocalizedQuestNameByID(11515) ] = ssoRewards, --"Blood for Blood"
		
		--Ata'mal
		[ GetLocalizedQuestNameByID(11544) ] = atamalRewards, --"Ata'mal Armaments"
		
		--== Wrath Of the Lich King ==--
		--Argent Tourny
		[ GetLocalizedQuestNameByID(13789) ] = champQuestRewards, --"Taking Battle To The Enemy"
		[ GetLocalizedQuestNameByID(13861) ] = champQuestRewards, --"Battle Before The Citadel"
		[ GetLocalizedQuestNameByID(13682) ] = champQuestRewards, --"Threat From Above"
		[ GetLocalizedQuestNameByID(13790) ] = champQuestRewards, --"Among the Champions"
		
		--Thx Holliday
		[ GetLocalizedQuestNameByID(14061) ] = thxgivingRewards,	--"Can't Get Enough Turkey"
		[ GetLocalizedQuestNameByID(14062) ] = thxgivingRewards,	--"Don't Forget The Stuffing!"
		[ GetLocalizedQuestNameByID(14060) ] = thxgivingRewards,	--"Easy As Pie",
		[ GetLocalizedQuestNameByID(14058) ] = thxgivingRewards,	--"She Says Potato"
		[ GetLocalizedQuestNameByID(14059) ] = thxgivingRewards,	--"We're Out of Cranberry Chutney Again?"
	}
	
	local specialFixQuestList = {
		[11006] = true,	--More Shadow Dust
		[12618] = true, --Blessing of Zim'Torga
	}

	function addon:IsChoiceQuest(name)
		--Debug("IsChoiceQuest", name, self.db.profile.reward[name])
		name = name:trim()
		if self.db.profile.reward[name] then
			return self.db.profile.reward[name] or -1
		end
	end
	
	function addon:SpecialFixQuest( questID )
		questID = tonumber(questID)
		if specialFixQuestList[questID] then
			return true
		end
	end
end
addon.RegisterMessage("SpecialQuests", "SOCD_FINISHED_QUEST_SCAN", load)