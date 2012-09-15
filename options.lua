--[[
	Sick Of Clicking Dailies? - Options frame
	Written By: OrionShock
]]--

local AddonName, AddonParent = ...

local module = AddonParent:NewModule("Options")
local L = LibStub("AceLocale-3.0"):GetLocale(AddonName)
local db

--@debug@
function module:Debug(...)
	local str = string.join(", ", tostringall(...) )
	str = str:gsub("([:=>]),", "%1")
	str = str:gsub(", ([%-])", " %1")
	DEFAULT_CHAT_FRAME:AddMessage("SOCD-OPT: "..str)
	return str
end
--@end-debug@

function module:OnInitialize()
	self:CreateInteractionFrame()
	self:CreateGossipOptions()
end

function module:OnEnable()
	--self:Debug("OnEnable")
	db = AddonParent.db
	self.frame:RegisterEvent("QUEST_GREETING")
	self.frame:RegisterEvent("QUEST_PROGRESS")
	self.frame:RegisterEvent("QUEST_DETAIL")
	self.frame:RegisterEvent("QUEST_COMPLETE")
	self.frame:RegisterEvent("QUEST_FINISHED")
end


function module:OnDisable()
	--self:Debug("OnDisable")
	self.frame:UnregisterEvent("QUEST_GREETING")
	self.frame:UnregisterEvent("QUEST_PROGRESS")
	self.frame:UnregisterEvent("QUEST_DETAIL")
	self.frame:UnregisterEvent("QUEST_COMPLETE")
	self.frame:UnregisterEvent("QUEST_FINISHED")
	self.frame:Hide()
end




local function CheckButton_OnClick(self, button)
	--module:Debug("OnClick, Button:", button, "IsChecked:", self:GetChecked() )
	local isChecked = self:GetChecked() and true or false
	local title = GetTitleText()
	if isChecked then
		--module:Debug("Option is checked, clearing from disabled quest list")
		db.profile.status[title] = nil
	else
		--module:Debug("Option !NOT! checked, adding to disabled quest list")
		db.profile.status[title] = false
	end
end


local showEvents = {
	["QUEST_DETAIL"] = true,
	["QUEST_COMPLETE"] = true,
	["QUEST_FINISHED"] = true,
	["QUEST_PROGRESS"] = true,
}

local function Frame_OnEvent(self, event, ...)
	if showEvents[event] then
		if QuestIsDaily() or QuestIsWeekly() or AddonParent:IsRepeatable(GetTitleText()) or AddonParent:SpecialFixQuest( GetQuestID() ) then
			--module:Debug("Daily/Weekly/Repeatable:", QuestIsDaily() or QuestIsWeekly() or AddonParent:IsRepeatable(GetTitleText()) )
			self:Show()
		else
			self:Hide()
		end
	else
		self:Hide()
	end	
end

local function Frame_OnShow(self)
	local title = GetTitleText():trim()
	if db.profile.status[title] == false then
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
	frame:SetPoint("BOTTOMRIGHT", QuestFrame, "TOPRIGHT", -30, 10)
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
	
	--Hide it by default, otherwise it might be shown before the addon is ready
	frame:Hide()

	frame:SetScript("OnEvent", Frame_OnEvent)
	frame:SetScript("OnShow", Frame_OnShow)
	check:SetScript("OnClick", CheckButton_OnClick)

	self.frame = frame
end
--[[==========================================================
	Gossip Options
--==========================================================]]--
--=====================================================================
local old_GossipFrameUpdate = GossipFrameUpdate
function GossipFrameUpdate()
	for i=1, NUMGOSSIPBUTTONS do
		_G["GossipTitleButton" .. i].realType = nil
	end
	return old_GossipFrameUpdate()
end

