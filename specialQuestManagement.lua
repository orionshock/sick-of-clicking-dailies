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
		[GetLocalizedQuestNameByID(11548)] = false,	--"Your Continued Support" --Gold for rep quest
	
		--== Wrath of the Lich King ==--
		[GetLocalizedQuestNameByID(12689)] = false,	--"Hand of the Oracles" --Disabled by request of "Fisker-" in IRC, these 2 quests switch faction
		[GetLocalizedQuestNameByID(12582)] = false,	--"Frenzyheart Champion" --Disabled by request of "Fisker-" in IRC, these 2 quests switch faction
		[GetLocalizedQuestNameByID(13846)] = false,	--"Contributin' To The Cause" --AC gold for rep quest
		
		--== Mists of Pandaria ==--
		--The Tillers
		--Non-ideal Blue Feather gifts
		[GetLocalizedQuestNameByID(30382)] = false,	--"A Blue Feather for Ella"
		[GetLocalizedQuestNameByID(30419)] = false,	--"A Blue Feather for Farmer Fung"
		[GetLocalizedQuestNameByID(30425)] = false,	--"A Blue Feather for Fish"
		[GetLocalizedQuestNameByID(30388)] = false,	--"A Blue Feather for Gina"
		[GetLocalizedQuestNameByID(30412)] = false,	--"A Blue Feather for Haohan"
		[GetLocalizedQuestNameByID(30437)] = false,	--"A Blue Feather for Jogu"
		[GetLocalizedQuestNameByID(30406)] = false,	--"A Blue Feather for Sho"
		[GetLocalizedQuestNameByID(30431)] = false,	--"A Blue Feather for Tina"
		--Non-ideal Jade Cat gifts
		[GetLocalizedQuestNameByID(30399)] = false,	--"A Jade Cat for Chee Chee"
		[GetLocalizedQuestNameByID(30418)] = false,	--"A Jade Cat for Farmer Fung"
		[GetLocalizedQuestNameByID(30387)] = false,	--"A Jade Cat for Gina"
		[GetLocalizedQuestNameByID(30411)] = false,	--"A Jade Cat for Haohan"
		[GetLocalizedQuestNameByID(30436)] = false,	--"A Jade Cat for Jogu"
		[GetLocalizedQuestNameByID(30393)] = false,	--"A Jade Cat for Old Hillpaw"
		[GetLocalizedQuestNameByID(30405)] = false,	--"A Jade Cat for Sho"
		[GetLocalizedQuestNameByID(30430)] = false,	--"A Jade Cat for Tina"
		--Non-ideal Lovely Apple gifts
		[GetLocalizedQuestNameByID(30398)] = false,	--"A Lovely Apple for Chee Chee"
		[GetLocalizedQuestNameByID(30189)] = false,	--"A Lovely Apple for Ella"
		[GetLocalizedQuestNameByID(30417)] = false,	--"A Lovely Apple for Farmer Fung"
		[GetLocalizedQuestNameByID(30423)] = false,	--"A Lovely Apple for Fish"
		[GetLocalizedQuestNameByID(30380)] = false,	--"A Lovely Apple for Gina"
		[GetLocalizedQuestNameByID(30410)] = false,	--"A Lovely Apple for Haohan"
		[GetLocalizedQuestNameByID(30392)] = false,	--"A Lovely Apple for Old Hillpaw"
		[GetLocalizedQuestNameByID(30429)] = false,	--"A Lovely Apple for Tina"
		--Non-ideal Ruby Shard gifts
		[GetLocalizedQuestNameByID(30397)] = false,	--"A Ruby Shard for Chee Chee"
		[GetLocalizedQuestNameByID(30160)] = false,	--"A Ruby Shard for Ella"
		[GetLocalizedQuestNameByID(30416)] = false,	--"A Ruby Shard for Farmer Fung"
		[GetLocalizedQuestNameByID(30422)] = false,	--"A Ruby Shard for Fish"
		[GetLocalizedQuestNameByID(30379)] = false,	--"A Ruby Shard for Gina"
		[GetLocalizedQuestNameByID(30434)] = false,	--"A Ruby Shard for Jogu"
		[GetLocalizedQuestNameByID(30391)] = false,	--"A Ruby Shard for Old Hillpaw"
		[GetLocalizedQuestNameByID(30403)] = false,	--"A Ruby Shard for Sho"
		--Non-ideal Marsh Lily gifts
		[GetLocalizedQuestNameByID(30401)] = false,	--"A Marsh Lily for Chee Chee"
		[GetLocalizedQuestNameByID(30383)] = false,	--"A Marsh Lily for Ella"
		[GetLocalizedQuestNameByID(30426)] = false,	--"A Marsh Lily for Fish"
		[GetLocalizedQuestNameByID(30413)] = false,	--"A Marsh Lily for Haohan"
		[GetLocalizedQuestNameByID(30438)] = false,	--"A Marsh Lily for Jogu"
		[GetLocalizedQuestNameByID(30395)] = false,	--"A Marsh Lily for Old Hillpaw"
		[GetLocalizedQuestNameByID(30407)] = false,	--"A Marsh Lily for Sho"
		[GetLocalizedQuestNameByID(30432)] = false,	--"A Marsh Lily for Tina"
		
		--== Warlords of Draenor ==--
		--Seal of Tempered Fate
		[GetLocalizedQuestNameByID(36054)] = false,	--"Sealing Fate: Gold"
		[GetLocalizedQuestNameByID(37454)] = false,	--"Sealing Fate: Piles of Gold"
		[GetLocalizedQuestNameByID(37455)] = false,	--"Sealing Fate: Immense Fortune of Gold"
		[GetLocalizedQuestNameByID(36056)] = false,	--"Sealing Fate: Garrison Resources"
		[GetLocalizedQuestNameByID(37456)] = false,	--"Sealing Fate: Stockpiled Garrison Resources"
		[GetLocalizedQuestNameByID(37457)] = false,	--"Sealing Fate: Tremendous Garrison Resources"
		[GetLocalizedQuestNameByID(36057)] = false,	--"Sealing Fate: Honor"
		[GetLocalizedQuestNameByID(36055)] = false,	--"Sealing Fate: Apexis Crystals"
		[GetLocalizedQuestNameByID(37452)] = false,	--"Sealing Fate: Heap of Apexis Crystals"
		[GetLocalizedQuestNameByID(37453)] = false,	--"Sealing Fate: Mountain of Apexis Crystals"
	}

	addon.db_defaults.profile.reward = {	--DB Defaults for ones with selectable rewards
		--== Burning Crusade ==--
		[GetLocalizedQuestNameByID(11379)] = -1,	--"Super Hot Stew"
		[GetLocalizedQuestNameByID(11381)] = -1,	--"Soup for the Soul"
		[GetLocalizedQuestNameByID(11377)] = -1,	--"Revenge is Tasty"
		[GetLocalizedQuestNameByID(11380)] = -1,	--"Manalicious"
		[GetLocalizedQuestNameByID(11515)] = -1,	--"Blood for Blood"
		[GetLocalizedQuestNameByID(11544)] = -1,	--"Ata'mal Armaments"
	
		--== Wrath of the Lich King ==--
		[GetLocalizedQuestNameByID(13789)] = -1,	--"Taking Battle To The Enemy"
		[GetLocalizedQuestNameByID(13861)] = -1,	--"Battle Before The Citadel"
		[GetLocalizedQuestNameByID(13682)] = -1,	--"Threat From Above"
		[GetLocalizedQuestNameByID(13790)] = -1,	--"Among the Champions"
		
		--Thx Holliday
		[GetLocalizedQuestNameByID(14061)] = -1,	--"Can't Get Enough Turkey"
		[GetLocalizedQuestNameByID(14062)] = -1,	--"Don't Forget The Stuffing!"
		[GetLocalizedQuestNameByID(14060)] = -1,	--"Easy As Pie",
		[GetLocalizedQuestNameByID(14058)] = -1,	--"She Says Potato"
		[GetLocalizedQuestNameByID(14059)] = -1,	--"We're Out of Cranberry Chutney Again?"
	
		--== Mists of Pandaria ==--
		[GetLocalizedQuestNameByID(33374)] = -1,	--"Path of the Mistwalker"
	
		--== Mists of Pandaria ==--
		[GetLocalizedQuestNameByID(37270)] = -1, --"Alchemy Experiment"
		[GetLocalizedQuestNameByID(38175)] = -1, --"Scrap Meltdown"
		[GetLocalizedQuestNameByID(38188)] = -1, --"Scrap Meltdown"
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
	-- 116404 "Pilgrim's Bounty"
	local thxgivingRewards = { [-1] = NONE, 46723, 46800, 44785, 46824, 44788, 116404 }
	
	--== Mists of Pandaria ==--
	-- 103643 "Dew of Eternal Morning"
	-- 103642 "Book of the Ages"
	-- 103641 "Singing Crystal"
	local pathOfTheMistwalkerRewards = { [-1] = NONE, 103643, 103642, 103641 }
	
	--== Warlords of Draenor ==--
	-- 122453 "Draenic Agility Potion"
	-- 122451 "Draenic Invisibility Potion"
	-- 122454 "Draenic Intellect Potion"
	-- 122452 "Draenic Swiftness Potion"
	-- 122455 "Draenic Strength Potion"
	-- 122456 "Draenic Armor Potion"
	local alchemyExperimentRewards = { [-1] = NONE, 122453, 122451, 122454, 122452, 122455, 122456 }
	
	-- 120301 "Armor Enhancement Token"
	-- 120302 "Weapon Enhancement Token"
	local scrapMeltdownRewards = { [-1] = NONE, 120301, 120302 }
	

	addon.db_defaults.global.reward = {	--DB Globals for reward list
		--== Burning Crusade ==--
		--Cooking
		[GetLocalizedQuestNameByID(11379)] = bc_cookingRewards, --"Super Hot Stew"
		[GetLocalizedQuestNameByID(11381)] = bc_cookingRewards, --"Soup for the Soul"
		[GetLocalizedQuestNameByID(11377)] = bc_cookingRewards, --"Revenge is Tasty"
		[GetLocalizedQuestNameByID(11380)] = bc_cookingRewards, --"Manalicious"
		
		--SSO
		[GetLocalizedQuestNameByID(11515)] = ssoRewards, --"Blood for Blood"
		
		--Ata'mal
		[GetLocalizedQuestNameByID(11544)] = atamalRewards, --"Ata'mal Armaments"
		
		--== Wrath Of the Lich King ==--
		--Argent Tourny
		[GetLocalizedQuestNameByID(13789)] = champQuestRewards, --"Taking Battle To The Enemy"
		[GetLocalizedQuestNameByID(13861)] = champQuestRewards, --"Battle Before The Citadel"
		[GetLocalizedQuestNameByID(13682)] = champQuestRewards, --"Threat From Above"
		[GetLocalizedQuestNameByID(13790)] = champQuestRewards, --"Among the Champions"
		
		--Thx Holliday
		[GetLocalizedQuestNameByID(14061)] = thxgivingRewards,	--"Can't Get Enough Turkey"
		[GetLocalizedQuestNameByID(14062)] = thxgivingRewards,	--"Don't Forget The Stuffing!"
		[GetLocalizedQuestNameByID(14060)] = thxgivingRewards,	--"Easy As Pie",
		[GetLocalizedQuestNameByID(14058)] = thxgivingRewards,	--"She Says Potato"
		[GetLocalizedQuestNameByID(14059)] = thxgivingRewards,	--"We're Out of Cranberry Chutney Again?"
		
		--== Mists of Pandaria ==--
		[GetLocalizedQuestNameByID(33374)] = pathOfTheMistwalkerRewards, --"Path of the Mistwalker"
		
		--== Warlords of Draenor ==--
		[GetLocalizedQuestNameByID(37270)] = alchemyExperimentRewards, --"Alchemy Experiment"
		[GetLocalizedQuestNameByID(38175)] = scrapMeltdownRewards, --"Scrap Meltdown"
		[GetLocalizedQuestNameByID(38188)] = scrapMeltdownRewards, --"Scrap Meltdown"
	}
	
	local specialFixQuestList = {
		[11006] = true,	--More Shadow Dust
		[12618] = true, --Blessing of Zim'Torga


		--Shadowland callings
		[60450] = true,
		[60452] = true,
		[60454] = true,
		[60456] = true,
		[60449] = true,
		[60395] = true,
		[60430] = true,
		[60418] = true,
		[60435] = true,
		[60455] = true,
		[60424] = true,
		[60415] = true,
		[60448] = true,
		[60403] = true,
		[60400] = true,
		[62692] = true,
		[62693] = true,
		[60420] = true,
		[60392] = true,
		[60422] = true,
		[62691] = true,
		[60434] = true,
		[60388] = true,
		[60383] = true,
		[60442] = true,
		[62694] = true,
		[60441] = true,
		[60447] = true,
		[60410] = true,
		[60423] = true,
		[60419] = true,
		[60401] = true,
		[60439] = true,
		[60437] = true,
		[60425] = true,
		[60431] = true,
		[60458] = true,
		[60429] = true,
		[60397] = true,
		[60404] = true,
		[60444] = true,
		[60408] = true,
		[60446] = true,
		[60445] = true,
		[60387] = true,
		[60457] = true,
		[60407] = true,
		[60402] = true,
		[60391] = true,
		[60432] = true,
		[60421] = true,
		[60427] = true,
		[60396] = true,
		[60459] = true,
		[60460] = true,
		[60414] = true,
		[60416] = true,
		[60393] = true,
		[60386] = true,
		[60438] = true,
		[60405] = true,
		[60399] = true,
		[60443] = true,
		[60426] = true,
		[60390] = true,
		[60398] = true,
		[60465] = true,
		[60412] = true,
		[60409] = true,
		[60385] = true,
		[60433] = true,
		[60384] = true,
		[60436] = true,
		[60358] = true,
		[60417] = true,
		[60380] = true,
		[60440] = true,
		[60377] = true,
		[60381] = true,
		[60372] = true,
		[60411] = true,
		[60406] = true,
		[60464] = true,
		[60394] = true,
		[60382] = true,
		[60369] = true,
		[60389] = true,
		[60463] = true,
		[60378] = true,
		[60462] = true,
		[60365] = true,
		[60375] = true,
		[60373] = true,
		[60376] = true,
		[60364] = true,
		[60371] = true,
		[60379] = true,
		[60363] = true,
		[60370] = true,
		[60374] = true,

		--Shadowlands pvp quests
		[62287] = true,
		[62284] = true,
		[62286] = true,
		[62288] = true,
		[62285] = true,

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