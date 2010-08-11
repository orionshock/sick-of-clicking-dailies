--
--	Wrath of the Lich King Module
--
--
--
local AddonName, AddonParent = ...

local module = AddonParent:NewModule("LK")
local L = LibStub("AceLocale-3.0"):GetLocale(AddonName)
local GT = LibStub("AceLocale-3.0"):GetLocale(AddonName.."GossipText")
local db


function module:OnInitialize()
	self:Debug("OnInit")
	AddonParent.RegisterMessage(module, "SOCD_QuestByID_Ready")
end

function module:OnEnable()
	self:Debug("OnEnable")


	SetItemRef("item:46114", "item:46114")	--Champion's Writ
	SetItemRef("item:46114", "item:46114")

	SetItemRef("item:45724", "item:45724")	--Champion's Purse
	SetItemRef("item:45724", "item:45724")
	db = AddonParent.db
	db.RegisterCallback(self, "OnProfileChanged", "ApplyDefaults")
	db.RegisterCallback(self, "OnProfileCopied", "ApplyDefaults")
	db.RegisterCallback(self, "OnProfileReset", "ApplyDefaults")
end

function module:OnDisable()
	self:Debug("OnDisable")
end


local GetLocalizedQuestNameByID = AddonParent.GetLocalizedQuestNameByID
local function GetOptionGroup(id, rewardOptTbl)
	local title = GetLocalizedQuestNameByID(id)
	if title then
		return { name = title , type = "select", values = rewardOptTbl }
	else
		return { name = "QuestID: "..id , type = "select", values = rewardOptTbl }
	end
end
local function GetGossipOptGroup(title, id, arg)
	local qtitle = GetLocalizedQuestNameByID(id)
	if title or qtitle then
		return { name = title or qtitle, type = "toggle", arg = arg }
	end
end

