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
local daily, weekly, repeatable = "D", "W", "R"
local qTable = {
	[4970] = repeatable,	--"Frostsaber Provisions", --C
	[5201] = repeatable,	--"Winterfall Intrusion", --C
	[5981] = repeatable,	--"Rampaging Giants", --C
	[10110] = daily,	--"Hellfire Fortifications", --BC
	[11008] = daily,	--"Fires Over Skettis", --BC
	[11015] = daily,	--"Netherwing Crystals", --BC
	[11016] = daily,	--"Nethermine Flayer Hide", --BC
	[11017] = daily,	--"Netherdust Pollen", --BC
	[11018] = daily,	--"Nethercite Ore", --BC
	[11020] = daily,	--"A Slow Death", --BC
	[11023] = daily,	--"Bomb Them Again!", --BC
	[11035] = daily,	--"The Not-So-Friendly Skies...", --BC
	[11051] = daily,	--"Banish More Demons", --BC
	[11055] = daily,	--"The Booterang: A Cure For The Common Worthless Peon", --BC
	[11066] = daily,	--"Wrangle More Aether Rays!", --BC
	[11076] = daily,	--"Picking Up The Pieces...", --BC
	[11077] = daily,	--"Dragons are the Least of Our Problems", --BC
	[11080] = daily,	--"The Relic's Emanation", --BC
	[11085] = daily,	--"Escape from Skettis", --BC
	[11086] = daily,	--"Disrupting the Twilight Portal", --BC
	[11097] = daily,	--"The Deadliest Trap Ever Laid", --BC
	[11354] = daily,	--"Wanted: Nazan's Riding Crop", --BC
	[11362] = daily,	--"Wanted: Keli'dan's Feathered Stave", --BC
	[11363] = daily,	--"Wanted: Bladefist's Seal", --BC
	[11364] = daily,	--"Wanted: Shattered Hand Centurions", --BC
	[11368] = daily,	--"Wanted: The Heart of Quagmirran", --BC
	[11369] = daily,	--"Wanted: A Black Stalker Egg", --BC
	[11370] = daily,	--"Wanted: The Warlord's Treatise", --BC
	[11371] = daily,	--"Wanted: Coilfang Myrmidons", --BC
	[11372] = daily,	--"Wanted: The Headfeathers of Ikiss", --BC
	[11373] = daily,	--"Wanted: Shaffar's Wondrous Pendant", --BC
	[11374] = daily,	--"Wanted: The Exarch's Soul Gem", --BC
	[11375] = daily,	--"Wanted: Murmur's Whisper", --BC
	[11376] = daily,	--"Wanted: Malicious Instructors", --BC
	[11377] = daily,	--"Revenge is Tasty", --BC
	[11378] = daily,	--"Wanted: The Epoch Hunter's Head", --BC
	[11379] = daily,	--"Super Hot Stew", --BC
	[11380] = daily,	--"Manalicious", --BC
	[11381] = daily,	--"Soup for the Soul", --BC
	[11382] = daily,	--"Wanted: Aeonus's Hourglass", --BC
	[11383] = daily,	--"Wanted: Rift Lords", --BC
	[11384] = daily,	--"Wanted: A Warp Splinter Clipping", --BC
	[11385] = daily,	--"Wanted: Sunseeker Channelers", --BC
	[11386] = daily,	--"Wanted: Pathaleon's Projector", --BC
	[11387] = daily,	--"Wanted: Tempest-Forge Destroyers", --BC
	[11388] = daily,	--"Wanted: The Scroll of Skyriss", --BC
	[11389] = daily,	--"Wanted: Arcatraz Sentinels", --BC
	[11472] = daily,	--"The Way to His Heart...", --WotLK
	[11496] = daily,	--"The Sanctum Wards", --BC
	[11499] = daily,	--"Wanted: The Signet Ring of Prince Kael'thas", --BC
	[11500] = daily,	--"Wanted: Sisters of Torment", --BC
	[11502] = daily,	--"In Defense of Halaa", --BC
	[11503] = daily,	--"Enemies, Old and New", --BC
	[11506] = daily,	--"Spirits of Auchindoun", --BC
	[11513] = daily,	--"Intercepting the Mana Cells", --BC
	[11514] = daily,	--"Maintaining the Sunwell Portal", --BC
	[11515] = daily,	--"Blood for Blood", --BC
	[11516] = daily,	--"Blast the Gateway", --BC
	[11520] = daily,	--"Discovering Your Roots", --BC
	[11521] = daily,	--"Rediscovering Your Roots", --BC
	[11523] = daily,	--"Arm the Wards!", --BC
	[11524] = daily,	--"Erratic Behavior", --BC
	[11525] = daily,	--"Further Conversions", --BC
	[11532] = daily,	--"Distraction at the Dead Scar", --BC
	[11533] = daily,	--"The Air Strikes Must Continue", --BC
	[11535] = daily,	--"Making Ready", --BC
	[11536] = daily,	--"Don't Stop Now....", --BC
	[11537] = daily,	--"The Battle Must Go On", --BC
	[11538] = daily,	--"The Battle for the Sun's Reach Armory", --BC
	[11539] = daily,	--"Taking the Harbor", --BC
	[11540] = daily,	--"Crush the Dawnblade", --BC
	[11541] = daily,	--"Disrupt the Greengill Coast", --BC
	[11542] = daily,	--"Intercept the Reinforcements", --BC
	[11543] = daily,	--"Keeping the Enemy at Bay", --BC
	[11544] = daily,	--"Ata'mal Armaments", --BC
	[11545] = daily,	--"A Charitable Donation", --BC
	[11546] = daily,	--"Open for Business", --BC
	[11547] = daily,	--"Know Your Ley Lines", --BC
	[11548] = daily,	--"Your Continued Support", --BC
	[11665] = daily,	--"Crocolisks in the City", --BC
	[11666] = daily,	--"Bait Bandits", --BC
	[11667] = daily,	--"The One That Got Away", --BC
	[11668] = daily,	--"Shrimpin' Ain't Easy", --BC
	[11669] = daily,	--"Felblood Fillet", --BC
	[11875] = daily,	--"Gaining the Advantage", --BC
	[11877] = daily,	--"Sunfury Attack Plans", --BC
	[11880] = daily,	--"The Multiphase Survey", --BC
	[11940] = daily,	--"Drake Hunt", --WotLK
	[11945] = daily,	--"Preparing for the Worst", --WotLK
	[11960] = daily,	--"Planning for the Future", --WotLK
	[12038] = daily,	--"Seared Scourge", --WotLK
	[12268] = daily,	--"Pieces Parts", --WotLK
	[12280] = daily,	--"Making Repairs", --WotLK
	[12288] = daily,	--"Overwhelmed!", --WotLK
	[12296] = daily,	--"Life or Death", --WotLK
	[12317] = daily,	--"Keep Them at Bay", --WotLK
	[12324] = daily,	--"Smoke 'Em Out", --WotLK
	[12372] = daily,	--"Defending Wyrmrest Temple", --WotLK
	[12437] = daily,	--"Riding the Red Rocket", --WotLK
	[12502] = daily,	--"Troll Patrol: High Standards", --WotLK
	[12509] = daily,	--"Troll Patrol: Intestinal Fortitude", --WotLK
	[12519] = daily,	--"Troll Patrol: Whatdya Want, a Medal?", --WotLK
	[12541] = daily,	--"Troll Patrol: The Alchemist's Apprentice", --WotLK
	[12563] = daily,	--"Troll Patrol", --WotLK
	[12564] = daily,	--"Troll Patrol: Something for the Pain", --WotLK
	[12568] = daily,	--"Troll Patrol: Done to Death", --WotLK
	[12582] = daily,	--"Frenzyheart Champion", --WotLK
	[12585] = daily,	--"Troll Patrol: Creature Comforts", --WotLK
	[12588] = daily,	--"Troll Patrol: Can You Dig It?", --WotLK
	[12591] = daily,	--"Troll Patrol: Throwing Down", --WotLK
	[12594] = daily,	--"Troll Patrol: Couldn't Care Less", --WotLK
	[12601] = daily,	--"The Alchemist's Apprentice", --WotLK
	[12604] = daily,	--"Congratulations!", --WotLK
	[12689] = daily,	--"Hand of the Oracles", --WotLK
	[12702] = daily,	--"Chicken Party!", --WotLK
	[12703] = daily,	--"Kartak's Rampage", --WotLK
	[12704] = daily,	--"Appeasing the Great Rain Stone", --WotLK
	[12705] = daily,	--"Will of the Titans", --WotLK
	[12726] = daily,	--"Song of Wind and Water", --WotLK
	[12732] = daily,	--"The Heartblood's Strength", --WotLK
	[12734] = daily,	--"Rejek: First Blood", --WotLK
	[12735] = daily,	--"A Cleansing Song", --WotLK
	[12736] = daily,	--"Song of Reflection", --WotLK
	[12737] = daily,	--"Song of Fecundity", --WotLK
	[12741] = daily,	--"Strength of the Tempest", --WotLK
	[12758] = daily,	--"A Hero's Headgear", --WotLK
	[12759] = daily,	--"Tools of War", --WotLK
	[12760] = daily,	--"Secret Strength of the Frenzyheart", --WotLK
	[12761] = daily,	--"Mastery of the Crystals", --WotLK
	[12762] = daily,	--"Power of the Great Ones", --WotLK
	[12813] = daily,	--"From Their Corpses, Rise!", --WotLK
	[12815] = daily,	--"No Fly Zone", --WotLK
	[12833] = daily,	--"Overstock", --WotLK
	[12838] = daily,	--"Intelligence Gathering", --WotLK
	[12869] = daily,	--"Pushed Too Far", --WotLK
	[12958] = daily,	--"Shipment: Blood Jade Amulet", --WotLK
	[12959] = daily,	--"Shipment: Glowing Ivory Figurine", --WotLK
	[12960] = daily,	--"Shipment: Wicked Sun Brooch", --WotLK
	[12961] = daily,	--"Shipment: Intricate Bone Figurine", --WotLK
	[12962] = daily,	--"Shipment: Bright Armor Relic", --WotLK
	[12963] = daily,	--"Shipment: Shifting Sun Curio", --WotLK
	[12977] = daily,	--"Blowing Hodir's Horn", --WotLK
	[12981] = daily,	--"Hot and Cold", --WotLK
	[12994] = daily,	--"Spy Hunter", --WotLK
	[12995] = daily,	--"Leave Our Mark", --WotLK
	[13003] = daily,	--"Thrusting Hodir's Spear", --WotLK
	[13006] = daily,	--"Polishing the Helm", --WotLK
	[13046] = daily,	--"Feeding Arngrim", --WotLK
	[13069] = daily,	--"Shoot 'Em Up", --WotLK
	[13071] = daily,	--"Vile Like Fire!", --WotLK
	[13101] = daily,	--"Convention at the Legerdemain", --WotLK
	[13112] = daily,	--"Infused Mushroom Meatloaf", --WotLK
	[13114] = daily,	--"Sewer Stew", --WotLK
	[13115] = daily,	--"Cheese for Glowergold", --WotLK
	[13116] = daily,	--"Mustard Dogs!", --WotLK
	[13190] = daily,	--"All Things in Good Time", --WotLK
	[13191] = daily,	--"Fueling the Demolishers", --WotLK
	[13195] = daily,	--"A Rare Herb", --WotLK
	[13199] = daily,	--"Bones and Arrows", --WotLK
	[13201] = daily,	--"Healing with Roses", --WotLK
	[13222] = daily,	--"Defend the Siege", --WotLK
	[13261] = daily,	--"Volatility", --WotLK
	[13276] = daily,	--"That's Abominable!", --WotLK
	[13283] = daily,	--"King of the Mountain", --WotLK
	[13292] = daily,	--"The Solution Solution", --WotLK
	[13297] = daily,	--"Neutralizing the Plague", --WotLK
	[13302] = daily,	--"Slaves to Saronite", --WotLK
	[13323] = daily,	--"Drag and Drop", --WotLK
	[13331] = daily,	--"Keeping the Alliance Blind", --WotLK
	[13333] = daily,	--"Capture More Dispatches", --WotLK
	[13336] = daily,	--"Blood of the Chosen", --WotLK
	[13344] = daily,	--"Not a Bug", --WotLK
	[13357] = daily,	--"Retest Now", --WotLK
	[13368] = daily,	--"No Rest For The Wicked", --WotLK
	[13376] = daily,	--"Total Ohmage: The Valley of Lost Hope!", --WotLK
	[13382] = daily,	--"Putting the Hertz: The Valley of Lost Hope", --WotLK
	[13404] = daily,	--"Static Shock Troops: the Bombardment", --WotLK
	[13406] = daily,	--"Riding the Wavelength: The Bombardment", --WotLK
	[13414] = daily,	--"Aces High!", --WotLK
	[13422] = daily,	--"Maintaining Discipline", --WotLK
	[13423] = daily,	--"Defending Your Title", --WotLK
	[13424] = daily,	--"Back to the Pit", --WotLK
	[13425] = daily,	--"The Aberrations Must Die", --WotLK
	[12170] = daily,	--"Blackriver Brawl", --WotLK
	[12315] = daily,	--"Crush Captain Brightwater!", --WotLK
	[12284] = daily,	--"Keep 'Em on Their Heels", --WotLK
	[13234] = daily,	--"Make Them Pay!", --WotLK
	[12270] = daily,	--"Shred the Alliance", --WotLK
	[13284] = daily,	--"Assault by Ground", --WotLK
	[13309] = daily,	--"Assault by Air", --WotLK


	[13202] = weekly,	--"Jinxing the Walls", --WotLK
	[13178] = weekly,	--"Slay them all!", --WotLK
	[13192] = weekly,	--"Warding the Walls", --WotLK
	[13177] = weekly,	--"No Mercy for the Merciless",
	[13186] = weekly,	--"Stop the Siege",
	[13181] = weekly,	--"Victory in Wintergrasp",
	[13198] = weekly,	--"Warding the Warriors",
	[13538] = weekly,	--"Southern Sabotage",
	[13539] = weekly,	--"Toppling the Towers",


	[13675] = daily,	--"The Edge Of Winter",	--WotLK
	[13674] = daily,	--"A Worthy Weapon", 	--WotLK
	[13673] = daily,	--"A Blade Fit For A Champion",	--WotLK

	[13676] = daily,	--"Training In The Field",	--WotLK
	[13677] = daily,	--"Learning The Reins",	--WotLK

	[13857] = daily,	--"At The Enemy's Gates",
	[13772] = daily,	--"The Grand Melee",
	[13771] = daily,	--"A Valiant's Field Training",

	[13861] = daily,	--"Battle Before The Citadel",	--WotLK
	[13682] = daily,	--"Threat From Above",	--WotLK
	[13790] = daily,	--"Among the Champions",	--WotLK
	[13789] = daily,	--"Taking Battle To The Enemy",	--WotLK
	[13846] = daily,	--"Contributin' To The Cause", --WotLK



	[13833] = daily,	--"Blood Is Thicker", --WotLK
	[13834] = daily,	--"Dangerously Delicious", --WotLK
	[13832] = daily,	--"Jewel Of The Sewers", --WotLK
	[13836] = daily,	--"Disarmed!", --WotLK
	[13830] = daily,	--"The Ghostfish", --WotLK


	[14096] = daily,	--"You've Really Done It This Time, Kul", --WotLK
	[14152] = daily,	--"Rescue at Sea", --WotLK
	[14074] = daily,	--"A Leg Up", --WotLK
	[14077] = daily,	--"The Light's Mercy", --WotLK
	[14080] = daily,	--"Stop The Aggressors", --WotLK
	[14076] = daily,	--"Breakfast Of Champions", --WotLK
	[14090] = daily,	--"Gormok Wants His Snobolds", --WotLK
	[14112] = daily,	--"What Do You Feed a Yeti, Anyway?", --WotLK

	[14107] = daily,	--"The Fate Of The Fallen", --WotLK
	[14108] = daily,	--"Get Kraken!", --WotLK
	[14101] = daily,	--"Drottinn Hrothgar", --WotLK
	[14102] = daily,	--"Mistcaller Yngvar", --WotLK
	[14104] = daily,	--"Ornolf The Scarred", --WotLK
	[14105] = daily,	--"Deathspeaker Kharos", --WotLK

	[13903] = daily,	--"Gorishi Grub", --WotLK
	[13915] = daily,	--"Hungry, Hungry Hatchling", --WotLK
	[13904] = daily,	--"Poached, Scrambled, Or Raw?", --WotLK
	[13905] = daily,	--"Searing Roc Feathers", --WotLK

	[11408] = daily,	--"Bark for T'chali's Voodoo Brewery!",	--BC
	[11407] = daily,	--"Bark for Drohn's Distillery!",	--BC
	[11293] = daily,	--"Bark for the Barleybrews!",	--BC
	[11294] = daily,	--"Bark for the Thunderbrews!",	--BC
	[12062] = daily,	--"Insult Coren Direbrew",	--BC
	[12192] = daily,	--"This One Time, When I Was Drunk...",	--BC


	[12404] = repeatable,	--"Candy Bucket", --BC

	[14061] = daily,	--"Can't Get Enough Turkey", --WotLK
	[14062] = daily,	--"Don't Forget The Stuffing!", --WotLK
	[14060] = daily,	--"Easy As Pie", --WotLK
	[14058] = daily,	--"She Says Potato", --WotLK
	[14059] = daily,	--"We're Out of Cranberry Chutney Again?", --WotLK


	[24580] = weekly,	--"Anub'Rekhan Must Die!",
	[24585] = weekly,	--"Flame Leviathan Must Die!",
	[24587] = weekly,	--"Ignis the Furnace Master Must Die!",
	[24582] = weekly,	--"Instructor Razuvious Must Die!",
	[24589] = weekly,	--"Lord Jaraxxus Must Die!",
	[24590] = weekly,	--"Lord Marrowgar Must Die!",
	[24584] = weekly,	--"Malygos Must Die!",
	[24581] = weekly,	--"Noth the Plaguebringer Must Die!",
	[24583] = weekly,	--"Patchwerk Must Die!",
	[24586] = weekly,	--"Razorscale Must Die!",
	[24579] = weekly,	--"Sartharion Must Die!",
	[24588] = weekly,	--"XT-002 Deconstructor Must Die!",

	[24879] = weekly,	--"Blood Quickening",
	[24875] = weekly,	--"Deprogramming",
	[24878] = weekly,	--"Residue Rendezvous",
	[24880] = weekly,	--"Respite for a Tormented Soul",
	[24877] = weekly,	--"Securing the Ramparts",

}	--End of name Scanner Master Table


