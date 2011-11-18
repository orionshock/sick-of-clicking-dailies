--[[
	This "module" will handle the special quests / quest with rewards.
	Repeatable Quests w/ Selectable Rewards will not be supported for auto complete, but will still work as normal.
		--it will be posible to manually add the repeatable quest to the LUA & will note where to do it :)
]]--

local addonName, addon = ...
local GetLocalizedQuestNameByID = addon.GetLocalizedQuestNameByID

local function Debug(...)
	local str = string.join(", ", tostringall(...) )
	str = str:gsub("([:=>]),", "%1")
	str = str:gsub(", ([%-])", " %1")
	ChatFrame5:AddMessage("SOCD-SQM: "..str)
	return str
end

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
		local bc_cookingRewards = { [-1] = NONE, (GetItemInfo(33844)) or "Barrel of Fish", (GetItemInfo(33857)) or "Crate Of Meat" }
		local ssoRewards = { [-1] = NONE, (GetItemInfo(30809)) or "Aldor Mark", (GetItemInfo(30810)) or "Scryer Mark" }
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

	function addon:IsChoiceQuest(name)
		Debug("IsSpecialQuest", name, self.db.profile.reward[name])
		name = name:trim()
		if self.db.profile.reward[name] then
			return self.db.profile.reward[name] or -1
		end
	end
	
	addon.SpecialQuestResets = {
		--== Classic ==--
		--== Burrning Crusade ==--
		--== Wrath Of the Lich King ==--
			--Wintergraps PvP Quests
		[GetLocalizedQuestNameByID(13195)] = "GetNextWeeklyReset",	--"A Rare Herb"
		[GetLocalizedQuestNameByID(13199)] = "GetNextWeeklyReset",	--"Bones and Arrows"
		[GetLocalizedQuestNameByID(13222)] = "GetNextWeeklyReset",	--"Defend the Siege"
		[GetLocalizedQuestNameByID(13191)] = "GetNextWeeklyReset",	--"Fueling the Demolishers"
		[GetLocalizedQuestNameByID(13201)] = "GetNextWeeklyReset",	--"Healing with Roses"
		[GetLocalizedQuestNameByID(13202)] = "GetNextWeeklyReset",	--"Jinxing the Walls"
		[GetLocalizedQuestNameByID(13177)] = "GetNextWeeklyReset",	--"No Mercy for the Merciless"
		[GetLocalizedQuestNameByID(13178)] = "GetNextWeeklyReset",	--"Slay them all!"
		[GetLocalizedQuestNameByID(13186)] = "GetNextWeeklyReset",	--"Stop the Siege"
		[GetLocalizedQuestNameByID(13181)] = "GetNextWeeklyReset",	--"Victory in Wintergrasp"
		[GetLocalizedQuestNameByID(13192)] = "GetNextWeeklyReset",	--"Warding the Walls"
		[GetLocalizedQuestNameByID(13198)] = "GetNextWeeklyReset",	--"Warding the Warriors"
		[GetLocalizedQuestNameByID(13538)] = "GetNextWeeklyReset",	--"Southern Sabotage"
		[GetLocalizedQuestNameByID(13539)] = "GetNextWeeklyReset",	--"Toppling the Towers"

		--Raid Weekly Quests
		[GetLocalizedQuestNameByID(24580)] = "GetNextWeeklyReset",	--"Anub'Rekhan Must Die!"
		[GetLocalizedQuestNameByID(24585)] = "GetNextWeeklyReset",	--"Flame Leviathan Must Die!"
		[GetLocalizedQuestNameByID(24587)] = "GetNextWeeklyReset",	--"Ignis the Furnace Master Must Die!"
		[GetLocalizedQuestNameByID(24582)] = "GetNextWeeklyReset",	--"Instructor Razuvious Must Die!"
		[GetLocalizedQuestNameByID(24589)] = "GetNextWeeklyReset",	--"Lord Jaraxxus Must Die!"
		[GetLocalizedQuestNameByID(24590)] = "GetNextWeeklyReset",	--"Lord Marrowgar Must Die!"
		[GetLocalizedQuestNameByID(24584)] = "GetNextWeeklyReset",	--"Malygos Must Die!"
		[GetLocalizedQuestNameByID(24581)] = "GetNextWeeklyReset",	--"Noth the Plaguebringer Must Die!"
		[GetLocalizedQuestNameByID(24583)] = "GetNextWeeklyReset",	--"Patchwerk Must Die!"
		[GetLocalizedQuestNameByID(24586)] = "GetNextWeeklyReset",	--"Razorscale Must Die!"
		[GetLocalizedQuestNameByID(24579)] = "GetNextWeeklyReset",	--"Sartharion Must Die!"
		[GetLocalizedQuestNameByID(24588)] = "GetNextWeeklyReset",	--"XT-002 Deconstructor Must Die!"

		--ICC Weekly Quests
		[GetLocalizedQuestNameByID(24879)] = "GetNextWeeklyReset",	--"Blood Quickening"
		[GetLocalizedQuestNameByID(24875)] = "GetNextWeeklyReset",	--"Deprogramming"
		[GetLocalizedQuestNameByID(24878)] = "GetNextWeeklyReset",	--"Residue Rendezvous"
		[GetLocalizedQuestNameByID(24880)] = "GetNextWeeklyReset",	--"Respite for a Tormented Soul"
		[GetLocalizedQuestNameByID(24877)] = "GetNextWeeklyReset",	--"Securing the Ramparts"
		
		--== Cata ==--		

	}
end
addon.RegisterMessage("SpecialQuests", "SOCD_FINISH_QUEST_SCAN", load)