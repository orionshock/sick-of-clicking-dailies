--
--	Repeatable Reputation Quests Module
--
--
--

local AddonName, AddonParent = ...

local module = AddonParent:NewModule("Options")
local L = LibStub("AceLocale-3.0"):GetLocale(AddonName)
local db

function module:Debug(...)
	local str = string.join(", ", tostringall(...) )
	str = str:gsub("([:=>]),", "%1")
	str = str:gsub(", ([%-])", " %1")
	ChatFrame5:AddMessage("SOCD-OPT: "..str)
	return str
end

function module:OnInitialize()
	self:CreateInteractionFrame()
	self:CreateGossipOptions()
end

function module:OnEnable()
	self:Debug("OnEnable")
	db = AddonParent.db
	self.frame:RegisterEvent("QUEST_GREETING")
	self.frame:RegisterEvent("QUEST_PROGRESS")
	self.frame:RegisterEvent("QUEST_DETAIL")
	self.frame:RegisterEvent("QUEST_COMPLETE")
	self.frame:RegisterEvent("QUEST_FINISHED")
end


function module:OnDisable()
	self:Debug("OnDisable")
	self.frame:UnregisterEvent("QUEST_GREETING")
	self.frame:UnregisterEvent("QUEST_PROGRESS")
	self.frame:UnregisterEvent("QUEST_DETAIL")
	self.frame:UnregisterEvent("QUEST_COMPLETE")
	self.frame:UnregisterEvent("QUEST_FINISHED")
	self.frame:Hide()
end




local function CheckButton_OnClick(self, button)
	module:Debug("OnClick, Button:", button, "IsChecked:", self:GetChecked() )
	local isChecked = self:GetChecked() and true or false
	local title = GetTitleText()
	if isChecked then
		module:Debug("Option is checked, clearing from disabled quest list")
		db.profile.disabledQuests[title] = nil
	else
		module:Debug("Option !NOT! checked, adding to disabled quest list")
		db.profile.disabledQuests[title] = false
	end
end

--local function CheckButton_OnEnter(self)
--	GameTooltip:ClearAllPoints()
--	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
--	GameTooltip:AddLine(L["Only Works for Daily and Weekly Quests"])
--	GameTooltip:Show()
--end

--local function CheckButton_OnLeave(self)
--	GameTooltip:Hide()
--end


local showEvents = {
	["QUEST_DETAIL"] = true,
	["QUEST_COMPLETE"] = true,
	["QUEST_FINISHED"] = true,
	["QUEST_PROGRESS"] = true,
}

local function SOCD_OnEvnet(self, event, ...)
	if showEvents[event] then
		if QuestIsDaily() or QuestIsWeekly() or AddonParent:IsRepeatable(GetTitleText()) then
			module:Debug("Daily/Weekly/Repeatable:", QuestIsDaily() or QuestIsWeekly() or AddonParent:IsRepeatable(GetTitleText()) )
			self:Show()
		end
	else
		self:Hide()
	end	
end

local function Frame_OnShow(self)
	local title = GetTitleText():trim()
	if db.profile.disabledQuests[title] == false then
		self.check:SetChecked(false)
	else
		self.check:SetChecked(true)
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
	local frame = CreateFrame("frame", "SOCD_QuestOptionFrame", QuestFrame)
	frame:SetWidth(200)
	frame:SetHeight(50)
	frame:SetPoint("BOTTOMRIGHT", QuestFrame, "TOPRIGHT", -30, -20)
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
	text:SetText(L["Auto Complete Daily or Weekly?"])
	frame:SetWidth( text:GetWidth() + 70 )

	--reference on frame
	frame.check = check
	frame.text = text
	frame.addon = self


	frame:SetScript("OnEvent", SOCD_OnEvnet)
	frame:SetScript("OnShow", Frame_OnShow)
	check:SetScript("OnClick", CheckButton_OnClick)
--	check:SetScript("OnEnter", CheckButton_OnEnter)
--	check:SetScript("OnLeave", CheckButton_OnLeave)

	self.frame = frame
end
--[[==========================================================
	Gossip Options
--==========================================================]]--
local function GossipButton_OnShow(self)
	module:Debug("CheckBox#", self.index, "~Text:", self:GetParent():GetText() )
	if self.type ~= "Gossip" then --if not a gossip option then
		if self.index == 1 then	--if we're the first option we need to off set from the Greeting Text
			GossipTitleButton1:SetPoint("TOPLEFT", GossipGreetingText, "BOTTOMLEFT", -5, -20)
		else	--else we need to check what the last guy was doing..
			local anchorFrame = _G["GossipTitleButton"..self.index-1]
			if anchorFrame:IsShown() and anchorFrame.type =="Gossip" then
				self:SetPoint("TOPLEFT", anchorFrame, "BOTTOMLEFT", -25, 0)
			elseif anchorFrame:IsShown() and anchorFrame.type ~="Gossip" then
				self:SetPoint("TOPLEFT", anchorFrame, "BOTTOMLEFT", 0, 0)
			end
		end
		self:Hide() 
	end
	local gossipText = self:GetParent():GetText()
	if gossipText then
		gossipText = gossipText:trim()
		self:SetChecked( db.profile.enabledGossip[gossipText] )
	else
		module:Debug("! Fail")
	end
end

local function GossipButton_OnClick(self, button, ...)
	module:Debug("CheckBox#", self.index, "~Text:", self:GetParent():GetText() )
	local isChecked = self:GetChecked() and true or nil
	local gossipText = self:GetParent():GetText():trim()
	db.profile.enabledGossip[gossipText] = isChecked
end

local function StyleNSizeBox(frame)
	frame:SetWidth(35)
	frame:SetHeight(35)
	frame:SetNormalTexture("Interface\\Buttons\\UI-CheckBox-Up");
	frame:SetPushedTexture("Interface\\Buttons\\UI-CheckBox-Down"); 
	frame:SetHighlightTexture("Interface\\Buttons\\UI-CheckBox-Highlight", "ADD");
	frame:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check");
	frame:SetScript("OnClick", GossipButton_OnClick)
	frame:SetScript("OnShow", GossipButton_OnShow)
end

function module:CreateGossipOptions()
	self.gossipButtons = {}
	local gossipButtons = self.gossipButtons
	--First Move the Buttons over
	GossipTitleButton1:SetPoint("TOPLEFT", GossipGreetingText, "BOTTOMLEFT", 20, -20)
	local check = CreateFrame("CheckButton", nil, GossipTitleButton1)
	check:SetPoint("RIGHT", GossipTitleButton1, "LEFT", 7, 0)
	StyleNSizeBox(check)
	check.index = 1
	tinsert(gossipButtons, check)
	for i = 2, 32 do
		_G["GossipTitleButton"..i]:SetPoint("TOPLEFT", _G["GossipTitleButton"..i-1], "BOTTOMLEFT", 0,0)
		local check = CreateFrame("CheckButton", nil, _G["GossipTitleButton"..i])
		check:SetPoint("RIGHT", _G["GossipTitleButton"..i], "LEFT", 7, 0)
		check.index = i
		StyleNSizeBox(check)
		tinsert(gossipButtons, check)
	end
end

