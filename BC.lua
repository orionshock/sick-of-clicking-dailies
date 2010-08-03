--[[
	Burning Crusade Module

	netherwing
	shat'ar skyguard
	ogrila
	cooking
	fishing
]]--

local AddonName, AddonParent = ...
local module = AddonParent:NewModule("BC")
local L = LibStub("AceLocale-3.0"):GetLocale(AddonName)
local db
--local GT = LibStub("AceLocale-3.0"):GetLocale("SOCD_GossipText")
local GetLocalizedQuestNameByID = AddonParent.GetLocalizedQuestNameByID

function module:OnInitialize()
	self:Debug("OnInit")
	AddonParent.RegisterMessage(module, "SOCD_QuestByID_Ready")
end

function module:OnEnable()
	self:Debug("OnEnable")

	SetItemRef("item:30809","item:30809")	--Aldor Mark
	SetItemRef("item:30809","item:30809")

	SetItemRef("item:30810","item:30810")	--Scryer Mark
	SetItemRef("item:30810","item:30810")

	SetItemRef("item:34538","item:34538")	--Melee weapon
	SetItemRef("item:34538","item:34538")

	SetItemRef("item:34539","item:34539")	--Caster weapon
	SetItemRef("item:34539","item:34539")

	SetItemRef("item:33844","item:33844")	--Barrel of Fish
	SetItemRef("item:33844","item:33844")

	SetItemRef("item:33857","item:33857")	--Crate Of Meat
	SetItemRef("item:33857","item:33857")

	db = AddonParent.db
end

function module:OnDisable()
	D("OnDisable")
end

local function GetOptionGroup(id, ...)
	local title = GetLocalizedQuestNameByID(id)
	if title then
		return { name = title , type = "select", values = { [-1] = NONE, ...} }
	else
		return { name = "QuestID: "..id , type = "select", values = { [-1] = NONE, ...} }
	end
end

function module:SOCD_QuestByID_Ready(event, ...)
	--self:Debug(event, ...)
	--Create Options Table
	local opts = {
		name = L["Burning Crusade"],
		type = "group",
		handler = self,
		get = "QuestOptGet",
		set = "QuestOptSet",
		args = {
			Cooking = { type = "group", name = L["Cooking"], inline = true,
				args = {
					["SuperHotStew"] = GetOptionGroup( 11379 , (GetItemInfo(33844)) or "Barrel of Fish", (GetItemInfo(33857)) or "Crate Of Meat" ) ,
					["SoupForTheSoul"] = GetOptionGroup( 11381 , (GetItemInfo(33844)) or "Barrel of Fish", (GetItemInfo(33857)) or "Crate Of Meat" ) ,
					["RevengeIsTasty"] = GetOptionGroup( 11377 , (GetItemInfo(33844)) or "Barrel of Fish", (GetItemInfo(33857)) or "Crate Of Meat" ) ,
					["Manalicious"] = GetOptionGroup( 11380 , (GetItemInfo(33844)) or "Barrel of Fish", (GetItemInfo(33857)) or "Crate Of Meat" ) ,
				},
			},
			SSO = { type = "group", name = L["SSO Quests"], inline = true,
				args = {
					["BloodForBlood"] = GetOptionGroup( 11515  , (GetItemInfo(30809)) or "Aldor Mark", (GetItemInfo(30810)) or "Scryer Mark") ,
					["AtamalArmaments"] = GetOptionGroup( 11544 , (GetItemInfo(34538)) or "Other Oil" , (GetItemInfo(34539)) or "Caster Oil")
				},
			},
		},
	}
	self.options = opts	--Set it onto the main of the module, it'll be picked up later.

	--Handle the special quests we do and exclude them.
	local moduleSpecialQuests = {
		[ L["Candy Bucket"] ] = "Exclude",
	}
	for k,v in pairs(moduleSpecialQuests) do
		AddonParent.SpecialQuestResets[k] = v
	end


	--Quests That need to be dsabled by default.
	local dbLoc = AddonParent.db.profile.QuestStatus	--Cache the DB location on this.
	local tempTitle = GetLocalizedQuestNameByID(11545)	--"A Charitable Donation"
	dbLoc[ tempTitle ] = dbLoc[ tempTitle ] or false

	tempTitle = GetLocalizedQuestNameByID(11548)	--"Your Continued Support"
	dbLoc[ tempTitle ] = dbLoc[ tempTitle ] or false

	--Quest with reward options that need to be defaulted.
	dbLoc = AddonParent.db.profile.QuestRewardOptions	--Recache the new location for the next section

	tempTitle = GetLocalizedQuestNameByID(11379)	--SuperHotStew
	dbLoc[tempTitle] = dbLoc[tempTitle] or -1

	tempTitle = GetLocalizedQuestNameByID(11381)	--SoupForTheSoul
	dbLoc[tempTitle] = dbLoc[tempTitle] or -1

	tempTitle = GetLocalizedQuestNameByID(11377)	--RevengeIsTasty
	dbLoc[tempTitle] = dbLoc[tempTitle] or -1

	tempTitle = GetLocalizedQuestNameByID(11380)	--Manalicious
	dbLoc[tempTitle] = dbLoc[tempTitle] or -1

	tempTitle = GetLocalizedQuestNameByID(11515)	--BloodForBlood
	dbLoc[tempTitle] = dbLoc[tempTitle] or -1

	tempTitle = GetLocalizedQuestNameByID(11544)	--AtamalArmaments
	dbLoc[tempTitle] = dbLoc[tempTitle] or -1

end

function module:QuestOptGet(info, ...)
	--self:Debug("QuestOptGet", db.profile.QuestRewardOptions[ info.option.name ] )
	return db.profile.QuestRewardOptions[ info.option.name ] 
end

function module:QuestOptSet(info, value, ...)
	--self:Debug("QuestOptSet", info.option.name, value)
	db.profile.QuestRewardOptions[ info.option.name ]  = value
end



