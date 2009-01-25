--
-- General Localizations here
--
-- ruRU Translation by Crafty

local L = LibStub("AceLocale-3.0"):NewLocale("SOCD_Core", "ruRU")
if not L then return end

if L then
	L["Sick Of Clicking Dailies"] = true
	L["Module Control"] = "Управление модулями"
	L["PvP"] = PVP
	L["World PvP"] = "Глобальное PvP"
	L["Battlegrounds"] = BATTLEFIELDS
	L["Netural"] = FACTION_STANDING_LABEL4
	L["Friendly"] = FACTION_STANDING_LABEL5
	L["Honored"] = FACTION_STANDING_LABEL6
	L["Revered"] = FACTION_STANDING_LABEL7
	L["Faction"] = FACTION
	L["None"] = LFG_TYPE_NONE
	L["Quest Rewards"] = "Награды за задание"
	L["Quests"] = QUESTS_LABEL
	L["Wanted: "] = "Розыск: "  --Used in Instance quest for dsplay...
	L["Horde"] = FACTION_HORDE
	L["Alliance"] = FACTION_ALLIANCE

	--Classic Section
	L["Classic WoW"] = true
	L["Wintersaber Trainers"] = "Укротители ледопардов"


	--BC Section
	L["Burning Crusade"] = true
		--Instances		Might include instance soft names here, but that would break some automagic stuff
	L["Instances"] = "Подземелья"
	L["Heroic Instances"] = "Подземелья героического уровня сложности"
		--Factions
	L["Sha'tari Skyguard"] = "Стражи Небес Ша'тар"
	L["Og'rila"] = "Огри'ла"
	L["Netherwing"] = "Крылья Пустоты"
			--SSO
	L["Shattered Sun Offensive"] = "Армия Расколотого Солнца"
	L["SSO Phase 1"] = "Sun's Reach Sanctum"
	L["SSO Phase 2a"] = "Sun's Reach Armory"
	L["SSO Phase 2b"] = "Sunwell Portal"
	L["SSO Phase 3a"] = "Sun's Reach Harbor"
	L["SSO Phase 3b"] = "Sun's Reach Anvil"
	L["SSO Phase 4a"] = "Alchemy Lab"
	L["SSO Phase 4b"] = "Memorial"
	L["SSO Phase 4c"] = "Final"
	L["SSO_MISC"] = "SSO Misc. Quests"
		--Professions
	L["Professions"] = TRADE_SKILLS
	L["Cooking"] = (GetSpellInfo(2550))
	L["Fishing"] = (GetSpellInfo(7733))
	L["Jewelcrafting"] = (GetSpellInfo(25229))

	--LichKing
	L["LK"] = "Lich King"
		--Factions
	L["The Wyrmrest Accord"] = "Драконий союз"
	L["Sholazar Basin"] = "Низина Шолазар"
	L["The Oracles"] = "Оракулы"
	L["Frenzyheart Tribe"] = "Племя Бешеного Сердца"
	L["The Sons of Hodir"] = "Сыновья Ходира"
	L["Argent Crusade"] = "Серебряный Авангард"
	L["Knights of the Ebon Blade"] = "Рыцари Черного Клинка"
	L["The Kalu'ak"] = "Калу'ак"
	L["The Storm Peaks"] = "Грозовая Гряда"
	L["The Frostborn"] = "Зиморожденные"

		--Misc Titles
	L["Shared Faction Quests"] = "Общие задания"
	L["Icecrown"] = "Ледяная Корона"
	L["Grizzly Hills"] = "Седые холмы"
	L["Wintergrasp"] = "Озеро Ледяных Оков"
	L["Shared Quests"] = true
	L["Icecrown Netural Quests"] = true
	L["Troll Patrol: "] = "Тролльский патруль: " --There is a space at the end, this is used to clip ugly quests.
	L["Shipment: "] = "Заказ от торговой компании: " --There is also a space at the end of here..
	L["Proof of Demise: "] = "Доказательство смерти: "
	L["Timear Foresees (.+) in your Future!"] = "(.+)" --regex leave the (.+) in the middle there.
	L["Faction Token"] = "Жетоны репутации"


end

--All Quests Classified by orgin / content location
--
--	Classic
--
--
local C = LibStub("AceLocale-3.0"):NewLocale("SOCD_Classic", "ruRU")