function GossipFrameOptionsUpdate(...)	--Hook Replace the blizzard function :)
	local titleButton;
	local titleIndex = 1;
	local realOption = 2;
	local titleButtonIcon;
	for i=1, select("#", ...), 2 do
		if ( GossipFrame.buttonIndex > NUMGOSSIPBUTTONS ) then
			message("This NPC has too many quests and/or gossip options.");
		end
		titleButton = _G["GossipTitleButton" .. GossipFrame.buttonIndex];
		titleButton:SetText(select(i, ...));
		titleButton:Show();

		titleButton:SetID(titleIndex);
		titleButton.type="Gossip";
		titleButtonIcon = _G[titleButton:GetName() .. "GossipIcon"];
		titleButtonIcon:SetTexture("Interface\\GossipFrame\\" .. select(i+1, ...) .. "GossipIcon");
		titleButtonIcon:SetVertexColor(1, 1, 1, 1);
		---------
		local realType = select(realOption, GetGossipOptions())
		--module:Debug("BlizReplace",titleButton:GetName(), realType)
		titleButton.realType = realType
		---------
		GossipFrame.buttonIndex = GossipFrame.buttonIndex + 1;
		titleIndex = titleIndex + 1;
		realOption = titleIndex*2
		GossipResize(titleButton);
		titleButton:Show();
	end
end

-- function Unused_GossipResize(titleButton)
	-- print( titleButton:GetName(), "String Height", titleButton:GetFontString():GetHeight() )
	-- if titleButton:GetFontString() then
		-- print( "Has Font string",  titleButton:GetTextHeight() )
		-- titleButton:SetHeight( titleButton:GetTextHeight() + 2);
	-- else
		-- print( "no font string?", titleButton:GetFontString())
		-- titleButton:SetHeight( titleButton:GetTextHeight() + 2);
	-- end
-- end

--===========================================


local function GossipButton_OnEvent(self)
	if self:GetParent():GetText() == nil then return end
	--module:Debug("CheckBox#", self.index,"~Type:", self:GetParent().realType, "~Text:", self:GetParent():GetText() )
	if self:GetParent().realType == "gossip" then --we're the gossip option
		--module:Debug("RealType:", self:GetParent().realType )
		self:Show()
		if self.index == 1 then	--if we're the first option we need to off set from the Greeting Text
			--module:Debug("FirstIndex, anchor to Greeting Text")
			GossipTitleButton1:SetPoint("TOPLEFT", GossipGreetingText, "BOTTOMLEFT", 10, -20)
		else	--else we need to check what the last guy was doing..
			--module:Debug("Not First Index:", self.index)
			local anchorFrame = _G["GossipTitleButton"..self.index-1]
			if anchorFrame.realType =="gossip" then
				--module:Debug("AnchorFrame:", anchorFrame:GetName(), "~PreviousIs:", anchorFrame.realType, "We're and it is, lineup")
				self:GetParent():SetPoint("TOPLEFT", anchorFrame, "BOTTOMLEFT", 0, -5)
			elseif anchorFrame.realType ~="gossip" then
				--module:Debug("AnchorFrame:", anchorFrame:GetName(), "~PreviousIs:", anchorFrame.realType, "We're and it's not, offset to lineup")
				self:GetParent():SetPoint("TOPLEFT", anchorFrame, "BOTTOMLEFT", 20, -5)		
			end
		end
	else	--We're something other than a gossip option...
		self:Hide()
		if self.index == 1 then	--first index, not gossip, reset to GreetingText
			GossipTitleButton1:SetPoint("TOPLEFT", GossipGreetingText, "BOTTOMLEFT", -10, -20)
		else	--check previous and offset accordingly..
			local anchorFrame = _G["GossipTitleButton"..self.index-1]
			if anchorFrame.realType =="gossip" then
				self:GetParent():SetPoint("TOPLEFT", anchorFrame, "BOTTOMLEFT", -20, -5)
			elseif anchorFrame.realType ~="gossip" then
				self:GetParent():SetPoint("TOPLEFT", anchorFrame, "BOTTOMLEFT", 0, -5)		
			end
		end

	end
	--
	local gossipText = self:GetParent():GetText()
	if gossipText then
		gossipText = gossipText:trim()
		self:SetChecked( db.profile.enabledGossip[gossipText] )
	else
--		module:Debug("! Fail")
	end

end

local function GossipButton_OnClick(self, button, ...)
	--module:Debug("CheckBox#", self.index, "~Text:", self:GetParent():GetText() )
	local isChecked = self:GetChecked() and true or nil
	local gossipText = self:GetParent():GetText():trim()
	db.profile.enabledGossip[gossipText] = isChecked
end

