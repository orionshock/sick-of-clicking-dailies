--[[
 $Rev$
This file is used to update locale information by automagically generating it from the client

/dump SickOfClickingDailies:ScanTooltips()
/dump SickOfClickingDailies:CommitLocalizedNames()

In the SV file of the profile you will find the names of the quests in "enUS" = "locale", format

Good Luck!

]]

local SOCD = LibStub("AceAddon-3.0"):GetAddon("SickOfClickingDailies")
local module = SOCD:NewModule("QuestScanner")
local dbo

local function D(...)
	print("SOCD: ", ...)
end

local qTable = {
	[4970] = "Frostsaber Provisions", --C
	[5201] = "Winterfall Intrusion", --C
	[5981] = "Rampaging Giants", --C
	[10110] = "Hellfire Fortifications", --BC
	[11008] = "Fires Over Skettis", --BC
	[11015] = "Netherwing Crystals", --BC
	[11016] = "Nethermine Flayer Hide", --BC
	[11017] = "Netherdust Pollen", --BC
	[11018] = "Nethercite Ore", --BC
	[11020] = "A Slow Death", --BC
	[11023] = "Bomb Them Again!", --BC
	[11035] = "The Not-So-Friendly Skies...", --BC
	[11051] = "Banish More Demons", --BC
	[11055] = "The Booterang: A Cure For The Common Worthless Peon", --BC
	[11066] = "Wrangle More Aether Rays!", --BC
	[11076] = "Picking Up The Pieces...", --BC
	[11077] = "Dragons are the Least of Our Problems", --BC
	[11080] = "The Relic's Emanation", --BC
	[11085] = "Escape from Skettis", --BC
	[11086] = "Disrupting the Twilight Portal", --BC
	[11097] = "The Deadliest Trap Ever Laid", --BC
	[11335] = "Call to Arms: Arathi Basin", --C
	[11337] = "Call to Arms: Eye of the Storm", --BC
	[11338] = "Call to Arms: Warsong Gulch", --C
	[11354] = "Wanted: Nazan's Riding Crop", --BC
	[11362] = "Wanted: Keli'dan's Feathered Stave", --BC
	[11363] = "Wanted: Bladefist's Seal", --BC
	[11364] = "Wanted: Shattered Hand Centurions", --BC
	[11368] = "Wanted: The Heart of Quagmirran", --BC
	[11369] = "Wanted: A Black Stalker Egg", --BC
	[11370] = "Wanted: The Warlord's Treatise", --BC
	[11371] = "Wanted: Coilfang Myrmidons", --BC
	[11372] = "Wanted: The Headfeathers of Ikiss", --BC
	[11373] = "Wanted: Shaffar's Wondrous Pendant", --BC
	[11374] = "Wanted: The Exarch's Soul Gem", --BC
	[11375] = "Wanted: Murmur's Whisper", --BC
	[11376] = "Wanted: Malicious Instructors", --BC
	[11377] = "Revenge is Tasty", --BC
	[11378] = "Wanted: The Epoch Hunter's Head", --BC
	[11379] = "Super Hot Stew", --BC
	[11380] = "Manalicious", --BC
	[11381] = "Soup for the Soul", --BC
	[11382] = "Wanted: Aeonus's Hourglass", --BC
	[11383] = "Wanted: Rift Lords", --BC
	[11384] = "Wanted: A Warp Splinter Clipping", --BC
	[11385] = "Wanted: Sunseeker Channelers", --BC
	[11386] = "Wanted: Pathaleon's Projector", --BC
	[11387] = "Wanted: Tempest-Forge Destroyers", --BC
	[11388] = "Wanted: The Scroll of Skyriss", --BC
	[11389] = "Wanted: Arcatraz Sentinels", --BC
	[11472] = "The Way to His Heart...", --WotLK
	[11496] = "The Sanctum Wards", --BC
	[11499] = "Wanted: The Signet Ring of Prince Kael'thas", --BC
	[11500] = "Wanted: Sisters of Torment", --BC
	[11502] = "In Defense of Halaa", --BC
	[11503] = "Enemies, Old and New", --BC
	[11506] = "Spirits of Auchindoun", --BC
	[11513] = "Intercepting the Mana Cells", --BC
	[11514] = "Maintaining the Sunwell Portal", --BC
	[11515] = "Blood for Blood", --BC
	[11516] = "Blast the Gateway", --BC
	[11520] = "Discovering Your Roots", --BC
	[11521] = "Rediscovering Your Roots", --BC
	[11523] = "Arm the Wards!", --BC
	[11524] = "Erratic Behavior", --BC
	[11525] = "Further Conversions", --BC
	[11532] = "Distraction at the Dead Scar", --BC
	[11533] = "The Air Strikes Must Continue", --BC
	[11535] = "Making Ready", --BC
	[11536] = "Don't Stop Now....", --BC
	[11537] = "The Battle Must Go On", --BC
	[11538] = "The Battle for the Sun's Reach Armory", --BC
	[11539] = "Taking the Harbor", --BC
	[11540] = "Crush the Dawnblade", --BC
	[11541] = "Disrupt the Greengill Coast", --BC
	[11542] = "Intercept the Reinforcements", --BC
	[11543] = "Keeping the Enemy at Bay", --BC
	[11544] = "Ata'mal Armaments", --BC
	[11545] = "A Charitable Donation", --BC
	[11546] = "Open for Business", --BC
	[11547] = "Know Your Ley Lines", --BC
	[11548] = "Your Continued Support", --BC
	[11665] = "Crocolisks in the City", --BC
	[11666] = "Bait Bandits", --BC
	[11667] = "The One That Got Away", --BC
	[11668] = "Shrimpin' Ain't Easy", --BC
	[11669] = "Felblood Fillet", --BC
	[11875] = "Gaining the Advantage", --BC
	[11877] = "Sunfury Attack Plans", --BC
	[11880] = "The Multiphase Survey", --BC
	[11940] = "Drake Hunt", --WotLK
	[11945] = "Preparing for the Worst", --WotLK
	[11960] = "Planning for the Future", --WotLK
	[12038] = "Seared Scourge", --WotLK
	[12268] = "Pieces Parts", --WotLK
	[12280] = "Making Repairs", --WotLK
	[12288] = "Overwhelmed!", --WotLK
	[12296] = "Life or Death", --WotLK
	[12317] = "Keep Them at Bay", --WotLK
	[12324] = "Smoke 'Em Out", --WotLK
	[12372] = "Defending Wyrmrest Temple", --WotLK
	[12437] = "Riding the Red Rocket", --WotLK
	[12502] = "Troll Patrol: High Standards", --WotLK
	[12509] = "Troll Patrol: Intestinal Fortitude", --WotLK
	[12519] = "Troll Patrol: Whatdya Want, a Medal?", --WotLK
	[12541] = "Troll Patrol: The Alchemist's Apprentice", --WotLK
	[12563] = "Troll Patrol", --WotLK
	[12564] = "Troll Patrol: Something for the Pain", --WotLK
	[12568] = "Troll Patrol: Done to Death", --WotLK
	[12582] = "Frenzyheart Champion", --WotLK
	[12585] = "Troll Patrol: Creature Comforts", --WotLK
	[12588] = "Troll Patrol: Can You Dig It?", --WotLK
	[12591] = "Troll Patrol: Throwing Down", --WotLK
	[12594] = "Troll Patrol: Couldn't Care Less", --WotLK
	[12601] = "The Alchemist's Apprentice", --WotLK
	[12604] = "Congratulations!", --WotLK
	[12689] = "Hand of the Oracles", --WotLK
	[12702] = "Chicken Party!", --WotLK
	[12703] = "Kartak's Rampage", --WotLK
	[12704] = "Appeasing the Great Rain Stone", --WotLK
	[12705] = "Will of the Titans", --WotLK
	[12726] = "Song of Wind and Water", --WotLK
	[12732] = "The Heartblood's Strength", --WotLK
	[12734] = "Rejek: First Blood", --WotLK
	[12735] = "A Cleansing Song", --WotLK
	[12736] = "Song of Reflection", --WotLK
	[12737] = "Song of Fecundity", --WotLK
	[12741] = "Strength of the Tempest", --WotLK
	[12758] = "A Hero's Headgear", --WotLK
	[12759] = "Tools of War", --WotLK
	[12760] = "Secret Strength of the Frenzyheart", --WotLK
	[12761] = "Mastery of the Crystals", --WotLK
	[12762] = "Power of the Great Ones", --WotLK
	[12813] = "From Their Corpses, Rise!", --WotLK
	[12815] = "No Fly Zone", --WotLK
	[12833] = "Overstock", --WotLK
	[12838] = "Intelligence Gathering", --WotLK
	[12869] = "Pushed Too Far", --WotLK
	[12958] = "Shipment: Blood Jade Amulet", --WotLK
	[12959] = "Shipment: Glowing Ivory Figurine", --WotLK
	[12960] = "Shipment: Wicked Sun Brooch", --WotLK
	[12961] = "Shipment: Intricate Bone Figurine", --WotLK
	[12962] = "Shipment: Bright Armor Relic", --WotLK
	[12963] = "Shipment: Shifting Sun Curio", --WotLK
	[12977] = "Blowing Hodir's Horn", --WotLK
	[12981] = "Hot and Cold", --WotLK
	[12994] = "Spy Hunter", --WotLK
	[12995] = "Leave Our Mark", --WotLK
	[13003] = "Thrusting Hodir's Spear", --WotLK
	[13006] = "Polishing the Helm", --WotLK
	[13046] = "Feeding Arngrim", --WotLK
	[13069] = "Shoot 'Em Up", --WotLK
	[13071] = "Vile Like Fire!", --WotLK
	[13101] = "Convention at the Legerdemain", --WotLK
	[13112] = "Infused Mushroom Meatloaf", --WotLK
	[13114] = "Sewer Stew", --WotLK
	[13115] = "Cheese for Glowergold", --WotLK
	[13116] = "Mustard Dogs!", --WotLK
	[13190] = "All Things in Good Time", --WotLK
	[13191] = "Fueling the Demolishers", --WotLK
	[13195] = "A Rare Herb", --WotLK
	[13199] = "Bones and Arrows", --WotLK
	[13201] = "Healing with Roses", --WotLK
	[13222] = "Defend the Siege", --WotLK
	[13240] = "Timear Foresees Centrifuge Constructs in your Future!", --WotLK
	[13241] = "Timear Foresees Ymirjar Berserkers in your Future!", --WotLK
	[13243] = "Timear Foresees Infinite Agents in your Future!", --WotLK
	[13244] = "Timear Foresees Titanium Vanguards in your Future!", --WotLK
	[13245] = "Proof of Demise: Ingvar the Plunderer", --WotLK
	[13246] = "Proof of Demise: Keristrasza", --WotLK
	[13247] = "Proof of Demise: Ley-Guardian Eregos", --WotLK
	[13248] = "Proof of Demise: King Ymiron", --WotLK
	[13249] = "Proof of Demise: The Prophet Tharon'ja", --WotLK
	[13250] = "Proof of Demise: Gal'darah", --WotLK
	[13251] = "Proof of Demise: Mal'Ganis", --WotLK
	[13252] = "Proof of Demise: Sjonnir The Ironshaper", --WotLK
	[13253] = "Proof of Demise: Loken", --WotLK
	[13254] = "Proof of Demise: Anub'arak", --WotLK
	[13255] = "Proof of Demise: Herald Volazj", --WotLK
	[13256] = "Proof of Demise: Cyanigosa", --WotLK
	[13261] = "Volatility", --WotLK
	[13276] = "That's Abominable!", --WotLK
	[13283] = "King of the Mountain", --WotLK
	[13292] = "The Solution Solution", --WotLK
	[13297] = "Neutralizing the Plague", --WotLK
	[13302] = "Slaves to Saronite", --WotLK
	[13323] = "Drag and Drop", --WotLK
	[13331] = "Keeping the Alliance Blind", --WotLK
	[13333] = "Capture More Dispatches", --WotLK
	[13336] = "Blood of the Chosen", --WotLK
	[13344] = "Not a Bug", --WotLK
	[13357] = "Retest Now", --WotLK
	[13368] = "No Rest For The Wicked", --WotLK
	[13376] = "Total Ohmage: The Valley of Lost Hope!", --WotLK
	[13382] = "Putting the Hertz: The Valley of Lost Hope", --WotLK
	[13404] = "Static Shock Troops: the Bombardment", --WotLK
	[13406] = "Riding the Wavelength: The Bombardment", --WotLK
	[13414] = "Aces High!", --WotLK
	[13422] = "Maintaining Discipline", --WotLK
	[13423] = "Defending Your Title", --WotLK
	[13424] = "Back to the Pit", --WotLK
	[13425] = "The Aberrations Must Die", --WotLK
	[13427] = "Call to Arms: Alterac Valley", --C
}

local tt = CreateFrame("GameTooltip", "QuestScanTT", UIParent, "GameTooltipTemplate")


function module:CheckTTScan()
	local i = 1
	for k, v in pairs(qTable) do
		tt:SetOwner(UIParent, "ANCHOR_NONE")
		tt:SetHyperlink("quest:"..k)
		tt:Show()
		print( QuestScanTTTextLeft1:GetText() )
		i = i +1
	end
	D("Number Scanned:", i)	
end

function module:ScanTTALL()
	for k, v in pairs(qTable) do
		tt:SetOwner(UIParent, "ANCHOR_NONE")
		tt:SetHyperlink("quest:"..k)
		tt:Show()
	end
end

function module:ScanTooltips()
	self:ScanTTALL()
	self:CheckTTScan()
end


function module:CommitLocalizedNames()
	SOCD.db.profile.Scanner = {}
	dbo = SOCD.db.profile.Scanner
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
print("Hi")
