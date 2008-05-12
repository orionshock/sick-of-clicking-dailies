--[[
Major 5,  MinorSVN:  $Revision$

Sick Of Clicking Dailys is a simple addon designed to pick up and turn in Dailiy Quests for WoW.

This version comes with a built in config system made with Ace3's Config GUI Libs.

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

  ~Additional Terms of Distribution: You acknowlage that the origional Author of this code has the rights to the
  ~Explicit Name used to title the code following and that any alteration and redistribution out side of the
  ~control of the origional author shall have a new name attached to the code along with a source history.

=====================================================================================================
]]--
-- local function D(msg)
	-- DEFAULT_CHAT_FRAME:AddMessage("SOCD: "..msg)
-- end

local L = LibStub("AceLocale-3.0"):GetLocale("SickOfClickingDailies")
local MTable

SickOfClickingDailies = LibStub("AceAddon-3.0"):NewAddon("SickOfClickingDailies", "AceEvent-3.0", "AceConsole-3.0")
local addon = SickOfClickingDailies
addon.version = tostring("$Revision$")
addon.author = "Orionshock, aka, Atradies of Nagrand - US"

-- Profile Defaults--
local defaults = {
		profile = {
			QuestOptions = {
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
					[L["Nethermine Flayer Hide"]] = false,
					[L["Netherwing Crystals"]] = true,
					},
				[L["Chief Overseer Mudlump"]] = {
					enabled = true,
					[L["The Booterang: A Cure For The Common Worthless Peon"]] = true,
					},
				[L["Overlord Mor'ghor"]] = {
					enabled = true,
					[L["Disrupting the Twilight Portal"]] = true,
					[L["The Deadliest Trap Ever Laid"]] = false,
					},
				[L["Commander Arcus"]] = {
					enabled = true,
					[L["The Deadliest Trap Ever Laid"]] = false,
					},
				[L["Commander Hobb"]] = {
					enabled = true,
					[L["The Deadliest Trap Ever Laid"]] = false,
					},
			--Shattered Sun Offensive
				-- [] = {
					-- enabled = true,
					-- [] = true,
				-- },
				[L["Vindicator Xayann"]] = {
					enabled = true,
					[L["Erratic Behavior"]] = true,
					[L["Further Conversions"]] = true,
					},
				[L["Captain Theris Dawnhearth"]] = {
					enabled = true,
					[L["The Sanctum Wards"]] = true,
					[L["Arm the Wards!"]] = true,
					},
				[L["Harbinger Haronem"]] = {
					enabled = true,
					[L["The Multiphase Survey"]] = true,
					},
				[L["Magistrix Seyla"]] = {
					enabled = true,
					[L["Blood for Blood"]] = true,
					[L["Blast the Gateway"]] = true,
					qOptions = {
							[L["Blood for Blood"]] = 3,
						},
					},
				[L["Lord Torvos"]] = {
					enabled = true,
					[L["Sunfury Attack Plans"]] = true,
					},
				[L["Emissary Mordin"]] = {
					enabled = true,
					[L["Gaining the Advantage"]] = true,
					},
				[L["Harbinger Inuuro"]] = {
					enabled = true,
					[L["The Battle for the Sun's Reach Armory"]] = true,
					[L["The Battle Must Go On"]] = true,
					},
				[L["Battlemage Arynna"]] = {
					enabled = true,
					[L["Distraction at the Dead Scar"]] = true,
					[L["The Air Strikes Must Continue"]] = true,
					},
				[L["Exarch Nasuun"]] = {
					enabled = true,
					[L["Intercepting the Mana Cells"]] = true,
					[L["Maintaining the Sunwell Portal"]] = true,
					},
				[L["Astromancer Darnarian"]] = {
					enabled = true,
					[L["Know Your Ley Lines"]] = true,
					},
				[L["Vindicator Kaalan"]] = {
					enabled = true,
					[L["Intercept the Reinforcements"]] = true,
					[L["Keeping the Enemy at Bay"]] = true,
					},
				[L["Magister Ilastar"]] = {
					enabled = true,
					[L["Taking the Harbor"]] = true,
					[L["Crush the Dawnblade"]] = true,
					},
				[L["Smith Hauthaa"]] = {
					enabled = true,
					[L["Making Ready"]] = true,
					[L["Don't Stop Now...."]] = true,
					[L["Ata'mal Armaments"]] = true,
					qOptions = {
							[L["Ata'mal Armaments"]] = 3,
						},
					},
				[L["Anchorite Ayuri"]] = {
					enabled = true,
					[L["A Charitable Donation"]] = false,
					[L["Your Continued Support"]] = false,
					},
				[L["Captain Valindria"]] = {
					enabled = true,
					[L["Disrupt the Greengill Coast"]] = true,
					},
				[L["Mar'nah"]] = {
					enabled = true,
					[L["Discovering Your Roots"]] = true,
					[L["Rediscovering Your Roots"]] = true,
					[L["Open for Business"]] = true,
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
					[L["Super Hot Stew"]] = false,
					[L["Soup for the Soul"]] = false,
					[L["Revenge is Tasty"]] = false,
					[L["Manalicious"]] = false,
					qOptions = {
						[L["Super Hot Stew"]] = 3,
						[L["Soup for the Soul"]] = 3,
						[L["Revenge is Tasty"]] = 3,
						[L["Manalicious"]] = 3,
					}
				},
			--Fishing
				[L["Old Man Barlo"]] = {
					enabled = true,
					[L["Crocolisks in the City"]] = true,
					[L["Bait Bandits"]] = true,
					[L["Felblood Fillet"]] = true,
					[L["Shrimpin' Ain't Easy"]] = true,
					[L["The One That Got Away"]] = true,
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
					[L["Wanted: Sisters of Torment"]] = false,
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
					[L["Wanted: The Signet Ring of Prince Kael'thas"]] = false,
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
				[L["Exorcist Sullivan"]] = {
					enabled = true,
					[L["Spirits of Auchindoun"]] = true,
				},
				[L["Exorcist Vaisha"]] = {
					enabled = true,
					[L["Spirits of Auchindoun"]] = true,
				},
				[L["Karrtog"]] = {
					enabled = true,
					[L["Enemies, Old and New"]] = true,
				},
				[L["Lakoor"]] = {
					enabled = true,
					[L["In Defense of Halaa"]] = true,
				},
			},
		}
	}
	