local function StyleNSizeBox(frame)
	frame:SetWidth(20)
	frame:SetHeight(20)
	frame:SetNormalTexture("Interface\\Buttons\\UI-CheckBox-Up");
	frame:SetPushedTexture("Interface\\Buttons\\UI-CheckBox-Down"); 
	frame:SetHighlightTexture("Interface\\Buttons\\UI-CheckBox-Highlight", "ADD");
	frame:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check");
	frame:SetScript("OnClick", GossipButton_OnClick)
	frame:SetScript("OnEvent", GossipButton_OnEvent)
	frame:RegisterEvent("GOSSIP_SHOW")
end

function module:CreateGossipOptions()
	self.gossipButtons = {}
	local gossipButtons = self.gossipButtons
	--First Move the Buttons over
	-- staring point is -10
	GossipTitleButton1:SetPoint("TOPLEFT", GossipGreetingText, "BOTTOMLEFT", 10, -20)
	--GossipTitleButton1:SetPoint("RIGHT", GossipGreetingScrollChildFrame, "RIGHT", -20,0)
	--GossipTitleButton1:GetFontString():SetPoint("RIGHT", GossipTitleButton1, "RIGHT")
	local check = CreateFrame("CheckButton", nil, GossipTitleButton1)
	check:SetPoint("TOPRIGHT", GossipTitleButton1, "TOPLEFT", 3, 3)
	
	StyleNSizeBox(check)
	check.index = 1
	tinsert(gossipButtons, check)
	for i = 2, 32 do
		_G["GossipTitleButton"..i]:SetPoint("TOPLEFT", _G["GossipTitleButton"..i-1], "BOTTOMLEFT", 0,0)
--		_G["GossipTitleButton"..i]:SetPoint("RIGHT", GossipGreetingScrollChildFrame, "RIGHT", -5,0)
--		_G["GossipTitleButton"..i]:GetFontString():SetPoint("RIGHT", _G["GossipTitleButton"..i], "RIGHT")
		local check = CreateFrame("CheckButton", nil, _G["GossipTitleButton"..i])
		check:SetPoint("TOPRIGHT", _G["GossipTitleButton"..i], "TOPLEFT", 3, 3)
		check.index = i
		StyleNSizeBox(check)
		tinsert(gossipButtons, check)
	end
end

--============================================================================
--Ace Options Table::
--============================================================================

function AddonParent.GetOptionsTable()
	local qtmp = {}
	local gtmp = {}
	local t = { name = AddonName, type = "group", handler = addon,
		args = {
			profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(db),
			rewards = { name = L["Quest Reward Choices"], type = "group", order = 10,
				args = {
				},
			},
			qstatus = { name = L["Disabled Quests"], type = "group", order = 5,
				args = {
					desc = { type = "description", name = L["Listed here are disabled quests, when unchecked they will be enabled and will be removed here"], order = 1 },
					holder = { name = L["Disabled Quests"], type = "multiselect", width = "full",
						get = function(info, arg) return not db.profile.status[arg] end,
						set = function(info, arg, value) db.profile.status[arg] = nil end,
						values = function(info) wipe(qtmp) for k,v in pairs(db.profile.status) do qtmp[k] = k end return qtmp end,
					},
				},
			},
			gstatus = { name = L["Enabled Gossip"], type = "group", order = 5,
				args = {
					desc = { type = "description", name = L["Listed here are enabled gossip options, when unchecked they will be disabled and will be removed here"], order = 1 },
					holder = { name = L["Enabled Gossip"], type = "multiselect", width = "full",
						get = function(info, arg) return db.profile.enabledGossip[arg] end,
						set = function(info, arg, value) db.profile.enabledGossip[arg] = nil end,
						values = function(info) wipe(gtmp) for k,v in pairs(db.profile.enabledGossip) do gtmp[k] = k end return gtmp end,
					},
				},
			},
		},
	}
	t.args.profiles.order = -10
	for questName, rewardTable in pairs(db.global.reward) do
		t.args.rewards.args[questName] = {
			name = function(info) return info[#info] end,
			type = "select", width = "double",
			get = function(info) return db.profile.reward[info[#info]] end,
			set = function(info, value) db.profile.reward[info[#info]] = value end,
			values = function(info) return db.global.reward[info[#info]] end,
		}
	end
	return t
end