function module:SOCD_QuestByID_Ready(event, ...)
	self:Debug(event, ...)

	local champQuestRewardOpts = { [-1] = NONE, (GetItemInfo(46114)) or "Champion's Writ", (GetItemInfo(45724)) or "Champion's Purse" }
	local thxgivingRewardOpts = { [-1] = NONE, GetItemInfo(46723) or "Pilgrim's Hat", GetItemInfo(46800) or "Pilgrim's Attire",GetItemInfo(44785) or "Pilgrim's Dress",
			GetItemInfo(46824) or "Pilgrim's Robe", GetItemInfo(44788) or "Pilgrim's Boots", GetItemInfo(44812) or "Pilgrim's Shooter",}

	local opts = {
		name = L["Wrath of the Lich King"],
		type = "group",
		handler = self,
		get = "QuestOptGet",
		set = "QuestOptSet",
		args = {
			tournyPre = { name = L["Argent Crusade"], type = "group", inline = true,
				args = {
					["BattleBeforeTheCitadel"] = GetOptionGroup( 13861 , champQuestRewardOpts ),	--"Battle Before The Citadel"
					["ThreatFromAbove"] = GetOptionGroup( 13682 , champQuestRewardOpts ),	--"Threat From Above"
					["AmongTheChampions"] = GetOptionGroup( 13790 , champQuestRewardOpts ),	--"Among the Champions"
					["TakingBattleToTheEnemy"] = GetOptionGroup( 13789 , champQuestRewardOpts ),	--"Taking Battle To The Enemy"
				},
			},
--			thanksgiving = { name = "Thanksgiving Quests", type = "group", inline = true,
--				args = {
--					["CantGetEnoughTurkey"] = GetOptionGroup( 14061 , thxgivingRewardOpts ),	--"Can't Get Enough Turkey"
--					["DontForgetTheStuffing!"] = GetOptionGroup( 14062 , thxgivingRewardOpts ),	--"Don't Forget The Stuffing!"
--					["EasyAsPie"] = GetOptionGroup( 14060 , thxgivingRewardOpts ),	--"Easy As Pie",
--					["SheSaysPotato"] = GetOptionGroup( 14058 , thxgivingRewardOpts ),	-- "She Says Potato"
--					["WereOutofCranberryChutneyAgain"] = GetOptionGroup( 14059 , thxgivingRewardOpts ),	-- "We're Out of Cranberry Chutney Again?"
--				},
--			},	--I'll Deal with this later.. don't really care right now.
			gossipOpts = { name = GOSSIP_OPTIONS, type = "group",
				args = {
					["DefendingYourTitle"] = GetGossipOptGroup( nil, 13423 , GT["Let's do this, sister."]),
					["Joust"] = GetGossipOptGroup( L["Jousting Challenge"], nil, GT["I am ready to fight!"]),
					["GetKraken"] = GetGossipOptGroup( nil, 14108, GT["Mount the Hippogryph and prepare for battle!"]),
					["AlchyApprentice"] = GetGossipOptGroup( nil, 12541, GT["I'm ready to begin. What is the first ingredient you require?"]),
					["IntestFort"] = GetGossipOptGroup( nil, 12509 , GT["Get out there and make those Scourge wish they were never reborn!"]),
					["Slaves2Saronite"] = GetGossipOptGroup( nil, 13302, GT["Go on, you're free.  Get out of here!"]),
					["BombingInICC"] = GetGossipOptGroup( L["Bombing Quests in Icecrown"], nil, GT["Give me a bomber!"]),
					["AssultByGround"] = GetGossipOptGroup( nil, 13284, GT["I'm ready to join your squad on the way to Ymirheim. Let's get moving."]),
					["DefendingWyrmTemp"] = GetGossipOptGroup( nil, 12372, GT["We need to get into the fight. Are you ready?"]),
				},
			},
		},
	}
	self.options = opts
	
	---Special Reset Quests :)
	local moduleSpecialQuests = {
		--Wintergraps PvP Quests
		[GetLocalizedQuestNameByID(13195)] = "GetNextWGReset",	--"A Rare Herb"
		[GetLocalizedQuestNameByID(13199)] = "GetNextWGReset",	--"Bones and Arrows"
		[GetLocalizedQuestNameByID(13222)] = "GetNextWGReset",	--"Defend the Siege"
		[GetLocalizedQuestNameByID(13191)] = "GetNextWGReset",	--"Fueling the Demolishers"
		[GetLocalizedQuestNameByID(13201)] = "GetNextWGReset",	--"Healing with Roses"
		[GetLocalizedQuestNameByID(13202)] = "GetNextWGReset",	--"Jinxing the Walls"
		[GetLocalizedQuestNameByID(13177)] = "GetNextWGReset",	--"No Mercy for the Merciless"
		[GetLocalizedQuestNameByID(13178)] = "GetNextWGReset",	--"Slay them all!"
		[GetLocalizedQuestNameByID(13186)] = "GetNextWGReset",	--"Stop the Siege"
		[GetLocalizedQuestNameByID(13181)] = "GetNextWGReset",	--"Victory in Wintergrasp"
		[GetLocalizedQuestNameByID(13192)] = "GetNextWGReset",	--"Warding the Walls"
		[GetLocalizedQuestNameByID(13198)] = "GetNextWGReset",	--"Warding the Warriors"
		[GetLocalizedQuestNameByID(13538)] = "GetNextWGReset",	--"Southern Sabotage"
		[GetLocalizedQuestNameByID(13539)] = "GetNextWGReset",	--"Toppling the Towers"

		--Raid Weekly Quests
		[GetLocalizedQuestNameByID(24580)] = "GetNextWGReset",	--"Anub'Rekhan Must Die!"
		[GetLocalizedQuestNameByID(24585)] = "GetNextWGReset",	--"Flame Leviathan Must Die!"
		[GetLocalizedQuestNameByID(24587)] = "GetNextWGReset",	--"Ignis the Furnace Master Must Die!"
		[GetLocalizedQuestNameByID(24582)] = "GetNextWGReset",	--"Instructor Razuvious Must Die!"
		[GetLocalizedQuestNameByID(24589)] = "GetNextWGReset",	--"Lord Jaraxxus Must Die!"
		[GetLocalizedQuestNameByID(24590)] = "GetNextWGReset",	--"Lord Marrowgar Must Die!"
		[GetLocalizedQuestNameByID(24584)] = "GetNextWGReset",	--"Malygos Must Die!"
		[GetLocalizedQuestNameByID(24581)] = "GetNextWGReset",	--"Noth the Plaguebringer Must Die!"
		[GetLocalizedQuestNameByID(24583)] = "GetNextWGReset",	--"Patchwerk Must Die!"
		[GetLocalizedQuestNameByID(24586)] = "GetNextWGReset",	--"Razorscale Must Die!"
		[GetLocalizedQuestNameByID(24579)] = "GetNextWGReset",	--"Sartharion Must Die!"
		[GetLocalizedQuestNameByID(24588)] = "GetNextWGReset",	--"XT-002 Deconstructor Must Die!"

		--ICC Weekly Quests
		[GetLocalizedQuestNameByID(24879)] = "GetNextWGReset",	--"Blood Quickening"
		[GetLocalizedQuestNameByID(24875)] = "GetNextWGReset",	--"Deprogramming"
		[GetLocalizedQuestNameByID(24878)] = "GetNextWGReset",	--"Residue Rendezvous"
		[GetLocalizedQuestNameByID(24880)] = "GetNextWGReset",	--"Respite for a Tormented Soul"
		[GetLocalizedQuestNameByID(24877)] = "GetNextWGReset",	--"Securing the Ramparts"

	}
	for k,v in pairs(moduleSpecialQuests) do
		AddonParent.SpecialQuestResets[k] = v
	end