if C then
--Wintersaber Trainer
	C["Frostsaber Provisions"] = "Накормить ледопардов"
	C["Winterfall Intrusion"] = "Вторжение племени Зимней Спячки"
	C["Rampaging Giants"] = "Истребление великанов"

--PvP
	C["Call to Arms: Warsong Gulch"] = "К оружию! Ущелье Песни Войны"
	C["Call to Arms: Arathi Basin"] = "К оружию! Низина Арати"
	C["Call to Arms: Alterac Valley"] = "К оружию! Альтеракская долина"
end

--
--	TBC
--

local BC = LibStub("AceLocale-3.0"):NewLocale("SOCD_BC", "ruRU")

if BC then
--Skettis Dailies
	BC["Fires Over Skettis"] = "Огонь над Скеттисом"
	BC["Escape from Skettis"] = "Побег из Скеттиса"

--Blade's Edge Mountains
	BC["Wrangle More Aether Rays!"] = "Нам нужно больше воздухоскатов!"
	BC["Bomb Them Again!"] = "Еще разок задать им жару!"
	BC["The Relic's Emanation"] = "Излучение реликвии"
	BC["Banish More Demons"] = "Демонов - долой!"
--Netherwing
	--Netrual
	BC["Nethercite Ore"] = "Хаотитовая Руда"
	BC["Netherdust Pollen"] = "Пыльца хаотического пыльника"
	BC["Nethermine Flayer Hide"] = "Шкуры живодеров-пустокопов"
	BC["Netherwing Crystals"] = "Кристаллы Крыльев Пустоты"
	BC["The Not-So-Friendly Skies..."] = "Недружелюбные небеса"
	BC["A Slow Death"] = "Медленная смерть"
	--Friendly
	BC["Picking Up The Pieces..."] = "Собрать по кусочкам..."
	BC["Dragons are the Least of Our Problems"] = "Драконы - это не самое страшное"
	BC["The Booterang: A Cure For The Common Worthless Peon"] = "Ботиранг: Лекарство для нерадивых работников"
	--Honored
	BC["Disrupting the Twilight Portal"] = "Разрушение Сумеречного Портала"
	--Revered
	BC["The Deadliest Trap Ever Laid"] = "Самая опасная ловушка"

--Shattered Sun Offensive
	--P1
	BC["Erratic Behavior"] = "Хаотичное поведение"
	BC["The Sanctum Wards"] = "Охрана святилища"
	--P2a
	BC["Further Conversions"] = "Дальнейшая перенастройка" --Final for "Erratic Behavior"
	BC["Arm the Wards!"] = "Подпитка для силового поля"  --Final for "The Sanctum Wards"
	BC["The Battle for the Sun's Reach Armory"] = "Сражение за оружейную Солнечного Предела"
	BC["Distraction at the Dead Scar"] = "Отвлекающий маневр на Тропе Мертвых"
	BC["Intercepting the Mana Cells"] = "Перехват контейнеров с маной"
	--P2b
	BC["Maintaining the Sunwell Portal"] = "Поддержка портала Солнечного Колодца"  --Final for "Intercepting the Mana Cells"
	BC["Know Your Ley Lines"] = "Знай свою силовую линию!"
	--P3a
	BC["The Battle Must Go On"] = "Битва должна продолжаться!" --Final for "Battle for Sun's Reach Armory"
	BC["The Air Strikes Must Continue"] = "Воздушные атаки должны продолжаться!"  --Final for "Distraction at the Dad Scar"
	BC["Intercept the Reinforcements"] = "Перехватить подкрепление"
	BC["Taking the Harbor"] = "Захват гавани"
	BC["Making Ready"] = "Подготовка к работе"
	--P3b
	BC["Don't Stop Now...."] = "Продолжаем..."  --Final for "Making Ready"
	BC["Ata'mal Armaments"] = "Оружие Ата'мала"
	--P4a
	BC["Keeping the Enemy at Bay"] = "Загнать врага в угол"  --Final for "Intercept the Reinforcements"
	BC["Crush the Dawnblade"] = "Клинки Рассвета должны быть сокрушены!"  --Final for "Taking the Harbor"
	BC["Discovering Your Roots"] = "Смотри в корень"
	BC["A Charitable Donation"] = "Никто не забыт..."
	BC["Disrupt the Greengill Coast"] = "Зачистить залив Зеленожабрых!"
	--P4b
	BC["Your Continued Support"] = "Щедрое пожертвование"  --FInal for "A Charitable Donation"
	--P4c
	BC["Rediscovering Your Roots"] = "И опять - смотри в корень"  --Final for "Discovering Your Roots"
	BC["Open for Business"] = "Взаимовыгодный бизнес"
	---Misc SSO Quests for Outland
	BC["The Multiphase Survey"] = "Мультифазовый подход"
	BC["Blood for Blood"] = "Кровь за кровь"
	BC["Blast the Gateway"] = "Взрыв врат"
	BC["Sunfury Attack Plans"] = "Военные планы Ярости Солнца"
	BC["Gaining the Advantage"] = "Обретение преимущества"