local tt = CreateFrame("GameTooltip", "SOCDQuestScanTT", UIParent, "GameTooltipTemplate")
local ttlt = _G[tt:GetName().."TextLeft1"]
local ttScanFrame = CreateFrame("frame")
ttScanFrame:Hide()
do
	tt:SetScript("OnTooltipSetQuest", function(self, ...)
--		module:Debug("OnTooltipSetQuest", self.questId)
		if (not self.questId) or (not self.qtype) then
			module:Debug("Invalid Setup for SOCD Quest Scanning")
			ttScanFrame:Hide()
		end
		local questTitleText = (ttlt:GetText() or ""):trim()
		dbo[questTitleText] = self.qtype
		localeQuestNameByID[ tonumber(self.questId) ] = questTitleText

		self.count = self.count + 1

		module:Debug("Caching:", self.questId, "-->", questTitleText )

		local id, qtype = next(qTable, self.questId)
		if not id or not qtype then
			module:Debug("Reached end of Quest table. Total Quests Scanned:", self.count)
			AddonParent.db.global.currentRev = lastChanged
			AddonParent.QuestNameScanned = true
			AddonParent:SendMessage("SOCD_QuestByID_Ready")
			ttScanFrame:Hide()
			return
		end
		self.questId = id
		self.qtype = qtype
--		module:Debug("Showing scan frame:")
		ttScanFrame:Show()
		return
	end)


	local interval, delay = .01, 0
	ttScanFrame:SetScript("OnUpdate", function(self, elapsed)
--		module:Debug("OnUpdate", delay, elapsed, tt.questId)
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
	local id, qtype = next(qTable)
	tt.questId = id
	tt.qtype = qtype
	tt.count = 0
--	ttScanFrame:Show()
	return tt:SetHyperlink( ("quest:%d"):format(id) )
end
function module:StopScan(info)
	self:Debug("Stopping Tooltip Scanning?")
	ttScanFrame:Hide()
end



function AddonParent.GetLocalizedQuestNameByID(self, id)
	if id then
		return localeQuestNameByID and localeQuestNameByID[id] or nil
	else
		id = tonumber(self)
		return localeQuestNameByID and localeQuestNameByID[id] or nil
	end
end
