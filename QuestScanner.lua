--[[
 

]]

local projectVersion = "@project-version@"
local projectRevision = "@project-abbreviated-hash@"
if projectVersion:find("project") then
	projectVersion = "git"
	projectRevision = "dev"
end

local lastChanged = "@file-date-integer@"

local AddonName, AddonParent = ...
local module = AddonParent:NewModule("QuestScanner", "AceEvent-3.0")
local localeQuestNameByID
local dbo

function module:OnInitialize()
		--Addon's Main OnEnable does the version check and starts it if needed
		--However, we want to set the db up here just in case.
	dbo = AddonParent.db.global.QuestNameCache
	localeQuestNameByID = AddonParent.db.global.localeQuestNameByID
end

--function module:OnEnable()
--	self:Debug("OnEnable, starting Scan")
--	return self:StartScan()
--end
function module:OnEnable()
	if AddonParent.db.global.currentRev ~= lastChanged then
		return self:StartScan()
	else
		AddonParent:SendMessage("SOCD_QuestByID_Ready")
		AddonParent.QuestNameScanned = true
	end
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
	[12170] = "Blackriver Brawl", --WotLK
	[12315] = "Crush Captain Brightwater!", --WotLK
	[13202] = "Jinxing the Walls", --WotLK
	[12284] = "Keep 'Em on Their Heels", --WotLK
	[13234] = "Make Them Pay!", --WotLK
	[12270] = "Shred the Alliance", --WotLK
	[13178] = "Slay them all!", --WotLK
	[13192] = "Warding the Walls", --WotLK
	[13284] = "Assault by Ground", --WotLK
	[13309] = "Assault by Air", --WotLK
	[13177] = "No Mercy for the Merciless",
	[13186] = "Stop the Siege",
	[13181] = "Victory in Wintergrasp",
	[13198] = "Warding the Warriors",
	[13538] = "Southern Sabotage",
	[13539] = "Toppling the Towers",


	[13675] = "The Edge Of Winter",	--WotLK
	[13674] = "A Worthy Weapon", 	--WotLK
	[13673] = "A Blade Fit For A Champion",	--WotLK

	[13676] = "Training In The Field",	--WotLK
	[13677] = "Learning The Reins",	--WotLK

	[13857] = "At The Enemy's Gates",
	[13772] = "The Grand Melee",
	[13771] = "A Valiant's Field Training",

	[13861] = "Battle Before The Citadel",	--WotLK
	[13682] = "Threat From Above",	--WotLK
	[13790] = "Among the Champions",	--WotLK
	[13789] = "Taking Battle To The Enemy",	--WotLK
	[13846] = "Contributin' To The Cause", --WotLK



	[13833] = "Blood Is Thicker", --WotLK
	[13834] = "Dangerously Delicious", --WotLK
	[13832] = "Jewel Of The Sewers", --WotLK
	[13836] = "Disarmed!", --WotLK
	[13830] = "The Ghostfish", --WotLK


	[14096] = "You've Really Done It This Time, Kul", --WotLK
	[14152] = "Rescue at Sea", --WotLK
	[14074] = "A Leg Up", --WotLK
	[14077] = "The Light's Mercy", --WotLK
	[14080] = "Stop The Aggressors", --WotLK
	[14076] = "Breakfast Of Champions", --WotLK
	[14090] = "Gormok Wants His Snobolds", --WotLK
	[14112] = "What Do You Feed a Yeti, Anyway?", --WotLK

	[14107] = "The Fate Of The Fallen", --WotLK
	[14108] = "Get Kraken!", --WotLK
	[14101] = "Drottinn Hrothgar", --WotLK
	[14102] = "Mistcaller Yngvar", --WotLK
	[14104] = "Ornolf The Scarred", --WotLK
	[14105] = "Deathspeaker Kharos", --WotLK

	[13903] = "Gorishi Grub", --WotLK
	[13915] = "Hungry, Hungry Hatchling", --WotLK
	[13904] = "Poached, Scrambled, Or Raw?", --WotLK
	[13905] = "Searing Roc Feathers", --WotLK

	[11408] = "Bark for T'chali's Voodoo Brewery!",	--BC
	[11407] = "Bark for Drohn's Distillery!",	--BC
	[11293] = "Bark for the Barleybrews!",	--BC
	[11294] = "Bark for the Thunderbrews!",	--BC
	[12062] = "Insult Coren Direbrew",	--BC
	[12192] = "This One Time, When I Was Drunk...",	--BC


	[12404] = "Candy Bucket", --BC

	[14061] = "Can't Get Enough Turkey", --WotLK
	[14062] = "Don't Forget The Stuffing!", --WotLK
	[14060] = "Easy As Pie", --WotLK
	[14058] = "She Says Potato", --WotLK
	[14059] = "We're Out of Cranberry Chutney Again?", --WotLK


	[24580] = "Anub'Rekhan Must Die!",
	[24585] = "Flame Leviathan Must Die!",
	[24587] = "Ignis the Furnace Master Must Die!",
	[24582] = "Instructor Razuvious Must Die!",
	[24589] = "Lord Jaraxxus Must Die!",
	[24590] = "Lord Marrowgar Must Die!",
	[24584] = "Malygos Must Die!",
	[24581] = "Noth the Plaguebringer Must Die!",
	[24583] = "Patchwerk Must Die!",
	[24586] = "Razorscale Must Die!",
	[24579] = "Sartharion Must Die!",
	[24588] = "XT-002 Deconstructor Must Die!",

	[24879] = "Blood Quickening",
	[24875] = "Deprogramming",
	[24878] = "Residue Rendezvous",
	[24880] = "Respite for a Tormented Soul",
	[24877] = "Securing the Ramparts",

}	--End of name Scanner Master Table