--Professions - Cooking
	BC["Super Hot Stew"] = "Очень горячая похлебка"
	BC["Soup for the Soul"] = "Супчик для души"
	BC["Revenge is Tasty"] = "Месть сладка"
	BC["Manalicious"] = "Мания"

--Professions - Fishing
	BC["Crocolisks in the City"] = "Кроколиски в городе"
	BC["Bait Bandits"] = "Поймай бандюгу"
	BC["Felblood Fillet"] = "Филе сквернокровного луциана"
	BC["Shrimpin' Ain't Easy"] = "Ловить креветок - это не жук чихнул"
	BC["The One That Got Away"] = "Та самая рыбка"

---Non Heroic Instance
	BC["Wanted: Arcatraz Sentinels"] = "Розыск: Часовые Аркатраца"
	BC["Wanted: Coilfang Myrmidons"] = "Розыск: Мирмидоны Резервуара Кривого Клыка"
	BC["Wanted: Malicious Instructors"] = "Разыскиваются: Злобные инструкторы"
	BC["Wanted: Rift Lords"] = "Розыск: Повелители временных разломов"
	BC["Wanted: Shattered Hand Centurions"] = "РАЗЫСКИВАЮТСЯ: Центурионы клана Изувеченной Длани"
	BC["Wanted: Sunseeker Channelers"] = "Розыск: Солнцеловы-чаротворцы"
	BC["Wanted: Tempest-Forge Destroyers"] = "Розыск: Разрушители Бурегорна"
	BC["Wanted: Sisters of Torment"] = "Заказ: сестры Терзаний"

--Heroic Instance 
	BC["Wanted: A Black Stalker Egg"] = "Требуется: яйцо Черной Охотницы"
	BC["Wanted: A Warp Splinter Clipping"] = "Заказ: Отросток Узлодревня"
	BC["Wanted: Aeonus's Hourglass"] = "Заказ: песочные часы Эонуса"
	BC["Wanted: Bladefist's Seal"] = "Заказ: печать Острорука"
	BC["Wanted: Keli'dan's Feathered Stave"] = "Заказ: Украшенный перьями посох Кели'дана"
	BC["Wanted: Murmur's Whisper"] = "Разыскивается: Шепот Бормотуна"
	BC["Wanted: Nazan's Riding Crop"] = "РОЗЫСК: Ездовой хлыст Назана"
	BC["Wanted: Pathaleon's Projector"] = "Заказ: Проектор Паталеона"
	BC["Wanted: Shaffar's Wondrous Pendant"] = "Разыскивается: Заговоренный Амулет Шаффара"
	BC["Wanted: The Epoch Hunter's Head"] = "Розыск: Голова Охотника Вечности"
	BC["Wanted: The Exarch's Soul Gem"] = "Разыскивается: Самоцвет души Экзарха"
	BC["Wanted: The Headfeathers of Ikiss"] = "Разыскиваются: головные перья Айкисса"
	BC["Wanted: The Heart of Quagmirran"] = "Требуется: сердце Зыбуна"
	BC["Wanted: The Scroll of Skyriss"] = "Заказ: Свиток Скайрисса"
	BC["Wanted: The Warlord's Treatise"] = "Требуется: трактат полководца"
	BC["Wanted: The Signet Ring of Prince Kael'thas"] = "Заказ: перстень-печатка принца Кель'таса"

--PvP
	----World PvP
	--HellFire
	BC["Hellfire Fortifications"] = "Штурмовые укрепления"
	--Auchindoun
	BC["Spirits of Auchindoun"] = "Духи Аукиндона"
	--Nagrand / Halla
	BC["Enemies, Old and New"] = "Враги старые и враги новые" --Horde
	BC["In Defense of Halaa"] = "Защита Халаа" --Alliance
	----Battlegrounds
	BC["Call to Arms: Eye of the Storm"] = "К оружию! Око Бури"
