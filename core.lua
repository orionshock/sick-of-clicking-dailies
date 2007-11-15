--[[
Major 4,  MinorSVN:  $Revision$

Sick Of Clicking Dailys is a simple addon designed to pick up and turn in Dailiy Quests for WoW.
it does no checking to see if you have actualy completed them. If you have DailyFu installed it will quiry it for what
Potion you'd like for the Skettis Escort Quest, but outside of that there are no other quest rewards outside of GOLD!

To Modify Options of what quests / NPC's are enabled look at the Table blolow Titltled "MTable", 
find the NPC/Quest and toggle the true/false options.


=====================================================================================================
Distibuted under the "Do What The Fuck You Want To Public License" (http://sam.zoy.org/wtfpl/)

     DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                    Version 2, December 2004

 Copyright (C) 2004 Sam Hocevar
  14 rue de Plaisance, 75014 Paris, France
 Everyone is permitted to copy and distribute verbatim or modified
 copies of this license document, and changing it is allowed as long
 as the name is changed.

            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

  0. You just DO WHAT THE FUCK YOU WANT TO.
  
 ***This program is free software. It comes without any warranty, to
 *** the extent permitted by applicable law. You can redistribute it
  ***and/or modify it under the terms of the Do What The Fuck You Want
  ***To Public License, Version 2, as published by Sam Hocevar. See 
  ***http://sam.zoy.org/wtfpl/COPYING for more details. 
=====================================================================================================
]]--
SOCD = {}
local mod = SOCD
local L = SOCD_LOCALE_TABLE
local DEF = DEFAULT_CHAT_FRAME --DEF:AddMessage("")
mod["QuestTable"] = {   --<<<<<<<<<<<<============== THIS IS THE TABLE !!!!!
	--Skettis Dailies 			>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	[L["Sky Sergeant Doryn"]] = {
		enabled = true,
		[L["Fires Over Skettis"]] = true,
		[L["Escape from Skettis"]] = true,
		},
	[L["Skyguard Prisoner"]] = {
		enabled = true,
		[L["Escape from Skettis"]] = true,
		},
	--Blade's Edge Mountains	>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	[L["Skyguard Khatie"]] = {
		enabled = true,
		[L["Wrangle More Aether Rays!"]] = true,
		},
	[L["Sky Sergeant Vanderlip"]] = {
		enabled = true,
		[L["Bomb Them Again!"]] = true,
		},
	[L["Chu'a'lor"]] = {
		enabled = true,
		[L["The Relic's Emanation"]] = true,
		},
	[L["Kronk"]] = {
		enabled = true,
		[L["Banish More Demons"]] = true,
		},
	--Netherwing			>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	[L["Mistress of the Mines"]] = {
		enabled = true,
		[L["Picking Up The Pieces..."]] = true,
		},
	[L["Dragonmaw Foreman"]] = {
		enabled = true,
		[L["Dragons are the Least of Our Problems"]] = true,
		},
	[L["Yarzill the Merc"]] = {
		enabled = true,
		[L["The Not-So-Friendly Skies..."]] = true,
		[L["A Slow Death"]] = false,
		},
	[L["Taskmaster Varkule Dragonbreath"]] = {
		enabled = true,
		[L["Nethercite Ore"]] = false,
		[L["Netherdust Pollen"]] = false,
		[L["Nethermine Flayer Hide"]] = true,
		[L["Netherwing Crystals"]] = true,
		},
	[L["Chief Overseer Mudlump"]] = {
		enabled = true,
		[L["The Booterang: A Cure For The Common Worthless Peon"]] = true,
		},
	[L["Overlord Mor'ghor"]] = {
		enabled = true,
		[L["Disrupting the Twilight Portal"]] = true,
		[L["The Deadliest Trap Ever Laid"]] = true,
		},
	[L["Commander Hobb"]] = { -- Scryer
		enabled = false,
		[L["The Deadliest Trap Ever Laid"]] = true,
		},
	[L["Commander Arcus"]] = { --Aldor
		enabled = false,
		[L["The Deadliest Trap Ever Laid"]] = true,
		},
	--Wintersaber Trainer
	[L["Rivern Frostwind"]] = {
		enabled = true,
		[L["Frostsaber Provisions"]] = true,
		[L["Winterfall Intrusion"]] = true,
		[L["Rampaging Giants"]] = true,
		}
	}
