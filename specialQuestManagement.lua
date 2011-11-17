--[[
	This "module" will handle the special quests / quest with rewards.
	Repeatable Quests w/ Selectable Rewards will not be supported for auto complete, but will still work as normal.
		--it will be posible to manually add the repeatable quest to the LUA & will note where to do it :)
]]--

local addonName, addon = ...
local GetLocalizedQuestNameByID = addon.GetLocalizedQuestNameByID

local function load()

	addon.db_defaults.profile.status = {	--Quests that should be disabled by Default for one reason or another
		--== Classic ==--
		--== Burrning Crusade ==--
		[ GetLocalizedQuestNameByID(11545) ] = false,	--"A Charitable Donation"
		[ GetLocalizedQuestNameByID(11548) ] = false,	--"Your Continued Support"
	
		--== Wrath Of the Lich King ==--
		[ GetLocalizedQuestNameByID(11548) ] = false,	--"Hand of the Oracles"	--Disabled by request of "Fisker-" in IRC, these 2 quests switch faction
		[ GetLocalizedQuestNameByID(12582) ] = false,	--"Frenzyheart Champion"	--Disabled by request of "Fisker-" in IRC, these 2 quests switch faction
		[ GetLocalizedQuestNameByID(13846) ] = false,	-- "Contributin' To The Cause"	--AC gold for rep quest
		--== Cata ==--
		
	}

	addon.db_defaults.profile.reward = {	--DB Defaults for ones with selectable rewards
		--== Classic ==--
		--== Burrning Crusade ==--
		[ GetLocalizedQuestNameByID(11379) ] = -1, --SuperHotStew
		[ GetLocalizedQuestNameByID(11381) ] = -1, --SoupForTheSoul
		[ GetLocalizedQuestNameByID(11377) ] = -1, --RevengeIsTasty
		[ GetLocalizedQuestNameByID(11380) ] = -1, --Manalicious
		[ GetLocalizedQuestNameByID(11515) ] = -1, --BloodForBlood
		[ GetLocalizedQuestNameByID(11544) ] = -1, --AtamalArmaments
	
		--== Wrath Of the Lich King ==--
		[ GetLocalizedQuestNameByID(13789) ] = -1, --"Taking Battle To The Enemy"
		[ GetLocalizedQuestNameByID(13861) ] = -1, --"Battle Before The Citadel"
		[ GetLocalizedQuestNameByID(13682) ] = -1, --"Threat From Above"
		[ GetLocalizedQuestNameByID(13790) ] = -1, --"Among the Champions"
			--Thx Holliday
		[ GetLocalizedQuestNameByID(14061) ] = -1,	--"Can't Get Enough Turkey"
		[ GetLocalizedQuestNameByID(14062) ] = -1,	--"Don't Forget The Stuffing!"
		[ GetLocalizedQuestNameByID(14060) ] = -1,	--"Easy As Pie",
		[ GetLocalizedQuestNameByID(14058) ] = -1,	--"She Says Potato"
		[ GetLocalizedQuestNameByID(14059) ] = -1,	--"We're Out of Cranberry Chutney Again?"
		--== Cata ==--
	}

	--=== Multi-Quest Reward Tables===--
		--== Classic ==--
		--== Burrning Crusade ==--
		local bc_cookingRewards = { [-1] = NONE, (GetItemInfo(33844)) or "Barrel of Fish", (GetItemInfo(33857)) or "Crate Of Meat" ) }
		local ssoRewards = { [-1] = NONE, (GetItemInfo(30809)) or "Aldor Mark", (GetItemInfo(30810)) or "Scryer Mark") }
		--== Wrath Of the Lich King ==--
		local champQuestRewardOpts = { [-1] = NONE, (GetItemInfo(46114)) or "Champion's Writ", (GetItemInfo(45724)) or "Champion's Purse" }
		local thxgivingRewardOpts = { [-1] = NONE, GetItemInfo(46723) or "Pilgrim's Hat", GetItemInfo(46800) or "Pilgrim's Attire",GetItemInfo(44785) or "Pilgrim's Dress",
				GetItemInfo(46824) or "Pilgrim's Robe", GetItemInfo(44788) or "Pilgrim's Boots", GetItemInfo(44812) or "Pilgrim's Shooter",}
		--== Cata ==--	

	addon.db_defaults.global.reward = {	--DB Globals for reward list
		--== Classic ==--
		--== Burrning Crusade ==--
			--Cooking
		[ GetLocalizedQuestNameByID(11379) ] = bc_cookingRewards, --SuperHotStew
		[ GetLocalizedQuestNameByID(11381) ] = bc_cookingRewards, --SoupForTheSoul
		[ GetLocalizedQuestNameByID(11377) ] = bc_cookingRewards, --RevengeIsTasty
		[ GetLocalizedQuestNameByID(11380) ] = bc_cookingRewards, --Manalicious
			--SSO
		[ GetLocalizedQuestNameByID(11515) ] = ssoRewards, --BloodForBlood
		[ GetLocalizedQuestNameByID(11544) ] = ssoRewards, --AtamalArmaments
		--== Wrath Of the Lich King ==--
			--Argent Tourny
		[ GetLocalizedQuestNameByID(13789) ] = champQuestRewardOpts, --"Taking Battle To The Enemy"
		[ GetLocalizedQuestNameByID(13861) ] = champQuestRewardOpts, --"Battle Before The Citadel"
		[ GetLocalizedQuestNameByID(13682) ] = champQuestRewardOpts, --"Threat From Above"
		[ GetLocalizedQuestNameByID(13790) ] = champQuestRewardOpts, --"Among the Champions"
			--Thx Holliday
		[ GetLocalizedQuestNameByID(14061) ] = thxgivingRewardOpts,	--"Can't Get Enough Turkey"
		[ GetLocalizedQuestNameByID(14062) ] = thxgivingRewardOpts,	--"Don't Forget The Stuffing!"
		[ GetLocalizedQuestNameByID(14060) ] = thxgivingRewardOpts,	--"Easy As Pie",
		[ GetLocalizedQuestNameByID(14058) ] = thxgivingRewardOpts,	--"She Says Potato"
		[ GetLocalizedQuestNameByID(14059) ] = thxgivingRewardOpts,	--"We're Out of Cranberry Chutney Again?"
		--== Cata ==--	
	}

	function addon:IsSpecialQuest(name)
		if self.db.profile.reward[name] then
			return db.profile.reward[name] or -1
		end
	end

end
addon.RegisterMessage("SpecialQuests", "SOCD_QuestByID_Ready", load)