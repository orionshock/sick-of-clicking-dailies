--[[
	Sick Of Clicking Dailies? - Options frame
	Written By: OrionShock
]]--

local AddonName, AddonParent = ...

local module = AddonParent:NewModule("Options")
local L = LibStub("AceLocale-3.0"):GetLocale(AddonName)
local db

--[===[@debug@--@end-debug@]===]
function module:Debug(...)
	local str = string.join(", ", tostringall(...) )
	str = str:gsub("([:=>]),", "%1")
	str = str:gsub(", ([%-])", " %1")
	DEFAULT_CHAT_FRAME:AddMessage("SOCD-OPT: "..str)
	return str
end


function module:OnInitialize()
	self:CreateInteractionFrame()
	self:CreateGossipOptions()
end

function module:OnEnable()
	--self:Debug("OnEnable")
	db = AddonParent.db
	
	self.frame:RegisterEvent("GOSSIP_SHOW")
	self.frame:RegisterEvent("QUEST_GREETING")
	self.frame:RegisterEvent("QUEST_PROGRESS")
	self.frame:RegisterEvent("QUEST_DETAIL")
	self.frame:RegisterEvent("QUEST_COMPLETE")
	self.frame:RegisterEvent("QUEST_FINISHED")
end


function module:OnDisable()
	--self:Debug("OnDisable")
	
	self.frame:UnregisterEvent("GOSSIP_SHOW")
	self.frame:UnregisterEvent("QUEST_GREETING")
	self.frame:UnregisterEvent("QUEST_PROGRESS")
	self.frame:UnregisterEvent("QUEST_DETAIL")
	self.frame:UnregisterEvent("QUEST_COMPLETE")
	self.frame:UnregisterEvent("QUEST_FINISHED")
	self.frame:Hide()
end


gg = {}

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

local function GossipButton_OnEvent(self)
	if self:GetParent():GetText() == nil then return end
	--module:Debug("CheckBox#", self.index,"~Type:", self:GetParent().type, "~Text:", self:GetParent():GetText() )
	if self:GetParent().type == "Gossip" then --we're the gossip option
		--module:Debug("RealType:", self:GetParent().type )
		self:Show()
		self:Show()
		if self.index == 1 then	--if we're the first option we need to off set from the Greeting Text
			--module:Debug("FirstIndex, anchor to Greeting Text")
			GossipFrame_GetTitleButton(1):SetPoint("TOPLEFT", GossipGreetingText, "BOTTOMLEFT", 10, -20)
		else	--else we need to check what the last guy was doing..
			--module:Debug("Not First Index:", self.index)
			local anchorFrame = GossipFrame_GetTitleButton(self.index-1)--_G["GossipTitleButton"..self.index-1]
			if anchorFrame.type =="Gossip" then
				--module:Debug("AnchorFrame:", anchorFrame:GetName(), "~PreviousIs:", anchorFrame.type, "We're and it is, lineup")
				self:GetParent():SetPoint("TOPLEFT", anchorFrame, "BOTTOMLEFT", 0, -5)
			elseif anchorFrame.type ~="Gossip" then
				--module:Debug("AnchorFrame:", anchorFrame:GetName(), "~PreviousIs:", anchorFrame.type, "We're and it's not, offset to lineup")
				self:GetParent():SetPoint("TOPLEFT", anchorFrame, "BOTTOMLEFT", 20, -5)		
			end
		end
	else	--We're something other than a gossip option...
		self:Hide()
		if self.index == 1 then	--first index, not gossip, reset to GreetingText
			GossipFrame_GetTitleButton(1):SetPoint("TOPLEFT", GossipGreetingText, "BOTTOMLEFT", -10, -20)
		else	--check previous and offset accordingly..
			local anchorFrame = GossipFrame_GetTitleButton(self.index-1)--_G["GossipTitleButton"..self.index-1]
			if anchorFrame.type =="Gossip" then
				self:GetParent():SetPoint("TOPLEFT", anchorFrame, "BOTTOMLEFT", -20, -5)
			elseif anchorFrame.type ~="Gossip" then
				self:GetParent():SetPoint("TOPLEFT", anchorFrame, "BOTTOMLEFT", 0, -5)		
			end
		end

	end
	--
	local gossipText = self:GetParent():GetText()
	if gossipText and db then
		gossipText = gossipText:trim()
		self:SetChecked( db.profile.enabledGossip[gossipText] )
	else
		--module:Debug("! Fail")
	end