end

--
--	WOTLK
--
local LK = LibStub("AceLocale-3.0"):NewLocale("SOCD_LK", "ruRU")

if LK then
	--Instance Dailies
	LK["All Things in Good Time"] = "Все хорошо в свое время"
		--Heroics
	LK["Proof of Demise: Anub'arak"] = "Доказательство смерти: Ануб'арак"
	LK["Proof of Demise: Cyanigosa"] = "Доказательство смерти: Синигоса"
	LK["Proof of Demise: Gal'darah"] = "Доказательство смерти: Гал'дара"
	LK["Proof of Demise: Herald Volazj"] = "Доказательство смерти: глашатай Волаж"
	LK["Proof of Demise: Ingvar the Plunderer"] = "Доказательство смерти: Ингвар Расхититель"
	LK["Proof of Demise: Keristrasza"] = "Доказательство смерти: Керистраза"
	LK["Proof of Demise: King Ymiron"] = "Доказательство смерти: король Имирон"
	LK["Proof of Demise: Ley-Guardian Eregos"] = "Доказательство смерти: хранитель энергии Эрегос"
	LK["Proof of Demise: Loken"] = "Доказательство смерти: Локен"
	LK["Proof of Demise: Mal'Ganis"] = "Доказательство смерти: Мал'Ганис"
	LK["Proof of Demise: Sjonnir The Ironshaper"] = "Доказательство смерти: Сьоннир Литейщик"
	LK["Proof of Demise: The Prophet Tharon'ja"] = "Доказательство смерти: пророк Тарон'джа"
		--Non Heroics
	LK["Timear Foresees Centrifuge Constructs in your Future!"] = "Времиар предчувствует вашу встречу с центрифужными созданиями!"
	LK["Timear Foresees Infinite Agents in your Future!"] = "Времиар предвидит, что в будущем вы столкнетесь с посланницами из рода Бесконечности!"
	LK["Timear Foresees Titanium Vanguards in your Future!"] = "Времиар предвидит вашу встречу с титановыми воинами!"
	LK["Timear Foresees Ymirjar Berserkers in your Future!"] = "Времиар предвидит ваше столкновение с имиржарскими берсерками!"

	--Professions
		--Cooking
	LK["Cheese for Glowergold"] = "Сыр для Златоплава"
	LK["Convention at the Legerdemain"] = "Сбор в Приюте фокусника"
	LK["Infused Mushroom Meatloaf"] = "Мясной рулет в странногрибном соусе"
	LK["Mustard Dogs!"] = "Сосиски с горчицей!"
	LK["Sewer Stew"] = "Рагу для завсегдатаев Стоков"
		--Jewlcrafting
	LK["Shipment: Blood Jade Amulet"] = "Заказ от торговой компании: амулет из кровавого нефрита"
	LK["Shipment: Bright Armor Relic"] = "Заказ от торговой компании: Реликвия из сияющей брони"
	LK["Shipment: Glowing Ivory Figurine"] = "Заказ от торговой компании: блестящая статуэтка из бивня"
	LK["Shipment: Intricate Bone Figurine"] = "Заказ от торговой компании: изысканная костяная статуэтка"
	LK["Shipment: Shifting Sun Curio"] = "Заказ от торговой компании: реликвия Восходящего Солнца"
	LK["Shipment: Wicked Sun Brooch "] = "Заказ от торговой компании: брошь Беспощадного солнца "

	--Factions
		--The Wyrmrest Accord
	LK["Aces High!"] = "Проверка боем"
	LK["Drake Hunt"] = "Охота на драконов"
	LK["Defending Wyrmrest Temple"] = "Защита храма Драконьего Покоя"

		--The Oracles
	LK["A Cleansing Song"] = "Песнь Очищения"
	LK["Appeasing the Great Rain Stone"] = "Умиротворение Великого камня дождя"
	LK["Hand of the Oracles"] = "Длань Оракулов"
	LK["Mastery of the Crystals"] = "Власть над кристаллами"
	LK["Power of the Great Ones"] = "Могущество Великих"
	LK["Song of Fecundity"] = "Песнь Плодородия"
	LK["Song of Reflection"] = "Песнь Размышления"
	LK["Song of Wind and Water"] = "Песнь Ветра и Воды"
	LK["Will of the Titans"] = "Воля Титанов"

		--Frenzyheart Tribe
	LK["A Hero's Headgear"] = "Геройский шлем"
	LK["Chicken Party!"] = "И снова цыплята!"
	LK["Frenzyheart Champion"] = "Защитник племени Бешеного Сердца"
	LK["Kartak's Rampage"] = "Буйство Картака"
	LK["Rejek: First Blood"] = "Реджек: первая кровь"
	LK["Secret Strength of the Frenzyheart"] = "Тайная сила племени Бешеного Сердца"
	LK["Strength of the Tempest"] = "Сила Бури"
	LK["The Heartblood's Strength"] = "Сила озаренной крови"
	LK["Tools of War"] = "Орудия войны"

		--The Sons of Hodir
	LK["Blowing Hodir's Horn"] = "Звуки рога Ходира"
	LK["Hodir's Horn"] = "Рог Ходира" --object Name

	LK["Feeding Arngrim"] = "Муки Арнгрима"
	LK["Arngrim the Insatiable"] = "Арнгрим Ненасытный" --object Name

	LK["Hot and Cold"] = "Жар и холод"
	LK["Fjorn's Anvil"] = "Наковальня Фьорна" --object name


	LK["Polishing the Helm"] = "Полировка шлема"
	LK["Hodir's Helm"] = "Шлем Ходира" --object Name

	LK["Spy Hunter"] = "Контрразведчик"

	LK["Thrusting Hodir's Spear"] = "Бросая копье Ходира"
	LK["Hodir's Spear"] = "Копье Ходира" --object Name

		--Argent Crusade
	LK["The Alchemist's Apprentice"] = "В подмастерья к алхимику"
	LK["Troll Patrol"] = "Тролльский дозор"
	LK["Troll Patrol: Can You Dig It?"] = "Тролльский патруль: будем копать"
	LK["Troll Patrol: Couldn't Care Less"] = "Тролльский дозор: зачистка местности"
	LK["Troll Patrol: Creature Comforts"] = "Тролльский дозор: животворящее тепло"
	LK["Troll Patrol: Done to Death"] = "Тролльский дозор: смертельная усталость"
	LK["Troll Patrol: High Standards"] = "Тролльский дозор: выше знамена!"
	LK["Troll Patrol: Intestinal Fortitude"] = "Тролльский дозор: сила духа"
	LK["Troll Patrol: Something for the Pain"] = "Тролльский дозор: обезболивающее снадобье"
	LK["Troll Patrol: The Alchemist's Apprentice"] = "Тролльский дозор: в подмастерья к алхимику"
	LK["Troll Patrol: Throwing Down"] = "Тролльский дозор: подрывные работы"
	LK["Troll Patrol: Whatdya Want, a Medal?"] = "Тролльский дозор: сбор медальонов"
	LK["Congratulations!"] = "Поздравляем!"

		--Knights of the Ebon Blade
	LK["Intelligence Gathering"] = "Сбор информации"
	LK["Leave Our Mark"] = "Наша метка"
	LK["No Fly Zone"] = "Закрытое воздушное пространство"
	LK["From Their Corpses, Rise!"] = "Из праха восстаньте!"
	LK["Shoot 'Em Up"] = "Пристрели их"
	LK["Vile Like Fire!"] = "Злоб любит огонь!"

		--The Kalu'ak
	LK["Planning for the Future"] = "Планы на будущее"
	LK["Preparing for the Worst"] = "Подготовка к самому худшему"
	LK["The Way to His Heart..."] = "Путь к ее сердцу..."

		--The Frostborn
	LK["Pushed Too Far"] = "Все слишком далеко зашло"

	----Horde Expedition / --Alliance Vanguard
		--These are shared quests for the given zone
		--IceCrown
	LK["King of the Mountain"] = "Царь горы" --Netural
	LK["Blood of the Chosen"] = "Кровь избранных" --Netural
	LK["Drag and Drop"] = "Перенос" --Netural
	LK["Neutralizing the Plague"] = "Нейтрализация чумы" --Netural
	LK["No Rest For The Wicked"] = "Пусть злодеи не ведают покоя" --Netural
	LK["Not a Bug"] = "Тайный шпион" --Netural
	LK["Retest Now"] = "Все переиграть" --Netural
	LK["Slaves to Saronite"] = "Рабы саронитовых шахт" --Netural
	LK["That's Abominable!"] = "Как все погано!" --Netural
	LK["Static Shock Troops: the Bombardment"] = "Войска статического разряда: Бомбардировка" --Alliance
	LK["Total Ohmage: The Valley of Lost Hope!"] = "Война продолжается" --Horde
	LK["The Solution Solution"] = "Решение проблемы" --Alliance
	LK["Volatility"] = "Зря старались!" --Horde
	LK["Capture More Dispatches"] = "Перехват донесений" --Alliance
	LK["Keeping the Alliance Blind"] = "Ослепление Альянса" --Horde
	LK["Putting the Hertz: The Valley of Lost Hope"] = "Килотонны смерти" --Alliance
	LK["Riding the Wavelength: The Bombardment"] = "Новое излучение. Бомбардировка" --Horde

		--Grizzly Hills
	LK["Life or Death"] = "На грани жизни и смерти" --Alliance
	LK["Overwhelmed!"] = "В военном лазарете" --Horde
	LK["Making Repairs"] = "Текущий ремонт" --Horde
	LK["Pieces Parts"] = "Запчасти" --Alliance
	LK["Keep Them at Bay"] = "Припрем их к стенке" --Netural
	LK["Riding the Red Rocket"] = "Верхом на красной ракете" --Netural
	LK["Seared Scourge"] = "Пылающая Плеть" --Netural
	LK["Smoke 'Em Out"] = "Выкурим их!" --Netural

		--The Storm Peaks
	LK["Back to the Pit"] = "Обратно в Яму Клыка"
	LK["Defending Your Title"] = "Подтверждение победы"
	LK["Overstock"] = "Излишки"
	LK["Maintaining Discipline"] = "Поучить уму-разуму"
	LK["The Aberrations Must Die"] = "Смерть гнусным тварям!"


		--World PvP
		--These Quests Specificlally flag you as PvP Active
		--Wintergrasp Fortress
	LK["A Rare Herb"] = "Редкое растение"
	LK["Bones and Arrows"] = "Кости и стрелы"
	LK["Defend the Siege"] = "Защита осадных машин"
	LK["Fueling the Demolishers"] = "Горючее для разрушителей"
	LK["Healing with Roses"] = "Целительные розы"
	LK["Jinxing the Walls"] = "Заколдованные стены"
	LK["No Mercy for the Merciless"] = "Беспощадным пощады не будет"
	LK["Slay them all"] = "Убить всех и каждого!"
	LK["Stop the Siege"] = "Остановка осады"
	LK["Victory in Wintergrasp"] = "Победа на Озере Ледяных Оков"
	LK["Warding the Walls"] = "Охрана стен"
	LK["Warding the Warriors"] = "Охрана для воинов"

		--BattleGround
	LK["Call to Arms: Strand of the Ancients"] = "Призыв к оружию: Берег Древних"

		--IceCrown
	LK["Make Them Pay!"] = "Они заплатят!" --Horde
	LK["Shred the Alliance"] = "Искрошить Альянс" --Horde
	LK["No Mercy!"] = "Пощады не будет!" --Allaince
	LK["Shredder Repair"] = "Починка крошшеров" --Alliance

		--Grizzly Hills
	LK["Keep Them at Bay"] = "Припрем их к стенке" --Netural
	LK["Riding the Red Rocket"] = "Верхом на красной ракете" --Netural
	LK["Seared Scourge"] = "Пылающая Плеть" --Netural
	LK["Smoke 'Em Out"] = "Выкурим их!" --Netural

	LK["Down With Captain Zorna!"] = "Смерть капитану Зорне!" --Alliance
	LK["Kick 'Em While They're Down"] = "Нападем, пока враг слаб!" --Alliance
	LK["Blackriver Skirmish"] = "Резня в Черноречье" --Alliance

	LK["Crush Captain Brightwater!"] = "Смерть капитану Брайтвотеру!" --Horde
	LK["Keep 'Em on Their Heels"] = "Преследуй по пятам" --Horde
	LK["Blackriver Brawl"] = "Схватка в Черноречье" --Horde


	--Misc
		--Howling Fjord
	LK["Break the Blockade"] = "Прорвать блокаду" --Alliance
	LK["Steel Gate Patrol"] = "Патрулирование Стальных Ворот" --Alliance

end
