--
--	Repeatable Reputation Quests Module
--
--
--

local AddonParent = LibStub("AceAddon-3.0"):GetAddon("SickOfClickingDailies")

local D		--Basic Debug
do
	function D(arg, ...)
		local str = ""
		if type(arg) == "string" and string.find(arg, "%%") then
			str = arg:format(...)
		else
			str = string.join(", ", tostringall(arg, ...) )
			str = str:gsub(":,", ":"):gsub("=,", "=")
		end
		if AddonParent.db and AddonParent.db.profile.debug then		
			print("|cff9933FFSOCD-RRQ:|r "..str)
		end
		return str
	end
end

local module = AddonParent:NewModule("RRQ")
local L = LibStub("AceLocale-3.0"):GetLocale("SOCD_Core")
--local LQ = LibStub("AceLocale-3.0"):GetLocale("SOCD_RRQ")
local LQ = {}
local db


module.defaults = {
	profile = {
		--This Table will get auto gened by the next block from the locale data
		qOptions = {
			--["*"] = 3,
			--This section has to be manually set with the localized quest name and a default option of off
			--not very many of these quests so it won't matter :D
		},
		gossip = {},
		npcList = "",
	},
}

do
	local profile = module.defaults.profile
	for k,v in pairs(LQ) do
		profile[v] = true
	end
end


function module:OnInitialize()
	--D("OnInit")
	db = AddonParent.db:RegisterNamespace("RRQ", module.defaults)
	self.db = db
	self.npcList = db.profile.npcList
	self:CreateInteractionFrame()
end

function module:OnEnable()
	--D("OnEnable")
	AddonParent:RegisterQuests("RRQ", db.profile, self.npcList, db.profile.qOptions, db.profile.gossip )
end

function module:OnDisable()
	--D("OnDisable")
	AddonParent:UnRegisterQuests("RRQ")
	db.profile.npcList = self.npcList
end

function module:AddNPCID(id)
	D("addNCP?")
	if not tostring(id) then return end
	id = tostring(id)
	if self.npcList:find(id) then
		D("npc Added already")
		return false
	else
		self.npcList = self.npcList..":"..(tostring(id) or "")
		D("added", id, "to npcID list for", self:GetName())
	end
	return true		
end

local backdrop = {
	bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
	edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
	edgeSize = 32,
	tileSize = 32,
	tile = true,
	insets = { left = 11, right = 12, top = 12, bottom = 11 },
}

local function CheckButton_OnClick(self, button)
	local checked, quest = self:GetChecked(), GetTitleText()
	if quest then
		if checked then
			--We are going to Auto Exclude Quests that have choice Reqards from being eligibale in the auto turn in proccess.
			db[quest] = true
			module:AddNPCID( tonumber( strsub( UnitGUID("target"), -12, -7), 16) )
		end
	end
end


local function frame_OnEvnet(self, event, ...)
	if event ~= "QUEST_COMPLETE" then return self:Hide() end
	local quest = GetTitleText()
	self.check:SetChecked(db[quest])
end

function module:CreateInteractionFrame()
	--BaseFrame
	local frame = CreateFrame("frame", "SOCD_tFrame", QuestFrame)
	frame:SetPoint("TOPLEFT", QuestFrame, "TOPRIGHT")
	frame:SetWidth(200)
	frame:SetHeight(50)
	--frame:SetPoint("LEFT", QuestFrame, "RIGHT")
	frame:SetBackdrop(backdrop)

	--CheckBox
	local check = CreateFrame("CheckButton", "SOCD_cButton", frame)
	check:SetWidth(35)
	check:SetHeight(35)
	check:SetPoint("LEFT", frame, "LEFT", 10, 0)
	check:SetNormalTexture("Interface\\Buttons\\UI-CheckBox-Up");
	check:SetPushedTexture("Interface\\Buttons\\UI-CheckBox-Down"); 
	check:SetHighlightTexture("Interface\\Buttons\\UI-CheckBox-Highlight", "ADD");
	check:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check");

	--FontString
	local text = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	text:SetPoint("LEFT", check, "RIGHT", 5, 0)
	text:SetText(L["Enable AutoTurn In for this Quest?"])
	frame:SetWidth( text:GetWidth() + 70 )

	--reference on frame
	frame.check = check
	frame.text = text
	frame.addon = self

	frame:RegisterEvent("QUEST_DETAIL")
	frame:RegisterEvent("QUEST_COMPLETE")
	frame:RegisterEvent("QUEST_FINISHED")
	frame:SetScript("OnEvent", frame_OnEvnet)
	check:SetScript("OnClick", CheckButton_OnClick)

	self.frame = frame
end

function module:GetOptionsTable()
	local options = {
		name = L["RRQ"],
		type = "group",
		handler = module,
		get = "Multi_Get",
		set = "Multi_Set",
		order = 1,
		args = {
			hi = { type = "description", name = "Hi", order = 1},
			}, --Top Lvl Args
		}--Top lvl options
	return options
end

--Included for sake of Completeness for single edged quests.
--function module:GetQuestEnabled(info)
--	return db.profile[info.option.name]
--end

--function module:SetQuestEnabled(info, val)
--	db.profile[info.option.name] = val
--end

function module:GetQuestOption(info)
	return db.profile.qOptions[info.option.name]
end

function module:SetQuestOption(info, val)
	db.profile.qOptions[info.option.name] = val
end

function module:Multi_Get(info, value)
	if type(value) == "number" then
		return db.profile[info.option.values[value]]
	else
		return db.profile[value]
	end
end

function module:Multi_Set(info, value, state)
	if type(value) == "number" then
		db.profile[info.option.values[value]] = state
	else
		db.profile[value] = state
	end
end