end

local function GossipButton_OnClick(self, button, ...)
	--module:Debug("GossipButton_OnClick CheckBox#", self.index, "~Text:", self:GetParent():GetText() )
	if not db then return end
	self.wtf = 32;
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
	--frame:SetScript("OnEvent", GossipButton_OnEvent)
	--frame:RegisterEvent("GOSSIP_SHOW")
end


local function processGossip(self)
	if self.gossipButtons == nil then 
		self.gossipButtons = gg 
	end
	local gossipButtons = self.gossipButtons

	if (GossipFrame_GetTitleButtonCount() == 0) then
		return
	end


	if (table.getn(gossipButtons) == 0) then
		--First Move the Buttons over
		-- staring point is -10
		
		local check = CreateFrame("CheckButton", "socdB1", GossipFrame_GetTitleButton(1))
		StyleNSizeBox(check)
		check.index = 1
		tinsert(gossipButtons, check)
	end
	
	for i = table.getn(gossipButtons)+1, GossipFrame_GetTitleButtonCount() do
		--print("Creating button" .. i)
		
		local check = CreateFrame("CheckButton", "socdB" .. i, GossipFrame_GetTitleButton(i))
		check.index = i
		StyleNSizeBox(check)
		
		tinsert(gossipButtons, check)
	end

	for i = 1,table.getn(gossipButtons) do
		local button = gossipButtons[i]
		button.index = i
		button:SetParent(GossipFrame_GetTitleButton(i))
		button:Hide()
	end

	GossipFrame_GetTitleButton(1):SetPoint("TOPLEFT", GossipGreetingText, "BOTTOMLEFT", 10, -20)
	gossipButtons[1]:SetPoint("TOPRIGHT", GossipFrame_GetTitleButton(1), "TOPLEFT", 3, 3)
	for i = 2,GossipFrame_GetTitleButtonCount() do
		local button = gossipButtons[i]
		GossipFrame_GetTitleButton(i):SetPoint("TOPLEFT", GossipFrame_GetTitleButton(i-1), "BOTTOMLEFT", 0,0)
		button:SetPoint("TOPRIGHT", GossipFrame_GetTitleButton(i), "TOPLEFT", 3, 3)
	end

	for i = 1,GossipFrame_GetTitleButtonCount() do
		local button = gossipButtons[i]
		GossipButton_OnEvent(button)
	end

end



local function Frame_OnEvent(self, event, ...)

	if (event == "GOSSIP_SHOW") then
		processGossip(self)
	end


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
	local frame = CreateFrame("frame", "SOCD_QuestOptionFrame", QuestFrame, BackdropTemplateMixin and "BackdropTemplate")
	frame:SetWidth(200)
	frame:SetHeight(50)
	frame:SetPoint("BOTTOMRIGHT", QuestFrame, "TOPRIGHT", -30, 10)
	frame:SetBackdrop(backdrop)

	--CheckBox
	local check = CreateFrame("CheckButton", "SOCD_cButton", frame, BackdropTemplateMixin and "BackdropTemplate")
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
--local old_GossipFrameUpdate = GossipFrameUpdate
--function GossipFrameUpdate()
--	for i=1, GossipFrame_GetTitleButtonCount() do
--		GossipFrame_GetTitleButton(i).realType = nil
--	end
--	return old_GossipFrameUpdate()
--end

