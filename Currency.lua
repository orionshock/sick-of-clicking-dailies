--
--	Currency Module
--
--
--
local AddonName, AddonParent = ...

local module = AddonParent:NewModule("CURRENCY", "AceEvent-3.0")
local addon = AddonParent
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

	self:RegisterEvent("CHAT_MSG_COMBAT_HONOR_GAIN","Honorevent")
	self:RegisterEvent("CHAT_MSG_CURRENCY","Currencyevent")

end

function module:OnDisable()
	self:Debug("OnDisable")
end


local function GetGossipOptGroup(title)
	if title then
		return { name = title or qtitle, type = "toggle", arg = arg, width = "full" }
	end
end

function module:SOCD_QuestByID_Ready(event, ...)
	self:Debug(event, ...)


	local opts = {
		name = "Currency",
		type = "group",
		handler = self,
		get = "QuestOptGet",
		set = "QuestOptSet",
		args = {
			["Valor Point Tracking"] = GetGossipOptGroup( "Valor Point Tracking"),
			["Justice Point Tracking"] = GetGossipOptGroup( "Justice Point Tracking"),
			["Conquest Point Tracking"] = GetGossipOptGroup( "Conquest Point Tracking"),
			["Honor Point Tracking"] = GetGossipOptGroup( "Honor Point Tracking"),
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
if dbLoc["Valor Point Tracking"] == nil then
	dbLoc["Valor Point Tracking"] = true
end
if dbLoc["Justice Point Tracking"] == nil then
	dbLoc["Justice Point Tracking"] = true
end
if dbLoc["Conquest Point Tracking"] == nil then
	dbLoc["Conquest Point Tracking"] = true
end
if dbLoc["Honor Point Tracking"] == nil then
	dbLoc["Honor Point Tracking"] = true
end

end


function module:QuestOptGet(info, ...)
	--self:Debug("QuestOptGet", db.profile.QuestRewardOptions[ info.option.name ] )
	if info.arg then
		return self:GetSetGossipStatus(info.arg)
	end
	return db.profile.QuestStatus[ info.option.name ] 
end

function module:QuestOptSet(info, value, ...)
	--self:Debug("QuestOptSet", info.option.name, value)
	if info.arg then
		self:GetSetGossipStatus(info.arg, value)
		return
	end
	db.profile.QuestStatus[ info.option.name ]  = value
end

function module:Honorevent(event, arga)
	local honorgained = string.match(arga,"You have been awarded (%d+)%.00 honor points%.")
	if honorgained then
	honorgained = tonumber(honorgained)
	local hasRandomBGWin,HolidayHonorAmount = GetRandomBGHonorCurrencyBonuses()
	if hasRandomBGWin then
	HolidayHonorAmount = HolidayHonorAmount * 2
	end
	--DEFAULT_CHAT_FRAME:AddMessage("B x " .. arga .. " x " ..honorgained .. " x " .. HolidayHonorAmount)
	if honorgained == HolidayHonorAmount then
	addon:SendMessage("SOCD_DAILIY_QUEST_COMPLETE", "Battleground Victory" )
	--DEFAULT_CHAT_FRAME:AddMessage("DebugD")
	end
	end
end
function module:Currencyevent(event, arga)
local points = nil
local pointstotal = nil
if db.profile.QuestStatus["Honor Point Tracking"] then
points = string.match(arga,"You receive currency: |.+|Hcurrency:.+%[Honor Points%].+x(%d+)%.")
end
if points then 
DEFAULT_CHAT_FRAME:AddMessage("E x Honor" ..points) 
for k, v in pairs(db.char.questsCompleted) do
	pointstotal = string.match(k,"Honor Points (%d+)")
		if pointstotal then	
			db.char.questsCompleted[k] = nil 
			db.factionrealm[UnitName("player")][k] = nil
			pointstotal = pointstotal + points
			break
		end
end
if not pointstotal then pointstotal = points end
addon.SpecialQuestResets["Honor Points " .. pointstotal] = "GetNextWGReset"
addon:SendMessage("SOCD_DAILIY_QUEST_COMPLETE", "Honor Points "..pointstotal )
end
if db.profile.QuestStatus["Conquest Point Tracking"] then
points = string.match(arga,"You receive currency: |.+|Hcurrency:.+%[Conquest Points%].+x(%d+)%.")
else
points = nil
end

if points then 
--DEFAULT_CHAT_FRAME:AddMessage("E x Conquest" ..points) 
pointstotal = nil
for k, v in pairs(db.char.questsCompleted) do
	pointstotal = string.match(k,"Conquest Points (%d+)")
		if pointstotal then	
			db.char.questsCompleted[k] = nil 
			db.factionrealm[UnitName("player")][k] = nil
			pointstotal = pointstotal + points
			break
		end
end
if not pointstotal then pointstotal = points end
addon.SpecialQuestResets["Conquest Points " .. pointstotal] = "GetNextWGReset"
addon:SendMessage("SOCD_DAILIY_QUEST_COMPLETE", "Conquest Points "..pointstotal )
end
if db.profile.QuestStatus["Justice Point Tracking"] then
points = string.match(arga,"You receive currency: |.+|Hcurrency:.+%[Justice Points%].+x(%d+)%.")
else
points = nil
end
if points then 
--DEFAULT_CHAT_FRAME:AddMessage("E x Justice" ..points) 
pointstotal = nil
for k, v in pairs(db.char.questsCompleted) do
	pointstotal = string.match(k,"Justice Points (%d+)")
		if pointstotal then	
			db.char.questsCompleted[k] = nil 
			db.factionrealm[UnitName("player")][k] = nil
			pointstotal = pointstotal + points
			break
		end
end
if not pointstotal then pointstotal = points end
addon.SpecialQuestResets["Justice Points " .. pointstotal] = "GetNextWGReset"
addon:SendMessage("SOCD_DAILIY_QUEST_COMPLETE", "Justice Points "..pointstotal )
end
if db.profile.QuestStatus["Valor Point Tracking"] then
points = string.match(arga,"You receive currency: |.+|Hcurrency:.+%[Valor Points%].+x(%d+)%.")
else
points = nil
end
if points then 
--DEFAULT_CHAT_FRAME:AddMessage("E x Valor" ..points) 
pointstotal = nil
for k, v in pairs(db.char.questsCompleted) do
	pointstotal = string.match(k,"Valor Points (%d+)")
		if pointstotal then	
			db.char.questsCompleted[k] = nil 
			db.factionrealm[UnitName("player")][k] = nil
			pointstotal = pointstotal + points
			break
		end
end
if not pointstotal then pointstotal = points end
addon.SpecialQuestResets["Valor Points " .. pointstotal] = "GetNextWGReset"
addon:SendMessage("SOCD_DAILIY_QUEST_COMPLETE", "Valor Points "..pointstotal )
end

--local printable = gsub(arga, "\124", "\124\124");
--DEFAULT_CHAT_FRAME:AddMessage("Q x " .. printable)
end