local function GetGenericQuestOptions(npc, quest)
	return { name = quest, type = "toggle", get = "IsQuestEnabled", set = "ToggleQuest", arg = { npc, quest } }
end

--GUI Options Tree  
local function GetOptionsTable()
	return {
	type = "group",
	name = L["Sick Of Clicking Dailies?"],
	handler = SickOfClickingDailies,
	childGroups = "tab",
	args = {
		FactionGrind = { type = "group", name = L["Faction Grinds"], order = 1,
			args = {
				ShatariSkyguard = { type = "group", name = L["Skyguard"], order = 1,
					args = {
						skettis = { type = "description", name = L["Skettis"], order = 1 },
						Fires = GetGenericQuestOptions( L["Sky Sergeant Doryn"], L["Fires Over Skettis"]),
						escort = {
							name = L["Escape from Skettis"], type = 'group', order = 3, inline = true,
							args = {
								Escape = { name = L["Enable Quest"], type = "toggle", order = 3,
									desc = L["This will toggle the quest on both Doryn and the Prisoner"],
									arg = { L["Sky Sergeant Doryn"],  L["Escape from Skettis"] }, get = "IsQuestEnabled",
									set = function(_ , v) 	addon:ToggleQuest( false , L["Sky Sergeant Doryn"],  L["Escape from Skettis"], v )
															addon:ToggleQuest( false , L["Skyguard Prisoner"],  L["Escape from Skettis"], v ) end, },
								EscapeOption = { name = L["Quest Reward"], type = "select", order = 4, get = "GetQuestOption", set = "SetQuestOption",
									desc = L["Select what Potion you want for the 'Escape from Skettis' quest"],
									arg = { L["Sky Sergeant Doryn"],  L["Escape from Skettis"] },
									values = { L["Health Potion"], L["Mana Potion"], L["None"] },},
							},
						},
						bem = { type = "description", name = L["Blades Edge Mountains"], order = 5 },
						Aether = GetGenericQuestOptions( L["Skyguard Khatie"], L["Wrangle More Aether Rays!"] ),
						Bomb = GetGenericQuestOptions(L["Sky Sergeant Vanderlip"], L["Bomb Them Again!"]),
					},
				},
				Ogrila = { type = "group", name = L["Ogri'la"], order = 2,
					args = {
						Emanation = GetGenericQuestOptions( L["Chu'a'lor"], L["The Relic's Emanation"] ),
						Demons = GetGenericQuestOptions( L["Kronk"], L["Banish More Demons"] ),
					},
				},
				Netherwing = { type = "group", name = L["Netherwing"], order = 3,
					args = {
						Netural = { type = "group", name = L["Netherwing - Neutral"], order = 1, inline = true,
							args = {
								Crystals = GetGenericQuestOptions( L["Taskmaster Varkule Dragonbreath"], L["Netherwing Crystals"]),
								Ore = GetGenericQuestOptions( L["Taskmaster Varkule Dragonbreath"], L["Nethercite Ore"]),
								Pollen = GetGenericQuestOptions( L["Taskmaster Varkule Dragonbreath"], L["Netherdust Pollen"] ),
								Hide = GetGenericQuestOptions( L["Taskmaster Varkule Dragonbreath"], L["Nethermine Flayer Hide"] ),
								Skies = GetGenericQuestOptions( L["Yarzill the Merc"], L["The Not-So-Friendly Skies..."] ),
								Death = GetGenericQuestOptions( L["Yarzill the Merc"], L["A Slow Death"] ),
								noEgs = {type = "description", name = L["Accepting All Eggs is not included because it's not a Daily Quest"], order = 10 },
							},
						},
						Friendly = { type = "group", name = L["Netherwing - Friendly"], order = 2, inline = true,
							args = {
								Pieces = GetGenericQuestOptions( L["Mistress of the Mines"] , L["Picking Up The Pieces..."] ),
								Dragons = GetGenericQuestOptions(L["Dragonmaw Foreman"] , L["Dragons are the Least of Our Problems"] ),
								Booterang = GetGenericQuestOptions( L["Chief Overseer Mudlump"] , L["The Booterang: A Cure For The Common Worthless Peon"] ),
							},
						},
						Honored = { type = "group", name = L["Netherwing - Honored"], order = 3, inline = true,
							args = {
								Twilight = GetGenericQuestOptions( L["Overlord Mor'ghor"] , L["Disrupting the Twilight Portal"] ),
							},
						},
						Revered = { type = "group", name = L["Netherwing - Revered"], order = 4, inline = true,
							args = {
								Trap = { name = L["The Deadliest Trap Ever Laid"], type = "toggle", order = 1,
									desc = L["|cffFF0000WARNING!!!|r, This Option also toggles both Scryer and Aldor Quests"],
									arg = { L["Overlord Mor'ghor"] , L["The Deadliest Trap Ever Laid"] },
									get = "IsQuestEnabled",
									set = function()
											addon:ToggleQuest( nil, L["Commander Hobb"] , L["The Deadliest Trap Ever Laid"] )
											addon:ToggleQuest( nil, L["Commander Arcus"] , L["The Deadliest Trap Ever Laid"] )
											addon:ToggleQuest( nil, L["Overlord Mor'ghor"] , L["The Deadliest Trap Ever Laid"] )
									end,
								},
							},
						},
					},
				},
				ShatteredSun = {type = "group", name = L["Shattered Sun Offensive"], order = 4,
					args = {
						Explination = { type = 'description', name = L["SSO_TEXT"],order = 1},
						POne = { name = L["Phase 1"], order = 1, type = 'group', --inline = true,
							args = {
								pDesc = {type = "description", order = 1, name = L["Recovering the Sun's Reach Sanctum"]},
								Sentries = GetGenericQuestOptions( L["Vindicator Xayann"], L["Erratic Behavior"]),
								SanctumWards = GetGenericQuestOptions(L["Captain Theris Dawnhearth"], L["The Sanctum Wards"] ),
								ArmTheWards = GetGenericQuestOptions(L["Captain Theris Dawnhearth"], L["Arm the Wards!"] ),
								FurtherConversions = GetGenericQuestOptions( L["Vindicator Xayann"], L["Further Conversions"]),
							},
						},
						PTwo = { name = L["Phase 2"], order = 2, type = 'group', --inline = true,
							args = {
								pDesc = {type = "description", order = 1, name = L["Recovering the Sun's Reach Armory"]},
								Armory = GetGenericQuestOptions( L["Harbinger Inuuro"], L["The Battle for the Sun's Reach Armory"]),
								Distraction = GetGenericQuestOptions( L["Battlemage Arynna"], L["Distraction at the Dead Scar"]),
								ArmoryContinued = GetGenericQuestOptions( L["Harbinger Inuuro"], L["The Battle Must Go On"]),
								DistractionContinued = GetGenericQuestOptions( L["Battlemage Arynna"], L["The Air Strikes Must Continue"]),
							},
						},
						PTwoB= { name = L["Phase 2B"], order = 3, type = 'group', --inline = true,
							args = {
								pDesc = {type = "description", order = 1, name = L["Open the Sunwell Portal"]},
								InterceptingManaCells = GetGenericQuestOptions( L["Exarch Nasuun"], L["Intercepting the Mana Cells"]),
								SunwellPortal = GetGenericQuestOptions( L["Exarch Nasuun"], L["Maintaining the Sunwell Portal"]),
								LeyLines = GetGenericQuestOptions( L["Astromancer Darnarian"], L["Know Your Ley Lines"]),
							},
						},
						PThree= { name = L["Phase 3"], order = 4, type = 'group', --inline = true,
							args = {
								pDesc = {type = "description", order = 1, name = L["Recovering the Sun's Reach Harbor"]},
								InterceptTheReinforcements = GetGenericQuestOptions( L["Vindicator Kaalan"], L["Intercept the Reinforcements"]),
								TakingTheHarbor = GetGenericQuestOptions( L["Magister Ilastar"], L["Taking the Harbor"]),
								KeepingTheEnemyAtBay = GetGenericQuestOptions( L["Vindicator Kaalan"], L["Keeping the Enemy at Bay"]),
								CrushTheDawnblade = GetGenericQuestOptions( L["Magister Ilastar"], L["Crush the Dawnblade"]),
							},
						},
						PThreeB= { name = L["Phase 3B"], order = 5, type = 'group', --inline = true,
							args = {
								pDesc = {type = "description", order = 1, name = L["Building the Anvil"]},
								MakingReady = GetGenericQuestOptions( L["Smith Hauthaa"], L["Making Ready"]),
								AtamalArmaments = {name =  L["Ata'mal Armaments"], type = "group", inline=true, 
									args = {
										ArmamentsQuest = { name =  L["Enable Quest"], type = "toggle", order = 1, get = "IsQuestEnabled", set = "ToggleQuest",
											arg = { L["Smith Hauthaa"],   L["Ata'mal Armaments"] }, },
										ArmamentsOption = { name = L["Quest Reward"], type = "select", order = 2,
											arg = { L["Smith Hauthaa"],  L["Ata'mal Armaments"] }, get = "GetQuestOption", set = "SetQuestOption",
											values = { L["Blessed Weapon Coating"], L["Righteous Weapon Coating"], L["None"] } },
									},
								},
								DontStopNow = GetGenericQuestOptions( L["Smith Hauthaa"], L["Don't Stop Now...."]),
							},
						},
						PFour= { name = L["Phase 4"], order = 6, type = 'group', --inline = true,
							args = {
								pDesc = {type = "description", order = 1, name = L["The Final Push"]},
								DiscoveringRoots = GetGenericQuestOptions( L["Mar'nah"], L["Discovering Your Roots"]),
								DisruptGreengill = GetGenericQuestOptions( L["Captain Valindria"], L["Disrupt the Greengill Coast"]),
								RediscoveringRoots = GetGenericQuestOptions( L["Mar'nah"], L["Rediscovering Your Roots"]),
								OpenForBusiness = GetGenericQuestOptions( L["Mar'nah"], L["Open for Business"]),
							},
						},
						PFourB = { name = L["Phase 4B"], order = 7, type = 'group', --inline = true,
							args = {
								pDesc = {type = "description", order = 1, name = L["Memorial for the Fallen"]},
								CharitableDonation = GetGenericQuestOptions( L["Anchorite Ayuri"], L["A Charitable Donation"]),
								ContinuedSupport = GetGenericQuestOptions( L["Anchorite Ayuri"], L["Your Continued Support"]),
							},
						},
						Associated = { name = L["Associated Daily Quests"], order = 100, type = 'group', inline = true,
							args = {
								Survey = GetGenericQuestOptions( L["Harbinger Haronem"], L["The Multiphase Survey"]),
								SunfuryPlans = GetGenericQuestOptions( L["Lord Torvos"], L["Sunfury Attack Plans"]),
								Advantage = GetGenericQuestOptions( L["Emissary Mordin"], L["Gaining the Advantage"]),
								MagistrixSeyla = {name = L["Magistrix Seyla"], type = "group", inline = true, order = 1000,
									args = {
										Gateway = GetGenericQuestOptions( L["Magistrix Seyla"], L["Blast the Gateway"]),
										BloodForBlood = {name =  L["Blood for Blood"], type = "group", inline=true,
											args = {
												BloodQuest = { name =  L["Enable Quest"], type = "toggle", order = 1, get = "IsQuestEnabled", set = "ToggleQuest",
													arg = { L["Magistrix Seyla"],   L["Blood for Blood"] }, },
												BloodOption = { name = L["Quest Reward"], type = "select", order = 2,
													arg = { L["Magistrix Seyla"],  L["Blood for Blood"] }, get = "GetQuestOption", set = "SetQuestOption",
													values = { L["Mark of Sargeras"], L["Sunfury Signet"], L["None"] } },
											},
										},
									},
								},
							},
						},
					},
				},
				WintersaberTrainers = { name = L["Wintersaber Trainer"], type = "group", order = 100,
					args = {
						Provisions = GetGenericQuestOptions( L["Rivern Frostwind"] , L["Frostsaber Provisions"] ),
						Intrusion = GetGenericQuestOptions( L["Rivern Frostwind"] , L["Winterfall Intrusion"] ),
						Giants = GetGenericQuestOptions( L["Rivern Frostwind"] , L["Rampaging Giants"] ),
					},
				},
			},
		},
		NonHeroic = { type = "group", name = L["Instance - Normal"], order = 2,
			args = {
				Sentinels= { name = L["Arcatraz Sentinels"], type = "toggle", order = 1, get = "IsQuestEnabled", set = "ToggleQuest",
					arg = { L["Nether-Stalker Mah'duun"], L["Wanted: Arcatraz Sentinels"] } },
				Myrmidons= { name = L["Coilfang Myrmidons"], type = "toggle", order = 2, get = "IsQuestEnabled", set = "ToggleQuest",
					arg = { L["Nether-Stalker Mah'duun"], L["Wanted: Coilfang Myrmidons"] } },
				Instructors= { name = L["Malicious Instructors"], type = "toggle", order = 3, get = "IsQuestEnabled", set = "ToggleQuest",
					arg = { L["Nether-Stalker Mah'duun"], L["Wanted: Malicious Instructors"] } },
				Rift= { name = L["Rift Lords"], type = "toggle", order = 4, get = "IsQuestEnabled", set = "ToggleQuest",
					arg = { L["Nether-Stalker Mah'duun"], L["Wanted: Rift Lords"] } },
				Centurions= { name = L["Shattered Hand Centurions"], type = "toggle", order = 5, get = "IsQuestEnabled", set = "ToggleQuest",
					arg = { L["Nether-Stalker Mah'duun"], L["Wanted: Shattered Hand Centurions"] } },
				Channelers= { name = L["Sunseeker Channelers"], type = "toggle", order = 6, get = "IsQuestEnabled", set = "ToggleQuest",
					arg = { L["Nether-Stalker Mah'duun"], L["Wanted: Sunseeker Channelers"] } },
				Destroyers= { name = L["Tempest-Forge Destroyers"], type = "toggle", order = 7, get = "IsQuestEnabled", set = "ToggleQuest",
					arg = { L["Nether-Stalker Mah'duun"], L["Wanted: Tempest-Forge Destroyers"] } },
				Sisters= { name = L["Sisters of Torment"], type = "toggle", order = 8, get = "IsQuestEnabled", set = "ToggleQuest",
					arg = { L["Nether-Stalker Mah'duun"], L["Wanted: Sisters of Torment"] } },
				helpText = { type = "description", name = L["\nAll Non-Heroic Quests are from |cff00ff00'Nether-Stalker Mah'duun'|r in LowerCity"], order = 100 },
			},
		},
		Heroic ={ type = "group", name = L["Instance - Heroic"], order = 3,
			args = {
				Auchindoun = {type = "header", name = L["Auchindoun"], order = 1},
				Murmur= { name = L["Murmur's Whisper"], type = "toggle", order = 2, get = "IsQuestEnabled", set = "ToggleQuest",
					arg = { L["Wind Trader Zhareem"], L["Wanted: Murmur's Whisper"] } },
				Shaffar= { name = L["Shaffar's Wondrous Pendant"], type = "toggle", order = 3, get = "IsQuestEnabled", set = "ToggleQuest",
					arg = { L["Wind Trader Zhareem"], L["Wanted: Shaffar's Wondrous Pendant"] } },
				Exarch= { name = L["The Exarch's Soul Gem"], type = "toggle", order = 4, get = "IsQuestEnabled", set = "ToggleQuest",
					arg = { L["Wind Trader Zhareem"], L["Wanted: The Exarch's Soul Gem"] } },
				Ikiss= { name = L["The Headfeathers of Ikiss"], type = "toggle", order = 5, get = "IsQuestEnabled", set = "ToggleQuest",
					arg = { L["Wind Trader Zhareem"], L["Wanted: The Headfeathers of Ikiss"] } },
				CoT = {type = "header", name = L["Caverns of Time"], order = 6},
				Aeonus= { name = L["Aeonus's Hourglass"], type = "toggle", order = 7, get = "IsQuestEnabled", set = "ToggleQuest",
					arg = { L["Wind Trader Zhareem"], L["Wanted: Aeonus's Hourglass"] } },
				Epoch= { name = L["The Epoch Hunter's Head"], type = "toggle", order = 8, get = "IsQuestEnabled", set = "ToggleQuest",
					arg = { L["Wind Trader Zhareem"], L["Wanted: The Epoch Hunter's Head"] } },
				Hellfire = {type = "header", name = L["Hellfire Citadel"], order = 9},
				Bladefist= { name = L["Bladefist's Seal"], type = "toggle", order = 10, get = "IsQuestEnabled", set = "ToggleQuest",
					arg = { L["Wind Trader Zhareem"], L["Wanted: Bladefist's Seal"] } },
				Kelidan= { name = L["Keli'dan's Feathered Stave"], type = "toggle", order = 11, get = "IsQuestEnabled", set = "ToggleQuest",
					arg = { L["Wind Trader Zhareem"], L["Wanted: Keli'dan's Feathered Stave"] } },
				Nazan= { name = L["Nazan's Riding Crop"], type = "toggle", order = 12, get = "IsQuestEnabled", set = "ToggleQuest",
					arg = { L["Wind Trader Zhareem"], L["Wanted: Nazan's Riding Crop"] } },
				Serpentshrine = {type = "header", name = L["Serpentshrine Cavern"], order = 13},
				Stalker= { name = L["A Black Stalker Egg"], type = "toggle", order = 14, get = "IsQuestEnabled", set = "ToggleQuest",
					arg = { L["Wind Trader Zhareem"], L["Wanted: A Black Stalker Egg"] } },
				Quagmirran= { name = L["The Heart of Quagmirran"], type = "toggle", order = 15, get = "IsQuestEnabled", set = "ToggleQuest",
					arg = { L["Wind Trader Zhareem"], L["Wanted: The Heart of Quagmirran"] } },
				Warlord= { name = L["The Warlord's Treatise"], type = "toggle", order = 16, get = "IsQuestEnabled", set = "ToggleQuest",
					arg = { L["Wind Trader Zhareem"], L["Wanted: The Warlord's Treatise"] } },
				Eye = {type = "header", name = L["The Eye"], order = 17},
				WarpSplinter= { name = L["A Warp Splinter Clipping"], type = "toggle", order = 18, get = "IsQuestEnabled", set = "ToggleQuest",
					arg = { L["Wind Trader Zhareem"], L["Wanted: A Warp Splinter Clipping"] } },
				Pathaleon= { name = L["Pathaleon's Projector"], type = "toggle", order = 19, get = "IsQuestEnabled", set = "ToggleQuest",
					arg = { L["Wind Trader Zhareem"], L["Wanted: Pathaleon's Projector"] } },
				Skyriss= { name = L["The Scroll of Skyriss"], type = "toggle", order = 20, get = "IsQuestEnabled", set = "ToggleQuest",
					arg = { L["Wind Trader Zhareem"], L["Wanted: The Scroll of Skyriss"] } },
				SunWell = {type = "header", name = L["Magister's Terrace"], order = 21},
				Kaelthas= { name = L["Ring of Prince Kael'thas"] , type = "toggle", order = 22, get = "IsQuestEnabled", set = "ToggleQuest",
					arg = { L["Wind Trader Zhareem"], L["Wanted: The Signet Ring of Prince Kael'thas"] } },
				helpText = {type = "description", name = L["\nAll Heroic Dailies from |cff00ff00'Wind Trader Zhareem'|r in LowerCity"], order = 100},
			},
		},
		PvP = { type = "group", name = L["PvP"], order = 3,
			args = {
				Alliance = { type = "group", name = L["Alliance PvP"], order = 1, childGroups = "tab",
					args = {
						BattleGrounds = { type = "group", name = L["Battlegrounds"], inline = true, order = 1,
							args = {
								eots = GetGenericQuestOptions( L["Alliance Brigadier General"] , L["Call to Arms: Eye of the Storm"] ),
								av = GetGenericQuestOptions( L["Alliance Brigadier General"] , L["Call to Arms: Alterac Valley"] ),
								ab = GetGenericQuestOptions( L["Alliance Brigadier General"] , L["Call to Arms: Arathi Basin"] ),
								wsg= GetGenericQuestOptions( L["Alliance Brigadier General"], L["Call to Arms: Warsong Gulch"] ),
							},
						},
						WorldPvP = { type = "group", name = L["World PvP"], inline = true, order = 2,
							args = {
								fort = GetGenericQuestOptions( L["Warrant Officer Tracy Proudwell"]  , L["Hellfire Fortifications"] ),
								Spirit = GetGenericQuestOptions( L["Exorcist Sullivan"] , L["Spirits of Auchindoun"] ),
								halaa = GetGenericQuestOptions( L["Lakoor"], L["In Defense of Halaa"]),
							},
						},
					}, 
				},
				Horde = { type = "group", name = L["Horde PvP"], order = 1,
					args = {
						BattleGrounds = { type = "group", name = L["Battlegrounds"], inline = true, order = 1,
							args = {
								eots = GetGenericQuestOptions( L["Horde Warbringer"] , L["Call to Arms: Eye of the Storm"] ),
								av = GetGenericQuestOptions( L["Horde Warbringer"] , L["Call to Arms: Alterac Valley"] ),
								ab = GetGenericQuestOptions( L["Horde Warbringer"] , L["Call to Arms: Arathi Basin"] ),
								wsg= GetGenericQuestOptions( L["Horde Warbringer"], L["Call to Arms: Warsong Gulch"] ),
							},
						},
						WorldPvP = { type = "group", name = L["World PvP"], inline = true, order = 2,
							args = {
								fort = GetGenericQuestOptions( L["Battlecryer Blackeye"]   , L["Hellfire Fortifications"] ),
								Spirit = GetGenericQuestOptions( L["Exorcist Vaisha"] , L["Spirits of Auchindoun"] ),
								halaa = GetGenericQuestOptions( L["Karrtog"], L["Enemies, Old and New"] ),
							},
						},
					},
				},
			},
		},
		Profession = {type = "group", name = L["Profession"], order = 4, 
			args = {
				Cooking = {name = L["Cooking"], type = "group", order = 1, --childGroups = "tab",
					args = {
						Rokk = { name = L["The Rokk"], type = "group", order = 1, inline = true,
							args = {
								enabled = { name = L["NPC Enabled"], type = "toggle", order = 1,
									arg = L["The Rokk"], get = "IsNPCEnabled", set = "ToggleNPC" },
								Stew = {name =  L["Super Hot Stew"], type = "group", order = 2, --inline = true,
									args = {
										stewQuest = { name =  L["Enable Quest"], type = "toggle", order = 1, get = "IsQuestEnabled", set = "ToggleQuest",
											arg = { L["The Rokk"],   L["Super Hot Stew"] }, },
										StewOption = { name = L["Quest Reward"], type = "select", order = 2,
											arg = { L["The Rokk"],  L["Super Hot Stew"] }, get = "GetQuestOption", set = "SetQuestOption",
											values = { L["Barrel of Fish"], L["Crate of Meat"], L["None"] } },
									},
								},
								soup = {name =  L["Soup for the Soul"], type = "group", order = 3, --inline = true,
									args = {
										soupQuest = { name =  L["Enable Quest"], type = "toggle", order = 1, get = "IsQuestEnabled", set = "ToggleQuest",
											arg = { L["The Rokk"],   L["Soup for the Soul"] }, },
										soupOption = { name = L["Quest Reward"], type = "select", order = 2,
											arg = { L["The Rokk"],  L["Soup for the Soul"] }, get = "GetQuestOption", set = "SetQuestOption",
											values = { L["Barrel of Fish"], L["Crate of Meat"], L["None"] } },
									},
								},
								Revenge = {name =  L["Revenge is Tasty"], type = "group", order = 4, --inline = true,
									args = {
										RevengeQuest = { name =  L["Enable Quest"], type = "toggle", order = 1, get = "IsQuestEnabled", set = "ToggleQuest",
											arg = { L["The Rokk"],   L["Revenge is Tasty"] }, },
										RevengeOption = { name = L["Quest Reward"], type = "select", order = 2,
											arg = { L["The Rokk"],  L["Revenge is Tasty"] }, get = "GetQuestOption", set = "SetQuestOption",
											values = { L["Barrel of Fish"], L["Crate of Meat"], L["None"] } },
									},
								},
								Manalicious = {name =  L["Manalicious"], type = "group", order = 5, --inline = true,
									args = {
										RevengeQuest = { name =  L["Enable Quest"], type = "toggle", order = 1, get = "IsQuestEnabled", set = "ToggleQuest",
											arg = { L["The Rokk"],  L["Manalicious"] }, },
										RevengeOption = { name = L["Quest Reward"], type = "select", order = 2,
											arg = { L["The Rokk"],  L["Manalicious"] }, get = "GetQuestOption", set = "SetQuestOption",
											values = { L["Barrel of Fish"], L["Crate of Meat"], L["None"] } },
									},
								}
							},
						},
					},
				},
				Fishing = {name = L["Fishing"], type = "group", order = 2, --childGroups = "tab",
					args = {
						Barlo = { name = L["Old Man Barlo"], type = "group", order = 1, inline = true,
							args = {
								Crocolisks= GetGenericQuestOptions( L["Old Man Barlo"], L["Crocolisks in the City"] ),
								BaitBandits= GetGenericQuestOptions( L["Old Man Barlo"], L["Bait Bandits"] ),
								FelbloodFillet= GetGenericQuestOptions( L["Old Man Barlo"], L["Felblood Fillet"] ),
								Shrimpin= GetGenericQuestOptions( L["Old Man Barlo"], L["Shrimpin' Ain't Easy"] ),
								Mudfish= GetGenericQuestOptions( L["Old Man Barlo"], L["The One That Got Away"] ),
							} 
						}, 
					},
				},
			},
		},
		loop = { name = L["Always Loop NPCs"], type = "toggle", order = 2,
			desc = L["Always Loop on the NPC from one quest to the next forever"],
			get = function() return addon.db.profile.questLoop end,
			set = function() if addon.db.profile.questLoop then addon.db.profile.questLoop = false else addon.db.profile.questLoop = true end end, },
		}, --Close Top Lvl Args Table
}
end

