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
function module:AddQuest(name)
	local e = "AddQuest"
	--print(e, "AddQuest()", name)
	local found = false
	for pack, list in pairs(AddonParent.moduleQLookup) do
		local s = list[name] or list[name] == false
		--print(e, "Pack:", pack, "isListed?:", s)
		if list[name] or list[name] == false then
			--print(e, "Found quest", name, "in pack", pack)
			if pack ~= "RRQ" then
				--print(e, "Not RRQ Pack, set found = true")
				found = true
			end
		end
	end
	if not found then
		--print(e, "quest not found in other packs, adding")
		db.profile[name] = true
		return true
	end
	--print(e, "returning false")
	return false
end

function module:AddNPCID(id)
	D("addNCP?")
	if not tostring(id) then return end
	id = tostring(id)
	if self.npcList:find(id) then
		D("npc Added already")
		return false
	else
		self.npcList = self.npcList..":"..tostring(id)
		AddonParent:RegisterQuests("RRQ", db.profile, self.npcList, db.profile.qOptions, db.profile.gossip )
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
	local e = "CB~OC"
	local checked, quest, guid = self:GetChecked(), GetTitleText(), UnitGUID("target")
	--print(e, "inital Standing", checked, quest, guid)
	if quest then
		--print(e, "have quest:", quest)
		if checked and guid then
			--print(e, "It is checked, and has a GUID", checked, guid)
			if db.profile[quest] or db.profile[quest] == false then
				--print(e, "Quest has been set before, as we're checked, toggle true")
				db.profile[quest] = true

			elseif db.profile[quest] == nil then
				--print(e, "Quest not seen before, quiry to add quest")
				if module:AddQuest(quest) then
					--print(e, "Quest not in other db's, add it's NPCID too")
					module:AddNPCID( tonumber( strsub( guid, -12, -7), 16) )

				else
					--print(e, "quest found elsewhere, returning")
					self:SetChecked(false)
					return
				end
			end
		else
			--print(e, "No quest:", quest, "or no GUID:", guid)
			self:SetChecked(false)
		end
		if not checked then
			--print(e, "not checked, disabling it")
			db.profile[quest] = false
		end
	end
end
local GameTooltip = GameTooltip
local function CheckButton_OnEnter(self)
	GameTooltip:ClearAllPoints()
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
	GameTooltip:AddLine(L["Quests that have no NPC or have quest choice rewards will automatically be ignored"])
	GameTooltip:AddLine(L["This Option is also not retroactive"])
	GameTooltip:Show()
end

local function CheckButton_OnLeave(self)
	GameTooltip:Hide()
end


local function SOCD_OnEvnet(frame, event, ...)
	--if event ~= "QUEST_COMPLETE" or "QUEST_DETAIL" then
	--	D("Event not QuestCOMPLETE hiding", event)
	--	return frame:Hide()
	--end	--
	if GetQuestItemInfo("choice",1) ~= "" then
		D("Quest has choices, exiting")
		return frame:Hide()
	end	--if there is a reward choice then not eligible
	local quest = GetTitleText()
	frame:Show()
	frame.check:SetChecked(db.profile[quest])
	D("OnEvent", "EoC", quest, "shown:", frame:IsShown(), "checked:", frame.check:GetChecked())
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
	frame:SetScript("OnEvent", SOCD_OnEvnet)
	check:SetScript("OnClick", CheckButton_OnClick)
	check:SetScript("OnEnter", CheckButton_OnEnter)
	check:SetScript("OnLeave", CheckButton_OnLeave)

	self.frame = frame
end

function module:GetOptionsTable()
	local options = {
		name = L["RRQ"],
		type = "group",
		handler = module,
		get = "Multi_Get",
		set = "Multi_Set",
		order =4 ,
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