local MTable = mod["QuestTable"]

function mod:GOSSIP_SHOW()
	if IsShiftKeyDown() then return end
	local npc = mod.CheckNPC()
	local sel, quest, status = mod.OpeningCheckQuest(npc)
    if npc and quest then
		if status == "Available" then
			SelectGossipAvailableQuest(sel)
        elseif status == "Active" then
			SelectGossipActiveQuest(sel)
        end
    end
end

function mod:QUEST_DETAIL()
	if IsShiftKeyDown() then return end
	local npc = mod.CheckNPC()
	local quest = mod.TitleCheck(npc)
    if npc and quest then
		AcceptQuest()
    end
end

local nextQuestFlag, questIndex

function mod:QUEST_PROGRESS()
    if IsShiftKeyDown() then return end
	local npc = mod.CheckNPC()
	local quest = mod.TitleCheck(npc)
	if npc and quest then
		if not IsQuestCompletable() then
			nextQuestFlag = true
			DeclineQuest()
			return
		else
			nextQuestFlag = false
		end
		CompleteQuest()
    end
end

function mod:QUEST_COMPLETE()
	nextQuestFlag = false
	if IsShiftKeyDown() then return end
	local npc = mod.CheckNPC()
	local quest = mod.TitleCheck(npc)
	if npc and quest then
		if quest == L["Escape from Skettis"] then
			if DailyFu then
				GetQuestReward(DailyFu:GetEscortOption())
				return DailyFu:AddQuestToCompleted(quest)
			end
			return
        else
            if DailyFu then DailyFu:AddQuestToCompleted(quest) end
			return GetQuestReward(0)
		end
    end
	
end

function mod.CheckNPC()
	local target = UnitName("target")
	if MTable[target] then
		if MTable[target].enabled then
			return target
		end
	end	
end

local function QuestItterate(npc, ...)
	if nextQuestFlag then
		nextQuestFlag = false
		if (questIndex+1) > (select("#", ...)/3) then 
			questIndex = 1 
			return questIndex , select(questIndex, ...)
		end
		questIndex = questIndex + 1
		return questIndex, select(questIndex + 1, ...)
	end

	qi = 0
	for i=1, select("#", ...), 3 do
		qi = qi + 1
		if MTable[npc][select(i, ...)] then
			return qi , select(i, ...)
		end
	end
end

function mod.OpeningCheckQuest(npc)
	if npc == nil then return end
	local selection, quest = QuestItterate(npc, GetGossipAvailableQuests())	
	if quest then
			return selection, quest, "Available"
	else
		selection, quest = QuestItterate(npc, GetGossipActiveQuests())
		if quest then
			return selection, quest, "Active"
		end
	end
end

--[[
1Quest, 1lvl, 1nil, 2Quest, 2lvl, 2nil, 3Quest, 3lvl, 3nil, 4Quest, 4lvl, 4nil, 5Quest, 5lvl, 5nil,

quest / selection

1  1
2 4 /2 = 2
3 7 /2 = 
4 8

 "A Slow Death", 70, nil,                                 1 +1 /2
 "The Not-So-Friendly Skies...", 70, nil,       4
 "Accepting All Eggs", 70, nil                         7
 x, x, x,  						10


]]--
function mod.TitleCheck(npc)
	if npc == nil then return end
	if MTable[npc][GetTitleText()] then 
		return GetTitleText()
	end
end

mod.eventFrame = CreateFrame("Frame", "SOCD_EVENT_FRAME", UIParent)
mod.eventFrame:SetScript("OnEvent", function(self, event)
		if mod[event] then
			return mod[event]()
		end
    end)
mod.eventFrame:RegisterEvent("GOSSIP_SHOW")
mod.eventFrame:RegisterEvent("QUEST_DETAIL")
mod.eventFrame:RegisterEvent("QUEST_PROGRESS")
mod.eventFrame:RegisterEvent("QUEST_COMPLETE")