function addon:OnInitialize()
	addon.db = LibStub("AceDB-3.0"):New("SickOfClickingDailiesDB", defaults)
	MTable = self.db.profile.QuestOptions
	LibStub("AceConfig-3.0"):RegisterOptionsTable("SickOfClickingDailies", GetOptionsTable)
	self:RegisterChatCommand("socd", function() LibStub("AceConfigDialog-3.0"):Open("SickOfClickingDailies") end )
end

function addon:OnEnable()
	self:RegisterEvent("GOSSIP_SHOW")
	self:RegisterEvent("QUEST_DETAIL")
	self:RegisterEvent("QUEST_PROGRESS")
	self:RegisterEvent("QUEST_COMPLETE")
	self:RegisterEvent("PLAYER_TARGET_CHANGED")
end
function addon:OnDisable()
	self:UnregisterAllEvents()
end
local npcBad, nextQuestFlag, questIndex = nil, false, 0

function addon:GOSSIP_SHOW()
	local npc = addon.CheckNPC()
	if (IsShiftKeyDown())then return end
	if (not self.db.profile.questLoop) and npcBad then 
		return --D("GossipShow npc Bad Exit")
	end

	local sel, quest, status = addon.OpeningCheckQuest(npc)
    if npc and quest then
		if status == "Available" then
			return SelectGossipAvailableQuest(sel)
        elseif status == "Active" then
			return SelectGossipActiveQuest(sel)
        end
    end
