--[[
 $Rev$
This file is used to update locale information by automagically generating it from the client

/dump SickOfClickingDailies:ScanTooltips()
/dump SickOfClickingDailies:CommitLocalizedNames()

In the SV file of the profile you will find the names of the quests in ["enUS"] = "locale", format

Good Luck!

]]

local function D(msg)
	DEFAULT_CHAT_FRAME:AddMessage("|cff33cc66SOCD-Scanner:|r "..msg)

end

local SOCD = LibStub("AceAddon-3.0"):GetAddon("SickOfClickingDailies")
local dbo

local qTable = {
	["11545"] = "A Charitable Donation",
	["11020"] = "A Slow Death",
	["11523"] = "Arm the Wards!",
	["11544"] = "Ata'mal Armaments",
	["11666"] = "Bait Bandits",
	["11051"] = "Banish More Demons",
	["11407"] = "Bark for Drohn's Distillery!",
	["11408"] = "Bark for T'chali's Voodoo Brewery!",
	["11293"] = "Bark for the Barleybrews!",
	["11294"] = "Bark for the Thunderbrews!",
	["11516"] = "Blast the Gateway",
	["11515"] = "Blood for Blood",
	["11023"] = "Bomb Them Again!",
	["11401"] = "Call the Headless Horseman",
	["11336"] = "Call to Arms: Alterac Valley",
	["11339"] = "Call to Arms: Arathi Basin",
	["11341"] = "Call to Arms: Eye of the Storm",
	["11342"] = "Call to Arms: Warsong Gulch",
	["11665"] = "Crocolisks in the City",
	["11540"] = "Crush the Dawnblade",
	["11520"] = "Discovering Your Roots",
	["11541"] = "Disrupt the Greengill Coast",
	["11086"] = "Disrupting the Twilight Portal",
	["11532"] = "Distraction at the Dead Scar",
	["11536"] = "Don't Stop Now....",
	["11077"] = "Dragons are the Least of Our Problems",
	["11503"] = "Enemies, Old and New",
	["11524"] = "Erratic Behavior",
	["11085"] = "Escape from Skettis",
	["11669"] = "Felblood Fillet",
	["11008"] = "Fires Over Skettis",
	["11525"] = "Further Conversions",
	["11875"] = "Gaining the Advantage",
	["10110"] = "Hellfire Fortifications",
	["11502"] = "In Defense of Halaa",
	["11542"] = "Intercept the Reinforcements",
	["11513"] = "Intercepting the Mana Cells",
	["11543"] = "Keeping the Enemy at Bay",
	["11547"] = "Know Your Ley Lines",
	["11514"] = "Maintaining the Sunwell Portal",
	["11535"] = "Making Ready",
	["11380"] = "Manalicious",
	["11925"] = "More Torch Catching",
	["11926"] = "More Torch Tossing",
	["11018"] = "Nethercite Ore",
	["11017"] = "Netherdust Pollen",
	["11016"] = "Nethermine Flayer Hide",
	["11015"] = "Netherwing Crystals",
	["11546"] = "Open for Business",
	["11076"] = "Picking Up The Pieces...",
	["11521"] = "Rediscovering Your Roots",
	["11377"] = "Revenge is Tasty",
	["11668"] = "Shrimpin' Ain't Easy",
	["11381"] = "Soup for the Soul",
	["11505"] = "Spirits of Auchindoun",
	["11219"] = "Stop the Fires!",	
	["11947"] = "Striking Back",
	["11691"] = "Summon Ahune",
	["11877"] = "Sunfury Attack Plans",
	["11379"] = "Super Hot Stew",
	["11539"] = "Taking the Harbor",
	["11533"] = "The Air Strikes Must Continue",
	["11537"] = "The Battle Must Go On",
	["11538"] = "The Battle for the Sun's Reach Armory",
	["11055"] = "The Booterang: A Cure For The Common Worthless Peon",
	["11097"] = "The Deadliest Trap Ever Laid",
	["11101"] = "The Deadliest Trap Ever Laid",
	["11880"] = "The Multiphase Survey",
	["11035"] = "The Not-So-Friendly Skies...",
	["11667"] = "The One That Got Away",
	["11080"] = "The Relic's Emanation",
	["11496"] = "The Sanctum Wards",
	["11369"] = "Wanted: A Black Stalker Egg",
	["11384"] = "Wanted: A Warp Splinter Clipping",
	["11382"] = "Wanted: Aeonus's Hourglass",
	["11389"] = "Wanted: Arcatraz Sentinels",
	["11363"] = "Wanted: Bladefist's Seal",
	["11371"] = "Wanted: Coilfang Myrmidons",
	["11362"] = "Wanted: Keli'dan's Feathered Stave",
	["11376"] = "Wanted: Malicious Instructors",
	["11375"] = "Wanted: Murmur's Whisper",
	["11354"] = "Wanted: Nazan's Riding Crop",
	["11386"] = "Wanted: Pathaleon's Projector",
	["11383"] = "Wanted: Rift Lords",
	["11373"] = "Wanted: Shaffar's Wondrous Pendant",
	["11364"] = "Wanted: Shattered Hand Centurions",
	["11500"] = "Wanted: Sisters of Torment",
	["11385"] = "Wanted: Sunseeker Channelers",
	["11387"] = "Wanted: Tempest-Forge Destroyers",
	["11378"] = "Wanted: The Epoch Hunter's Head",
	["11374"] = "Wanted: The Exarch's Soul Gem",
	["11372"] = "Wanted: The Headfeathers of Ikiss",
	["11368"] = "Wanted: The Heart of Quagmirran",
	["11388"] = "Wanted: The Scroll of Skyriss",
	["11499"] = "Wanted: The Signet Ring of Prince Kael'thas",
	["11370"] = "Wanted: The Warlord's Treatise",
	["11066"] = "Wrangle More Aether Rays!",
	["11548"] = "Your Continued Support",
}
local tt = CreateFrame("GameTooltip", "QuestScanTT", UIParent, "GameTooltipTemplate")


function SOCD:CheckTTScan()
	local i = 1
	for k, v in pairs(qTable) do
		tt:SetOwner(UIParent, "ANCHOR_NONE")
		tt:SetHyperlink("quest:"..k)
		tt:Show()
		DEFAULT_CHAT_FRAME:AddMessage("TT Text: "..i)
		i = i +1
	end
	D("If The above number dosn't say 114 then Scan the Titles again")
end

function SOCD:ScanTTALL()
	for k, v in pairs(qTable) do
		tt:SetOwner(UIParent, "ANCHOR_NONE")
		tt:SetHyperlink("quest:"..k)
		tt:Show()
	end
end

function SOCD:ScanTooltips()
	self:ScanTTALL()
	self:CheckTTScan()
end

local dbo

function SOCD:CommitLocalizedNames()
	self.db.profile.Scanner = {}
	dbo = self.db.profile.Scanner
	local i = 1
	for k, v in pairs(qTable) do
		tt:SetOwner(UIParent, "ANCHOR_NONE")
		tt:SetHyperlink("quest:"..k)
		tt:Show()
		
		dbo[v] = QuestScanTTTextLeft1:GetText()
		D("Count = "..i)
		i = i + 1
	end
end
