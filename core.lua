﻿--[[
Major 4,  MinorSVN:  $Revision: 137$

Sick Of Clicking Dailys is a simple addon designed to pick up and turn in Dailiy Quests for WoW.
it does no checking to see if you have actualy completed them.

To Modify Options of what quests / NPC's are enabled look at the Table below named "QuestTable",
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
SOCD.version = 4
local addon = SOCD
local L = LibStub("AceLocale-3.0"):GetLocale("SickOfClickingDailies")
local DEF = DEFAULT_CHAT_FRAME --DEF:AddMessage("")
addon["QuestTable"] = {							--- << STARTS HERE>>
				--Skettis Dailies
				[L["Sky Sergeant Doryn"]] = {
					enabled = true,
					[L["Fires Over Skettis"]] = true,
					[L["Escape from Skettis"]] = true,
					qOptions = {
						[L["Escape from Skettis"]] = 3,
						}
					},
				[L["Skyguard Prisoner"]] = {
					enabled = true,
					[L["Escape from Skettis"]] = true,
					},
				--Blade's Edge Mountains
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
				--Netherwing
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
					[L["The Deadliest Trap Ever Laid"]] = false,	--Step 6 turn quest In.
					},
				[L["Commander Arcus"]] = {							--AldorNPC
					enabled = true,
					[L["Commander Arcus"]] = false,					--Step4 , Turn quest In; Aldor
					[L["The Deadliest Trap Ever Laid"]] = false,	--Step 5, Pick up and Do Quest ; Aldor
					},
				[L["Commander Hobb"]] = {							-- ScryerNPC
					enabled = true,
					[L["Commander Hobb"]] = false,					--Step4 , Turn quest In; Scryer
					[L["The Deadliest Trap Ever Laid"]] = false,	--Step 5, Pick up and Do Quest; Scryer
					},
			--Wintersaber Trainer
				[L["Rivern Frostwind"]] = {
					enabled = true,
					[L["Frostsaber Provisions"]] = true,
					[L["Winterfall Intrusion"]] = true,
					[L["Rampaging Giants"]] = true,
					},
			--Cooking
				[L["The Rokk"]] = {
					enabled = true,
					[L["Super Hot Stew"]] = true,
					[L["Soup for the Soul"]] = true,
					[L["Revenge is Tasty"]] = true,
					[L["Manalicious"]] = true,
					qOptions = {
						[L["Super Hot Stew"]] = 3,
						[L["Soup for the Soul"]] = 3,
						[L["Revenge is Tasty"]] = 3,
						[L["Manalicious"]] = 3,
					}
					},
			--Instance
				[L["Nether-Stalker Mah'duun"]] = {		---Non Heroic NPC
					enabled = true,
					[L["Wanted: Arcatraz Sentinels"]] = false,
					[L["Wanted: Coilfang Myrmidons"]] = false,
					[L["Wanted: Malicious Instructors"]] = false,
					[L["Wanted: Rift Lords"]] = false,
					[L["Wanted: Shattered Hand Centurions"]] = false,
					[L["Wanted: Sunseeker Channelers"]] = false,
					[L["Wanted: Tempest-Forge Destroyers"]] = false,
				},
				[L["Wind Trader Zhareem"]] = {			--Heroic Dailies Daily
					enabled = true,
					[L["Wanted: A Black Stalker Egg"]] = false,
					[L["Wanted: A Warp Splinter Clipping"]] = false,
					[L["Wanted: Aeonus's Hourglass"]] = false,
					[L["Wanted: Bladefist's Seal"]] = false,
					[L["Wanted: Keli'dan's Feathered Stave"]] = false,
					[L["Wanted: Murmur's Whisper"]] = false,
					[L["Wanted: Nazan's Riding Crop"]] = false,
					[L["Wanted: Pathaleon's Projector"]] = false,
					[L["Wanted: Shaffar's Wondrous Pendant"]] = false,
					[L["Wanted: The Epoch Hunter's Head"]] = false,
					[L["Wanted: The Exarch's Soul Gem"]] = false,
					[L["Wanted: The Headfeathers of Ikiss"]] = false,
					[L["Wanted: The Heart of Quagmirran"]] = false,
					[L["Wanted: The Scroll of Skyriss"]] = false,
					[L["Wanted: The Warlord's Treatise"]] = false,
				},
			--PvP
				[L["Horde Warbringer"]] = {				--Horde AV Daily
					enabled = true,
					[L["Call to Arms: Alterac Valley"]] = true,
					[L["Call to Arms: Arathi Basin"]] = true,
					[L["Call to Arms: Eye of the Storm"]] = true,
					[L["Call to Arms: Warsong Gulch"]] = true,
				},
				[L["Alliance Brigadier General"]] = {
					enabled = true,
					[L["Call to Arms: Alterac Valley"]] = true,
					[L["Call to Arms: Arathi Basin"]] = true,
					[L["Call to Arms: Eye of the Storm"]] = true,
					[L["Call to Arms: Warsong Gulch"]] = true,
				},
				[L["Warrant Officer Tracy Proudwell"]] = {
					enabled = true,
					[L["Hellfire Fortifications"]] = true,
				},
				[L["Battlecryer Blackeye"]] = {
					enabled = true,
					[L["Hellfire Fortifications"]] = true,
				},
			}

local MTable = addon["QuestTable"]

function addon:GOSSIP_SHOW()
	if IsShiftKeyDown() then return end
	local npc = addon.CheckNPC()
	local sel, quest, status = addon.OpeningCheckQuest(npc)
    if npc and quest then
		if status == "Available" then
			SelectGossipAvailableQuest(sel)
        elseif status == "Active" then
			SelectGossipActiveQuest(sel)
        end
    end
end

function addon:QUEST_DETAIL()
	if IsShiftKeyDown() then return end
	local npc = addon.CheckNPC()
	local quest = addon.TitleCheck(npc)
    if npc and quest then
		AcceptQuest()
    end
end

local nextQuestFlag, questIndex = false, 0

function addon:QUEST_PROGRESS()
    if IsShiftKeyDown() then return end
	local npc = addon.CheckNPC()
	local quest = addon.TitleCheck(npc)
	if npc and quest then
		if not IsQuestCompletable() then
			nextQuestFlag = true
			if self.db.profile.questLoop then DeclineQuest() end
			return
		else
			nextQuestFlag = false
		end
		CompleteQuest()
    end
end

function addon:QUEST_COMPLETE()
	nextQuestFlag = false
	if IsShiftKeyDown() or not self.db.profile.QUEST_COMPLETE then return end
	local npc = addon.CheckNPC()
	local quest = addon.TitleCheck(npc)
	if npc and quest then
		local opt = self:GetQuestOption(false, npc, quest)
		if opt == 3 then
			return
		elseif opt == (1 or 2) then 
			GetQuestReward( opt )
		end
		return GetQuestReward(0)
    end
end

function addon:PLAYER_TARGET_CHANGED()
	nextQuestFlag, questIndex = false, 0
end

function addon.CheckNPC()
	local target = UnitName("target")
	if MTable[target] then
		if MTable[target].enabled then
			return target
		end
	end
end

local function QuestItteratePickUp(npc, ...)
	if (...) == nil then return end
	local npcTbl = MTable[npc]
	for i=1, select("#", ...), 3 do
		if npcTbl[select(i, ...)] then
			questIndex = qi
			return (i+2)/3 , select(i, ...)
		end
	end
end

local function QuestItterateTurnIn(npc, ...)
	if (...) == nil then return end
	local npcTbl = MTable[npc]
	if nextQuestFlag then
		nextQuestFlag = false
		questIndex = questIndex + 1
		if questIndex > (select("#", ...)/3) then
			questIndex = 1
			for i=1, select("#", ...), 3 do
				if npcTbl[select(i, ...)] then
					questIndex = (i+2)/3
					return (i+2)/3 , select(i, ...)
				end
			end
		else
			for i = ((questIndex*3)-2) , select("#", ...) do
				if npcTbl[select(i, ...)] then
					questIndex = (i+2)/3
					return (i+2)/3 , select(i, ...)
				end
			end
		end
	end
	for i=1, select("#", ...), 3 do
		if npcTbl[select(i, ...)] then
			questIndex = (i+2)/3
			return (i+2)/3 , select(i, ...)
		end
	end
end

function addon.OpeningCheckQuest(npc)
	if npc == nil then return end
	local selection, quest = QuestItteratePickUp(npc, GetGossipAvailableQuests())
	if quest then
			return selection, quest, "Available"
	else
		selection, quest = QuestItterateTurnIn(npc, GetGossipActiveQuests())
		if quest then
			return selection, quest, "Active"
		end
	end
end

function addon.TitleCheck(npc)
	if npc == nil then return end
	if MTable[npc][GetTitleText()] then
		return GetTitleText()
	end
end

function addon:GetQuestOption(info, eNpc, eQuest)
	local npc, quest
	if info then 
		npc = info.arg[1]
		quest = info.arg[2]
	else
		npc, quest = eNpc, eQuest
	end
	local npcTable = MTable[npc] 
	if (npcTable.qOptions) and (npcTable.qOptions[quest]) then
		return npcTable.qOptions[quest]
	end
end

addon.eventFrame = CreateFrame("Frame", "SOCD_EVENT_FRAME", UIParent)
addon.eventFrame:SetScript("OnEvent", function(self, event)
		if addon[event] then
			return addon[event]()
		end
    end)
addon.eventFrame:RegisterEvent("GOSSIP_SHOW")
addon.eventFrame:RegisterEvent("QUEST_DETAIL")
addon.eventFrame:RegisterEvent("QUEST_PROGRESS")
addon.eventFrame:RegisterEvent("QUEST_COMPLETE")
addon.eventFrame:RegisterEvent("PLAYER_TARGET_CHANGED")