end

function addon:QUEST_DETAIL()
	if IsShiftKeyDown() then return end
	local npc = addon.CheckNPC()
	local quest = addon.TitleCheck(npc)
    if npc and quest then
		return AcceptQuest()
    end
end


function addon:QUEST_PROGRESS()
    if IsShiftKeyDown() then return end
	local npc = addon.CheckNPC()
	local quest = addon.TitleCheck(npc)
	if npc and quest then
		if not IsQuestCompletable() then
			nextQuestFlag = true
			if self.db.profile.questLoop then 
				return DeclineQuest() 
			end
			return
		else
			nextQuestFlag = false
		end
		return CompleteQuest() --HERE
    end
end

function addon:QUEST_COMPLETE()
	nextQuestFlag = false
	if IsShiftKeyDown() then return end
	local npc = addon.CheckNPC()
	local quest = addon.TitleCheck(npc)
	if npc and quest then
		local opt = self:GetQuestOption(false, npc, quest)
		if opt and (opt == 3) then
			return
		elseif opt and (opt == 1 or opt == 2) then
			return GetQuestReward( opt )
		end
		return GetQuestReward(0)
    end
end

function addon:PLAYER_TARGET_CHANGED()
	npcBad, nextQuestFlag, questIndex = false, false, 0
end

