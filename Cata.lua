--
--	Cataclysm Module
--
--
--
local AddonName, AddonParent = ...

local module = AddonParent:NewModule("CATA")
local L = LibStub("AceLocale-3.0"):GetLocale(AddonName)
local GT = LibStub("AceLocale-3.0"):GetLocale(AddonName.."GossipText")
local db


function module:OnInitialize()
	self:Debug("OnInit")
	AddonParent.RegisterMessage(module, "SOCD_QuestByID_Ready")
	db = AddonParent.db
end

function module:OnEnable()
	self:Debug("OnEnable")

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
		return { name = title or qtitle, type = "toggle", arg = arg, width = "full" }
	end
end

function module:SOCD_QuestByID_Ready(event, ...)
	self:Debug(event, ...)


	local opts = {
		name = "Cataclysm",
		type = "group",
		handler = self,
		get = "QuestOptGet",
		set = "QuestOptSet",
		args = {
			gossipOpts = { name = GOSSIP_OPTIONS, type = "group",
				args = {
					["GlopSonOfGlop"] = GetGossipOptGroup( "Glop, Son of Glop", 28390 , "I'm ready when you are, Norsala."),
				},
			},
		},
	}
	self.options = opts
	
	---Special Reset Quests :)
	local moduleSpecialQuests = {

	}
	for k,v in pairs(moduleSpecialQuests) do
		AddonParent.SpecialQuestResets[k] = v
	end
	self:ApplyDefaults(event, db)
end


function module:ApplyDefaults(event, idb, profileName)
	db = idb
	local dbLoc = db.profile.QuestStatus	--Cache the DB location on this.
	local tempTitle
	dbLoc = db.profile.GossipAutoSelect
if dbLoc["I'm ready when you are, Norsala."] == nil then
	self:AddGossipAutoSelect("I'm ready when you are, Norsala.", true)
end

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
