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
			str = str:gsub("[=:'], ", "%1")
		end
		if AddonParent.db and AddonParent.db.global.debug then		
			print("|cff9933FFSOCD-RRQ:|r "..str)
		end
		return str
	end
end

local module = AddonParent:NewModule("RRQ")
local L = LibStub("AceLocale-3.0"):GetLocale("SOCD_Core")
--local LQ = LibStub("AceLocale-3.0"):GetLocale("SOCD_RRQ")
local db, questTable

module.defaults = {
	profile = {
		quests = {
		},
		--This Table will get auto gened by the next block from the locale data
		qOptions = {
			--["*"] = 3,
			--This section has to be manually set with the localized quest name and a default option of off
			--not very many of these quests so it won't matter :D
		},
--		gossip = {},
	},
}


function module:OnInitialize()
	db = AddonParent.db:RegisterNamespace("RRQ", module.defaults)
	questTable = AddonParent.moduleQLookup
	self.db = db
	self:CreateInteractionFrame()
	db.RegisterCallback(self, "OnProfileChanged", "RefreshConfig")
	db.RegisterCallback(self, "OnProfileCopied", "RefreshConfig")
	db.RegisterCallback(self, "OnProfileReset", "RefreshConfig")

end

function module:OnEnable()
	D("OnEnable")
	AddonParent:RegisterQuests("RRQ", db.profile.quests, db.profile.qOptions )
	self.frame:RegisterEvent("QUEST_PROGRESS")
	self.frame:RegisterEvent("QUEST_DETAIL")
	self.frame:RegisterEvent("QUEST_COMPLETE")
	self.frame:RegisterEvent("QUEST_FINISHED")
end

function module:RefreshConfig(event, db, newProfile)
	D(self:GetName(), event, newProfile)
	if AddonParent.db.profile.modules.RRQ then
		self:Enable()
	else
		self:Disable()
	end
	if self:IsEnabled() then
		AddonParent:UnRegisterQuests("RRQ")
		AddonParent:RegisterQuests("RRQ", db.profile.quests, db.profile.qOptions )
	end
end

function module:OnDisable()
	D("OnDisable")
	AddonParent:UnRegisterQuests("RRQ")
	self.frame:UnregisterEvent("QUEST_PROGRESS")
	self.frame:UnregisterEvent("QUEST_DETAIL")
	self.frame:UnregisterEvent("QUEST_COMPLETE")
	self.frame:UnregisterEvent("QUEST_FINISHED")
	self.frame:Hide()
end




local function CheckButton_OnClick(self, button)
	D(self:GetName(), "OnClick, Button:", button, "IsChecked:", self:GetChecked() )
	local isChecked = self:GetChecked()
	local quest = GetTitleText():trim()
	local enabled, exists, module = AddonParent.IsQuestHandled(quest)
	D("Quest: '", quest, "' found in:", module, " IsEnabled:", enabled )
	if exists then	--in the system
		D("Quest: '", quest, "' is in the system. Toggle to:", isChecked and "ON" or "oFF")
		questTable[module][quest] = (isChecked and true or false)

	else	--add to the system
		D("Adding to system", quest)
		if isChecked then
			D("Quest: '", quest, "' not in system and it's enabled, adding")
			db.profile.quests[quest] = true
		else
			D("wasn't checked and not in system, not going to add it")
		end
	end
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


local showEvents = {
	["QUEST_DETAIL"] = true,
	["QUEST_COMPLETE"] = true,
	["QUEST_FINISHED"] = true,
}

local function SOCD_OnEvnet(self, event, ...)
	D(self:GetName(), event, ...)
	if not showEvents[event] then
		D("catch event, hiding() ")
		self:Hide() 
		return
	else
		D("Supported Event, showing()")
		self:Show()
	end

	if GetQuestItemInfo("choice",1) ~= "" then
		D("Quest has choice reward, hiding()")
		self:Hide()
		return
	end

	local quest = GetTitleText():trim()
	local enabled, exists, module = AddonParent.IsQuestHandled(quest)
	self.check:SetChecked(enabled)
	if enabled then
		D("Quest: '", quest, "' is enabled. Handled by:", module)
	else
		D("Quest: '", quest, "' is not enabled. Handled by:", module)
	end

end

local function Frame_OnShow(self)
	if not module:IsEnabled() then
		self:Hide()
	end
end

local backdrop = {
	bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
	edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
	edgeSize = 32,
	tileSize = 32,
	tile = true,
	insets = { left = 11, right = 12, top = 12, bottom = 11 },
}


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
	frame:SetScript("OnShow", Frame_OnShow)
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
			quests = {type = "multiselect", name = L["RRQ Listed Quests"], order = 1, width = "full",
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
	for k,v in pairs(db.profile.quests) do
		if type(v) == "boolean" then
			tinsert(tmpTbl, k)
		end
	end
	table.sort(tmpTbl)
	return tmpTbl
end


function module:Multi_Get(info, value, ...)
	value = tmpTbl[value]
	return db.profile.quests[value]
end

function module:Multi_Set(info, value, state, ...)
	value = tmpTbl[value]
	db.profile.quests[value] = state
end
