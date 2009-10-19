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
--		npcList = "",
	},
}


function module:OnInitialize()
	db = AddonParent.db:RegisterNamespace("RRQ", module.defaults)
	self.db = db
	self:CreateInteractionFrame()
	self.frame:SetScript("OnShow", self.frame.Hide)
end

function module:OnEnable()
	D("OnEnable")
	AddonParent:RegisterQuests("RRQ", db.profile, db.profile.npcList, db.profile.qOptions, db.profile.gossip )
	self.frame:RegisterEvent("QUEST_DETAIL")
	self.frame:RegisterEvent("QUEST_COMPLETE")
	self.frame:RegisterEvent("QUEST_FINISHED")
	self.frame:SetScript("OnShow", nil)
	db.RegisterCallback(self, "OnProfileChanged", "RefreshConfig")
	db.RegisterCallback(self, "OnProfileCopied", "RefreshConfig")
	db.RegisterCallback(self, "OnProfileReset", "RefreshConfig")

end

function module:RefreshConfig(event, db, newProfile)
	D(self:GetName(), event, newProfile)
	if db.profile.modules.RRQ then
		self:Enable()
	else
		self:Disable()
	end
	if self:IsEnabled() then
		AddonParent:UnRegisterQuests("RRQ")
		AddonParent:RegisterQuests("RRQ", db.profile, db.profile.qOptions, db.profile.gossip )
	end
end

function module:OnDisable()
	D("OnDisable")
	AddonParent:UnRegisterQuests("RRQ")
	self.frame:UnregisterEvent("QUEST_DETAIL")
	self.frame:UnregisterEvent("QUEST_COMPLETE")
	self.frame:UnregisterEvent("QUEST_FINISHED")
	self.frame:Hide()
	self.frame:SetScript("OnShow", self.frame.Hide)
end
function module:AddQuest(e, name)
	e = e.."~AddQuest"
--	local found = false
	D(e, "parsing parent db for quest handled by other module")
	for pack, list in pairs(AddonParent.moduleQLookup) do
		D(e, "Checking:", pack)
		local s = (list[name] == true) or (list[name] == false)
		if s then
			if pack ~= "RRQ" then
				D(e, "Found Quest handled by other module:", pack, "Returning false on AddQuest")
				return false
			end
		end
	end
	D(e, "Quest not handled by other modules, add quest, returning true")
	db.profile[name] = true
	return true
end

function module:AddNPCID(e, id)
	e = e.."~AddNPC"
	id = tostring(id)
	D(e, "ID:", id)
	if db.profile.npcList:find(id) then
		D(e, "ID found in list, return false, Happens when 1 npc has many quests.")
		return false
	else
		D(e, "ID not found already, adding")
		db.profile.npcList = db.profile.npcList..":"..tostring(id)
		AddonParent:RegisterQuests("RRQ", db.profile, db.profile.npcList, db.profile.qOptions, db.profile.gossip )
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
	local e = "OnClick"
	local checked, quest, guid = self:GetChecked(), GetTitleText(), UnitGUID("target")
	D(e, "Status:", checked, "Quest:", quest, "ID:", guid)
	if quest then
		D(e, "Has Quest:", quest)
		if checked and guid then
			D(e, "IsChecked:", checked, "ID:", guid, "QuestStatus:", db.profile[quest])
			if db.profile[quest] or db.profile[quest] == false then
				db.profile[quest] = true
				D(e,"Set", quest, "true")
				D(e, "RETURN END")
				return
			elseif db.profile[quest] == nil then
				D(e, "QuestNotListed, Adding...")
				if module:AddQuest(e, quest) then
					D(e, "QuestAdded, adding ID", tonumber( strsub( guid, -12, -7), 16))
					module:AddNPCID(e, tonumber( strsub( guid, -12, -7), 16) )
					D(e, "ID Added")
					D(e, "RETURN END")
					return
				else
					D("Can't Add Quest, set unChecked")
					self:SetChecked(false)
					print("|cff9933FFSickOfClickingDailies:|r Quest: ", quest, " is already handeld by another module")
					D(e, "RETURN END")
					return
				end
			end
		else
			D(e, "Not Checked or No GUID, Quest Not eligibale")
			self:SetChecked(false)
		end
		if (not checked) and (db.profile[quest]) then
			D(e, "Quest In DB, and was enabled, disabling it")
			db.profile[quest] = false
		end
	end
	D(e, "END")
end
local GameTooltip = GameTooltip
local function CheckButton_OnEnter(self)
	GameTooltip:ClearAllPoints()
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
	GameTooltip:AddLine(L["Quests that have no NPC or have quest choice rewards will automatically be ignored"])
	GameTooltip:AddLine(L["This option is also not retroactive"])
	GameTooltip:Show()
end

local function CheckButton_OnLeave(self)
	GameTooltip:Hide()
end

local fe = "fe!"
local showEvents = {
	["QUEST_DETAIL"] = true,
	["QUEST_COMPLETE"] = true,
	["QUEST_FINISHED"] = true,
}

local function SOCD_OnEvnet(self, event, ...)
	if not showEvents[event] then D("Not Show Event", event) self:Hide() return end
	if not module:IsEnabled() then
		D(e, "module off, hiding frame")
		self:Hide()
		return
	end
	local e = fe..event
	local quest = GetTitleText()
	if GetQuestItemInfo("choice",1) ~= "" then --if there is a reward choice then not eligible
		D(e, "Quest has turn in choices, hide frame")
		return self:Hide()
	end	
	if quest then
		D(e, "Has Quest? show frame & set option")
		self:Show()
		self.check:SetChecked(db.profile[quest])
	end
	D(e, "END")
end

function module:CreateInteractionFrame()
	--BaseFrame
	local frame = CreateFrame("frame", "SOCD_tFrame", QuestFrame)
	frame:SetWidth(200)
	frame:SetHeight(50)
	frame:SetPoint("TOPLEFT", QuestFrame, "TOPRIGHT", -25, -15)
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
			quests = {type = "multiselect", name = L["RRQ Listed Quests"], order = 1,
				values = "GetRRQListing",
			},
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

local tmpTbl = {}
function module:GetRRQListing(info)
	wipe(tmpTbl)
	for k,v in pairs(db.profile) do
		if type(v) == "boolean" then
			tinsert(tmpTbl, k)
		end
	end
	table.sort(tmpTbl)
	return tmpTbl
end

function module:GetQuestOption(info)
	return db.profile.qOptions[info.option.name]
end

function module:SetQuestOption(info, val)
	db.profile.qOptions[info.option.name] = val
end

function module:Multi_Get(info,value, ...)
	value = tmpTbl[value]
	return db.profile[value]
end

function module:Multi_Set(info, value, state, ...)
	value = tmpTbl[value]
	db.profile[value] = state
end