end


function module:ApplyDefaults(db, profileName)

	local dbLoc = db.profile.QuestStatus	--Cache the DB location on this.
	local tempTitle

	--Disabled by default Quests:
	tempTitle = GetLocalizedQuestNameByID(11548)	--"Hand of the Oracles"
	dbLoc[ tempTitle ] = dbLoc[ tempTitle ] or false	--Disabled by request of "Fisker-" in IRC, these 2 quests switch faction

	tempTitle = GetLocalizedQuestNameByID(12582)	--"Frenzyheart Champion"
	dbLoc[ tempTitle ] = dbLoc[ tempTitle ] or false	--Disabled by request of "Fisker-" in IRC, these 2 quests switch faction


	tempTitle = GetLocalizedQuestNameByID(13846)	-- "Contributin' To The Cause"
	dbLoc[ tempTitle ] = dbLoc[ tempTitle ] or false	--AC gold for rep quest

	-----
	dbLoc = db.profile.QuestRewardOptions
	--Default Quest options to -1 to disable them till the user selects something

	tempTitle = GetLocalizedQuestNameByID(13861)	--"Battle Before The Citadel"
	dbLoc[tempTitle] = dbLoc[tempTitle] or -1

	tempTitle = GetLocalizedQuestNameByID(13682)	--"Threat From Above"
	dbLoc[tempTitle] = dbLoc[tempTitle] or -1

	tempTitle = GetLocalizedQuestNameByID(13790)	--"Among the Champions"
	dbLoc[tempTitle] = dbLoc[tempTitle] or -1

	tempTitle = GetLocalizedQuestNameByID(13789)	--"Taking Battle To The Enemy"
	dbLoc[tempTitle] = dbLoc[tempTitle] or -1

	tempTitle = GetLocalizedQuestNameByID(14061)	--"Can't Get Enough Turkey"
	dbLoc[tempTitle] = dbLoc[tempTitle] or -1

	tempTitle = GetLocalizedQuestNameByID(14062)	--"Don't Forget The Stuffing!"
	dbLoc[tempTitle] = dbLoc[tempTitle] or -1

	tempTitle = GetLocalizedQuestNameByID(14060)	--"Easy As Pie",
	dbLoc[tempTitle] = dbLoc[tempTitle] or -1

	tempTitle = GetLocalizedQuestNameByID(14058)	--"She Says Potato"
	dbLoc[tempTitle] = dbLoc[tempTitle] or -1

	tempTitle = GetLocalizedQuestNameByID(14059)	--"We're Out of Cranberry Chutney Again?"
	dbLoc[tempTitle] = dbLoc[tempTitle] or -1

	self:AddGossipAutoSelect(GT["Let's do this, sister."], true)
	self:AddGossipAutoSelect(GT["I am ready to fight!"], true)
	--GT["I am ready to fight!(M)"]
	--GT["I am ready to fight!(F)"]
	self:AddGossipAutoSelect(GT["Mount the Hippogryph and prepare for battle!"], true)
	self:AddGossipAutoSelect(GT["Get out there and make those Scourge wish they were never reborn!"], true)
	self:AddGossipAutoSelect(GT["I'm ready to begin. What is the first ingredient you require?"], true)
	--GT["I'm ready to begin. What is the first ingredient you require?(M)"]	--So the localization Script picks it up
	--GT["I'm ready to begin. What is the first ingredient you require?(F)"]
	self:AddGossipAutoSelect(GT["Go on, you're free.  Get out of here!"], true)
	self:AddGossipAutoSelect(GT["Give me a bomber!"], true)
	self:AddGossipAutoSelect(GT["I'm ready to join your squad on the way to Ymirheim. Let's get moving."], true)
	self:AddGossipAutoSelect(GT["We need to get into the fight. Are you ready?"], true)

end


function module:QuestOptGet(info, ...)
	--self:Debug("QuestOptGet", db.profile.QuestRewardOptions[ info.option.name ] )
	if info.arg then
		return self:GetSetGossipStatus(info.arg)
	end
	return db.profile.QuestRewardOptions[ info.option.name ] 
end

function module:QuestOptSet(info, value, ...)
	--self:Debug("QuestOptSet", info.option.name, value)
	if info.arg then
		self:GetSetGossipStatus(info.arg, value)
		return
	end
	db.profile.QuestRewardOptions[ info.option.name ]  = value
end