function addon.CheckNPC()
	local target = UnitName("target")
	if MTable[target] then
		if MTable[target].enabled then
			return target
		end
	else
		 nextQuestFlag, questIndex = false, 0
	end
end

local function QuestItteratePickUp(npc, ...)
	if (...) == nil then return end
	local npcTbl = MTable[npc]
	for i=1, select("#", ...), 3 do
		if npcTbl[select(i, ...)] then
			return (i+2)/3 , select(i, ...)
		end
	end
end

local function QuestItterateTurnIn(npc, ...)
	if (...) == nil then return end
	local npcTbl = MTable[npc]
	local numQuest = select("#", ...)
	if nextQuestFlag then
		nextQuestFlag = false
		questIndex = questIndex + 1
		if questIndex > (numQuest /3) then
			npcBad = true
			questIndex = 1
			for i=1, numQuest , 3 do
				if npcTbl[select(i, ...)] then
					questIndex = (i+2)/3
					return (i+2)/3 , select(i, ...)
				end
			end
		else
			for i = ((questIndex*3)-2) , numQuest  do
				if npcTbl[select(i, ...)] then
					questIndex = (i+2)/3
					return (i+2)/3 , select(i, ...)
				end
			end
		end
	end
	if numQuest <= 3 then npcBad = true end
	for i=1, numQuest , 3 do
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
	if not npc then return end
	if MTable[npc][GetTitleText()] then
		return GetTitleText()
	end
end


--GUI Options Support Funcs

function addon:IsNPCEnabled(info)
	return MTable[info.arg].enabled
end

function addon:ToggleNPC(info)
	if MTable[info.arg].enabled then
		MTable[info.arg].enabled = false
	else
		MTable[info.arg].enabled = true
	end
end

function addon:IsQuestEnabled(info)
	return MTable[info.arg[1]][info.arg[2]]
end

function addon:ToggleQuest(info, eNPC, eQuest)
	local npc, quest
	if info then
		npc = info.arg[1]
		quest = info.arg[2]
	else
		npc, quest = eNPC, eQuest
	end
	if MTable[npc][quest] then
		MTable[npc][quest] = false
	else
		MTable[npc][quest]= true
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

function addon:SetQuestOption(info, v)
	MTable[info.arg[1]].qOptions[info.arg[2]] = v
end
