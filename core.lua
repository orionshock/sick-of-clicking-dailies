

NewSOCD = {}
local function D(...)
	local str = string.join(", ", tostringall(...) )
	str = str:gsub("[:=],", "%1")
	print("NewSOCD: ", str)
end

local addon = NewSOCD
local eventFrame = CreateFrame("Frame")

eventFrame:SetScript("OnEvent", function(self, event, ...)
	if type(addon[event]) == "function" then
		addon[event](addon, event, ...)
	else
		addon:InspectAPI(event, ...)
	end
end)
function addon:RegisterEvent(event)
	eventFrame:RegisterEvent(event)
end

function addon:UnregisterEvent(event)
	eventFrame:UnregisterEvent(event)
end
addon:RegisterEvent("ADDON_LOADED")

function addon:ADDON_LOADED(event, addon)
	if addon ~= "TestingGround" then return end
	self:RegisterEvent("GOSSIP_SHOW")
	self:RegisterEvent("QUEST_DETAIL")
	self:RegisterEvent("QUEST_PROGRESS")
	self:RegisterEvent("QUEST_COMPLETE")

	self:RegisterEvent("QUEST_GREETING")



end

function addon:InspectAPI(event, ...)
	print(event, ...)
	print("~QuestIsDaily", QuestIsDaily(), "~QuestIsWeekly", QuestIsWeekly() )
	local title, _, _, isDaily, isRepeatable = GetGossipAvailableQuests()
	print("GetGossipAvailableQuests", title, " isDaily: ", isDaily, " isRepeatable: ", isRepeatable )

	local title, _, _, isComplete = GetGossipActiveQuests()
	print("GetGossipActiveQuests", title, " isComplete: ", isComplete)

end

--[[
	Gossip Show Event
		2 helper functions to scrub though the information.
		IMO this api sucks.
		Sadly when turning in quests, we don't know if they are daily's, but don't care about that now.
]]--
local function procGetGossipAvailableQuests(index, title, _, _, isDaily, _, ...)
	if title and isDaily then
		if not addon:ShouldIgnoreQuest(title) then
			return index, title, isDaily
		end
	elseif ... then
		return procGetGossipAvailableQuests(index + 1, ...)
	end
end

local function procGetGossipActiveQuests(index, title, _, _, isComplete, ...)
	if title and isComplete then
		if not addon:ShouldIgnoreQuest(title) then
			return index, title, isComplete
		end
	elseif ... then
		return procGetGossipActiveQuests(index+1, ...)
	end
end

function addon:GOSSIP_SHOW(event)
	D(event)	
	local index, title, isDaily = procGetGossipAvailableQuests(1, GetGossipAvailableQuests() )
	if index then
		D("Found Available, Quest:", title, "~IsDaily:",isDaily, "~ShouldIgnore:", self:ShouldIgnoreQuest(title) )
		return SelectGossipAvailableQuest(index)
	end
	local index, title, isComplete = procGetGossipActiveQuests(1, GetGossipActiveQuests() )
	if index then
		D("Found Active Quest that is Complete:", title, "~IsComplete:", isComplete, "~ShouldIgnore:", self:ShouldIgnoreQuest(title) )
		return SelectGossipActiveQuest(index)
	end
--	D("Proccess Gossip Options here")		
end

--[[
	Quest Greeting, npc's that don't want to talk give us this window. API here is Kinda Ugly.
]]--

function addon:QUEST_GREETING(event, ...)
	D(event, ...)
	local numActiveQuests = GetNumActiveQuests()
	local numAvailableQuests = GetNumAvailableQuests()
	D("AvailableQuests")
	for i = 1, numAvailableQuests do
		local title, _, isDaily = GetAvailableTitle(i), GetAvailableQuestInfo(i)
		D("Quest:", title, "~IsDaily:", isDaily, "~ShouldIgnore:", self:ShouldIgnoreQuest(title) )
		if (title and isDaily) and ( not self:ShouldIgnoreQuest(title) ) then
			D("picking up quest:", title)
			SelectAvailableQuest(i)
		end
	end
	for i = 1, numActiveQuests do
		local title, isComplete = GetActiveTitle(i)
		D("Quest:", title, "~isComplete:", isComplete, "~ShouldIgnore:", self:ShouldIgnoreQuest(title) )
		if (title and isComplete) and ( not self:ShouldIgnoreQuest(title) ) then
			D("turning in quest:", title)
			SelectActiveQuest(i)
		end
	end
end

--[[
	Quest Detail Event
]]--

function addon:QUEST_DETAIL(event)
	local title = GetTitleText()
	D(event, title, "~IsDaily/Weekly:" , QuestIsDaily() or QuestIsWeekly(), "~ShouldIgnore:", self:ShouldIgnoreQuest(title) )

	if ( QuestIsDaily() or QuestIsWeekly() ) then
		self:CaptureDailyQuest(title)
		if self:ShouldIgnoreQuest(title) then return end
		D("Accepting Daily/Weekly Quest:", title)
		return AcceptQuest()
	end
end
--[[
	Quest Progress Event
]]--

function addon:QUEST_PROGRESS(event)
	local title = GetTitleText()

	D(event, title, "~IsCompleteable:", IsQuestCompletable(), "~IsDaily/Weekly:" , QuestIsDaily() or QuestIsWeekly(), "~ShouldIgnore:", self:ShouldIgnoreQuest(title) )

	if not IsQuestCompletable() then return end
	if ( QuestIsDaily() or QuestIsWeekly() ) and ( not self:ShouldIgnoreQuest(title) ) then
		D("Completing Quest:", title)
		CompleteQuest()
	end
end


--[[
	Quest Complete Event
		--Can't get this far unless you can turn it in.
]]--

function addon:QUEST_COMPLETE(event)
	local title = GetTitleText()

	D(event, title, "~IsDaily/Weekly:" , QuestIsDaily() or QuestIsWeekly(), "~ShouldIgnore:", self:ShouldIgnoreQuest(title) )

	if ( QuestIsDaily() or QuestIsWeekly() ) and ( not self:ShouldIgnoreQuest(title) ) then
		local rewardOpt = self:GetQuestRewardOption( title )
		if (rewardOpt and (rewardOpt == -1)) then
			return
		elseif rewardOpt then
			D(event, "Getting Reward:", (GetQuestItemInfo("choice", rewardOpt)) )
			GetQuestReward( rewardOpt )
			return
		end
		D(event, "Getting Money!")
		GetQuestReward(0)
		return

	end
end




--[[
	General Support Functions
]]--

function addon:GetQuestRewardOption(title)
	--function broken atm during dev--
--	D("GetQuestRewardOption, -1")
	return -1
end

function addon:ShouldIgnoreQuest(title)
--	D("ShouldIgnoreQuest: ", title, false)
	return false
end

function addon:CaptureDailyQuest(title)
	--
end