local tt = CreateFrame("GameTooltip", "SOCDQuestScanTT", UIParent, "GameTooltipTemplate")
local ttlt = _G[tt:GetName().."TextLeft1"]
local ttScanFrame = CreateFrame("frame")
ttScanFrame:Hide()
do
	tt:SetScript("OnTooltipSetQuest", function(self, ...)
		module:Debug("OnTooltipSetQuest", self.questId)
		if (not self.questId) or (not self.englishQuestTitle) then
			self:Debug("Invalid Setup for SOCD Quest Scanning")
			ttScanFrame:Hide()
		end
		local questTitleText = (ttlt:GetText() or ""):trim()
		dbo[questTitleText] = true
		localeQuestNameByID[ tonumber(self.questId) ] = questTitleText

		self.count = self.count + 1

		module:Debug("Caching:", self.questId, self.englishQuestTitle, "-->", questTitleText )

		local id, eName = next(qTable, self.questId)
		if not id or not eName then
			module:Debug("Reached end of Quest table. Total Quests Scanned:", self.count)
			AddonParent.db.global.currentRev = lastChanged
			AddonParent.QuestNameScanned = true
			AddonParent:SendMessage("SOCD_QuestByID_Ready")
			ttScanFrame:Hide()
			return
		end
		self.questId = id
		self.englishQuestTitle = eName
		module:Debug("Showing scan frame:")
		ttScanFrame:Show()
		return
	end)


	local interval, delay = .01, 0
	ttScanFrame:SetScript("OnUpdate", function(self, elapsed)
		module:Debug("OnUpdate", delay, elapsed, tt.questId)
		delay = delay + elapsed
		if delay > interval then
			delay = 0
			self:Hide()
			return tt:SetHyperlink("quest:"..tt.questId)
		end
	end)

end
function module:StartScan()
	self:Debug("Starting Localized Tooltip Scan")
	local id, eName = next(qTable)
	tt.questId = id
	tt.englishQuestTitle = eName
	tt.count = 0
--	ttScanFrame:Show()
	return tt:SetHyperlink( ("quest:%d"):format(id) )
end
function module:StopScan(info)
	self:Debug("Stopping Tooltip Scanning?")
	ttScanFrame:Hide()
end



function AddonParent.GetLocalizedQuestNameByID(id)
	id = tonumber(id)
	return localeQuestNameByID and localeQuestNameByID[id] or nil
end