--local org = GossipFrameOptionsUpdate
--function GossipFrameOptionsUpdate(...)	--Hook Replace the blizzard function :)
--	org(...)
--	local gossipOptions = C_GossipInfo.GetOptions();
--
--	local titleIndex = 1;
--	for titleIndex, optionInfo in ipairs(gossipOptions) do
--		GossipFrame_GetTitleButton(titleIndex).realType = optionInfo.type
--		titleIndex = titleIndex + 1
--		print("Dasdas")
--	end
--
--
--end



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






function module:CreateGossipOptions()

end

--============================================================================
--Ace Options Table::
--============================================================================
-- All selectable quest rewards need to be scanned here so that the call to GetItemInfo in specialQuestManagement.lua later succeeds.
local rewardItems = {
	--== Burning Crusade ==--
	--Cooking
	[33844] = "Barrel of Fish",
	[33857] = "Crate of Meat",
	
	--SSO
	[30809] = "Mark of Sargeras",
	[30810] = "Sunfury Signet",
	
	--Ata'mal
	[34538] = "Blessed Weapon Coating",
	[34539] = "Righteous Weapon Coating",
	
	--== Wrath Of the Lich King ==--
	--Argent Tourny
	[46114] = "Champion's Writ",
	[45724] = "Champion's Purse",
	
	--Thx Holliday
	[46723] = "Pilgrim's Hat",
	[46800] = "Pilgrim's Attire",
	[44785] = "Pilgrim's Dress",
	[46824] = "Pilgrim's Robe",
	[44788] = "Pilgrim's Boots",
	[116404] = "Pilgrim's Bounty",
	
	--== Mists of Pandaria ==--
	--Path of the Mistwalker
	[103643] = "Dew of Eternal Morning",
	[103642] = "Book of the Ages",
	[103641] = "Singing Crystal",
	
	--== Warlords of Draenor ==--
	--Alchemy Experiment
	[122453] = "Draenic Agility Potion",
	[122451] = "Draenic Invisibility Potion",
	[122454] = "Draenic Intellect Potion",
	[122452] = "Draenic Swiftness Potion",
	[122455] = "Draenic Strength Potion",
	[122456] = "Draenic Armor Potion",
	
	--Scrap Meltdown
	[120301] = "Armor Enhancement Token",
	[120302] = "Weapon Enhancement Token",
}
	
local function RequestItemInfo()
	--module:Debug("Running GetItemInfo for all items")

	for k, v in pairs(rewardItems) do
		-- We don't need the item name here, we just request it from the server so it's cached in memory.
		-- In fact, most of them will be nil on first login.
		local itemName = GetItemInfo(k)
		--module:Debug("GetItemInfo first try:", k, "-->", itemName)
	end
end

local itemInfoWasRequested = false

-- This function is called when the options dialog is opened.
function AddonParent.GetOptionsTable()
	if not itemInfoWasRequested then
		itemInfoWasRequested = true
		-- Request item info of all items that might be shown in the options dialog from the server.
		-- If this isn't done, the call to GetItemInfo() that happens later will always return nil on
		-- first login (WoW only caches item info in memory, not on hard disk).
		-- Usually we would need to wait for GET_ITEM_INFO_RECEIVED, but since the item names for the UI
		-- aren't requested unit the user opens the quest rewards category, we don't need to handle that event.
		RequestItemInfo()
	end

	local qtmp = {}
	local gtmp = {}
	local rtmp = {}
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
			values = function(info)
				wipe(rtmp)
				for k,v in pairs(db.global.reward[info[#info]]) do
					local itemName
					if k == -1 then
						-- v is "None"
						itemName = v
					else
						local itemId = tonumber(v)
						itemName = GetItemInfo(itemId) or rewardItems[itemId] or "Unknown item"
					end
					--module:Debug("Building values for reward options", k, ":", v, "-->", itemName)
					rtmp[k] = itemName
				end
				return rtmp
			end,
		}
	end
	return t
end