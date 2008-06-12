--Major 5, Minor $Revision$
--[[

How to Localize this, because it's a pain in the ass.

/dump UnitName("target")
/dump GetTitleText()

The Lines marked NPC must have the EXACT spelling and coding as the above command for UnitName()
Same applys for the *Quest marked lines, must have the EXACT spelling and coding as given by "GetTitleText()"
if they are not the same then it will not work.

all other lines are bissness as usual, being touched every few weeks.

--Origional Contribution by   <cat.yhan@gmail.com>

]]--


local L = LibStub("AceLocale-3.0"):NewLocale("SickOfClickingDailies", "zhCN")

if L then
--Skettis
	L["Sky Sergeant Doryn"] = "空军上尉杜尔因" --*NPC
		L["Fires Over Skettis"] = "轰炸斯克提斯" --*Quest
		L["Escape from Skettis"] = "逃离斯克提斯" --*Quest

	L["Skyguard Prisoner"] = "天空卫队囚犯" --*NPC

	L["Skyguard Khatie"] = "天空卫队卡提" --*NPC
		L["Wrangle More Aether Rays!"] = "捕捉更多以太鳐！" --*Quest 

	L["Sky Sergeant Vanderlip"] = "空军上尉范德里普" --*NPC 
		L["Bomb Them Again!"] = "继续轰炸！" --*Quest

--Ogri'la
	L["Chu'a'lor"] = "库洛尔" --*NPC
		L["The Relic's Emanation"] = "埃匹希斯的顿悟" --*Quest

	L["Kronk"] = "科隆克"  --*NPC
		L["Banish More Demons"] = "放逐更多恶魔" --*Quest

--Netherwing
	L["Mistress of the Mines"] = "矿洞女王" --*NPC 
		L["Picking Up The Pieces..."] = "回收货物" --*Quest 

	L["Dragonmaw Foreman"] = "龙喉工头" --*NPC
		L["Dragons are the Least of Our Problems"] = "龙？不是问题" --*Quest

	L["Yarzill the Merc"] = "雇佣兵亚兹尔" 	--*NPC
		L["The Not-So-Friendly Skies..."] = "危险的天空" --*Quest	
		L["A Slow Death"] = "缓慢的死亡" --*Quest

	L["Taskmaster Varkule Dragonbreath"] = "工头瓦尔库勒·龙息" --*NPC
		L["Nethercite Ore"] = "虚空矿石" --*Quest
		L["Netherdust Pollen"] = "灵尘花粉" --*Quest
		L["Nethermine Flayer Hide"] = "虚空矿洞剥石者的外皮" --*Quest 
		L["Netherwing Crystals"] = "灵翼水晶" --*Quest

	L["Chief Overseer Mudlump"] = "高级监工玛德拉普" --*NPC 
		L["The Booterang: A Cure For The Common Worthless Peon"] = "训诫靴：懒惰苦工的惩戒" --*Quest

	L["Commander Arcus"] = "指挥官阿库斯"  --*NPC
	L["Commander Hobb"] = "指挥官霍布"  --*NPC
	L["Overlord Mor'ghor"] = "莫格霍尔大王" --*NPC
		L["Disrupting the Twilight Portal"] = "暮光岭的传送门"	--*Quest 	
		L["The Deadliest Trap Ever Laid"] = "最致命的陷阱"	--*Quest 	

--Shattered Sun Offensive
	L["Vindicator Xayann"] = "守备官夏安" 	--*NPC
		L["Erratic Behavior"] = "游荡的奥术守卫" --Quest
		L["Further Conversions"] = "转化更多奥术守卫" --Quest
	L["Captain Theris Dawnhearth"] = "瑟里斯·黎明之心"
		L["The Sanctum Wards"] = "圣殿的结界"
		L["Arm the Wards!"] = "激活结界！"
	L["Harbinger Haronem"] = "先驱者哈隆奈姆"
		L["The Multiphase Survey"] = "多相数据调查"
	L["Lord Torvos"] = "托沃斯男爵"  
		L["Sunfury Attack Plans"] = "日怒攻击计划"
	L["Emissary Mordin"] = "摩尔丁特使"
		L["Gaining the Advantage"] = "占据上风"
	L["Harbinger Inuuro"] = "先驱者伊努罗"
		L["The Battle for the Sun's Reach Armory"] = "军械库之战"
		L["The Battle Must Go On"] = "继续作战"
	L["Battlemage Arynna"] = "战斗法师艾尔娜"
		L["Distraction at the Dead Scar"] = "轰炸死亡之痕"
		L["The Air Strikes Must Continue"] = "继续空袭"
	L["Magistrix Seyla"] = "魔导师瑟伊拉"
		L["Blast the Gateway"] = "轰炸传送门"
		L["Blood for Blood"] = "血债血偿"
	L["Exarch Nasuun"] = "主教纳苏恩"
		L["Intercepting the Mana Cells"] = "截获法力晶格"
		L["Maintaining the Sunwell Portal"] = "维持传送门"
	L["Astromancer Darnarian"] = "星术师达纳里安"
		L["Know Your Ley Lines"] = "魔网能量线的读数"
	L["Vindicator Kaalan"] = "守备官凯兰"
		L["Intercept the Reinforcements"] = "拦截援军"
		L["Keeping the Enemy at Bay"] = "拒敌港外"
	L["Magister Ilastar"] = "魔导师伊拉斯塔"
		L["Taking the Harbor"] = "占领港口"
		L["Crush the Dawnblade"] = "击溃晨锋部队"
	L["Smith Hauthaa"] = "铁匠霍尔萨"
		L["Making Ready"] = "做好准备"
		L["Don't Stop Now...."] = "不要停下……"
		L["Ata'mal Armaments"] = "阿塔玛军备"
	L["Anchorite Ayuri"] = "学者艾尤莉"
		L["A Charitable Donation"] = "仁慈的募捐"
		L["Your Continued Support"] = "鼎力支持"
	L["Captain Valindria"] = "瓦琳德拉上尉"
		L["Disrupt the Greengill Coast"] = "解救绿鳃奴隶"
	L["Mar'nah"] = "玛尔娜"
		L["Discovering Your Roots"] = "寻根知底"
		L["Rediscovering Your Roots"] = "继续寻根"
		L["Open for Business"] = "开始营业"

--Wintersaber Rep
L["Rivern Frostwind"] = "雷沃·霜翼" --*NPC
	L["Frostsaber Provisions"] = "霜刃豹的食物" --*Quest
	L["Winterfall Intrusion"] = "冬泉熊怪的侵扰" --*Quest
	L["Rampaging Giants"] = "狂暴的巨人" --*Quest

--Cooking
L["The Rokk"] = "巨石洛克"  --*NPC
	L["Super Hot Stew"] = "超级美味烧烤" --*Quest
	L["Soup for the Soul"] = "灵魂之汤" --*Quest
	L["Revenge is Tasty"] = "甜美的复仇" --*Quest
	L["Manalicious"] = "魔法美味" --*Quest

--Fishing
L["Old Man Barlo"] = "老渔夫巴尔洛"  --*NPC
	L["Crocolisks in the City"] = "城中的鳄鱼"  --*Quest
	L["Bait Bandits"] = "黑鳞镖鲈"  --*Quest
	L["Felblood Fillet"] = "魔血鲷鱼" --*Quest
	L["Shrimpin' Ain't Easy"] = "巨型淡水虾" --*Quest
	L["The One That Got Away"] = "世界上最大的泥鱼" --*Quest

--Non-Heroic Instances
L["Nether-Stalker Mah'duun"] = "虚空猎手玛哈杜恩" 	--*NPC 
	L["Wanted: Arcatraz Sentinels"] = "悬赏：禁魔监狱斥候" --*Quest
	L["Wanted: Coilfang Myrmidons"] = "悬赏：盘牙侍从" --*Quest
	L["Wanted: Malicious Instructors"] = "悬赏：恶毒导师" --*Quest
	L["Wanted: Rift Lords"] = "悬赏：裂隙领主" --*Quest
	L["Wanted: Shattered Hand Centurions"] = "悬赏：碎手百夫长" --*Quest
	L["Wanted: Sunseeker Channelers"] = "悬赏：寻日者导魔者" --*Quest
	L["Wanted: Tempest-Forge Destroyers"] = "悬赏：风暴锻铸摧毁者" --*Quest
	L["Wanted: Sisters of Torment"] = "悬赏：痛苦妖女" --*Quest

--Names...		These lines are used for display in the gui to shorten the idea of what the quest is.
	L["Arcatraz Sentinels"] = "禁魔监狱斥候"
	L["Coilfang Myrmidons"] = "盘牙侍从"
	L["Malicious Instructors"] = "恶毒导师"
	L["Rift Lords"] = "裂隙领主"
	L["Shattered Hand Centurions"] = "碎手百夫长"
	L["Sunseeker Channelers"] = "寻日者导魔者"
	L["Tempest-Forge Destroyers"] = "风暴锻铸摧毁着"
	L["Sisters of Torment"] = "痛苦妖女"

--Heroic Instances
L["Wind Trader Zhareem"] = "商人扎雷姆"  --*NPC
	L["Wanted: A Black Stalker Egg"] = "悬赏：黑色阔步者的卵" --*Quest
	L["Wanted: A Warp Splinter Clipping"] = "悬赏：扭木碎片" --*Quest
	L["Wanted: Aeonus's Hourglass"] = "悬赏：埃欧努斯的沙漏" --*Quest
	L["Wanted: Bladefist's Seal"] = "悬赏：刃拳的印记" --*Quest
	L["Wanted: Keli'dan's Feathered Stave"] = "悬赏：克里丹的羽饰法杖" --*Quest
	L["Wanted: Murmur's Whisper"] = "悬赏：摩摩尔的低语" --*Quest
	L["Wanted: Nazan's Riding Crop"] = "悬赏：纳杉的骑鞭" --*Quest
	L["Wanted: Pathaleon's Projector"] = "悬赏：帕萨雷恩的投影仪" --*Quest
	L["Wanted: Shaffar's Wondrous Pendant"] = "悬赏：沙法尔的精致饰物" --*Quest
	L["Wanted: The Epoch Hunter's Head"] = "悬赏：时空猎手的头颅" --*Quest
	L["Wanted: The Exarch's Soul Gem"] = "悬赏：主教的灵魂宝钻" --*Quest
	L["Wanted: The Headfeathers of Ikiss"] = "悬赏：艾吉斯的冠羽" --*Quest
	L["Wanted: The Heart of Quagmirran"] = "悬赏：夸格米拉之心" --*Quest
	L["Wanted: The Scroll of Skyriss"] = "悬赏：斯克瑞斯的卷轴" --*Quest
	L["Wanted: The Warlord's Treatise"] = "悬赏：督军的论文" --*Quest
	L["Wanted: The Signet Ring of Prince Kael'thas"] = "悬赏：凯尔萨斯王子的徽记之戒" --*Quest

--Names...		These lines are used for display in the gui to shorten the idea of what the quest is. 
	L["A Black Stalker Egg"] = "黑色阔步者的卵"
	L["A Warp Splinter Clipping"] = "扭木碎片"
	L["Aeonus's Hourglass"] = "埃欧努斯的沙漏"
	L["Bladefist's Seal"] = "刃拳的印记"
	L["Keli'dan's Feathered Stave"] = "克里丹的羽饰法杖"
	L["Murmur's Whisper"] = "摩摩尔的低语"
	L["Nazan's Riding Crop"] = "纳杉的骑鞭"
	L["Pathaleon's Projector"] = "帕萨雷恩的投影仪"
	L["Shaffar's Wondrous Pendant"] = "沙法尔的精致饰物"
	L["The Epoch Hunter's Head"] = "时空猎手的头颅"
	L["The Exarch's Soul Gem"] = "主教的灵魂宝钻"
	L["The Headfeathers of Ikiss"] = "艾吉斯的冠羽"
	L["The Heart of Quagmirran"] = "夸格米拉之心"
	L["The Scroll of Skyriss"] = "斯克瑞斯的卷轴"
	L["The Warlord's Treatise"] = "督军的论文"
	L["Ring of Prince Kael'thas"] = "凯尔萨斯王子的徽记之戒"

--PvP
L["Alliance Brigadier General"] = "联盟准将" --*NPC
L["Horde Warbringer"] = "部落战争使者"  --*NPC
	L["Call to Arms: Alterac Valley"] = "战斗的召唤：奥特兰克山谷" --Quest
	L["Call to Arms: Arathi Basin"] = "战斗的召唤：阿拉希盆地" --Quest
	L["Call to Arms: Eye of the Storm"] = "战斗的召唤：风暴之眼" --Quest
	L["Call to Arms: Warsong Gulch"] = "战斗的召唤：战歌峡谷" --Quest
L["Warrant Officer Tracy Proudwell"] = "委任官翠希·普罗维尔" --*NPC 	
L["Battlecryer Blackeye"] = "传令官布莱肯·黑眼" --*NPC
	L["Hellfire Fortifications"] = "地狱火半岛的工事" --Quest
L["Exorcist Sullivan"] = "驱魔师苏利文"  --*NPC
L["Exorcist Vaisha"] = "驱魔师瓦沙" 	 --*NPC	
	L["Spirits of Auchindoun"] = "奥金顿的幽魂" --Quest
L["Karrtog"] = "卡尔托格"  	--*NPC
	L["Enemies, Old and New"] = "新仇旧怨" --Quest
L["Lakoor"] = "拉库尔"  	--*NPC
	L["In Defense of Halaa"] = "保卫哈兰" 	--Quest

-- Options Table Locale
--General Titles
L["Sick Of Clicking Dailies?"] = "SOCD"  ---- Addon Name used for Options table
L["NPC & Quest Options"] = "NPC&任务选项"
L["NPC Enabled"] = "启用NPC"
L["Addon Options"] = "插件选项"
L["Enabled"] = "启用"
L["Enable Quest"] = "启用任务"
L["Quest Reward"] = "任务奖励"
L["None"] = "无"

L["Always Loop NPCs"] = "接受全部任务"
L["Always Loop on the NPC from one quest to the next forever"] = "依次接受NPC处可以获取的所有任务（当一个NPC处有多个任务可以获取时有效）"
L["Enable Gossip window"] = "启用闲谈窗口"
L["Enable skipping the opening gossip text"] = "忽略闲谈内容"
L["Enable Quest Text window"] = "启用任务文本窗口"
L["Enable skipping the Quest Descriptive text"] = "忽略任务详细内容"
L["Enable Completion Gossip"] = "启用完成任务"
L["Enable skipping the Quest Completion question text"] = "忽略完成任务后的文本内容"
L["Enable Quest Turn In"] = "启用任务获取"
L["Enable skipping the actual turn in of the quest"] = "忽略已经获得的任务"

--Titles
L["Faction Grinds"] = "声望任务"
	L["Skyguard"] = "天空卫队"
		L["Blades Edge Mountains"] = "刀锋山"
		L["Skettis"] = "斯克提斯"
	L["Ogri'la"] = "奥格瑞拉"
	L["Netherwing"] = "灵翼之龙"
		L["Netherwing - Neutral"] = "灵翼之龙 - 中立"
		L["Netherwing - Friendly"] = "灵翼之龙 - 友善"
		L["Netherwing - Honored"] = "灵翼之龙 - 尊敬"
		L["Netherwing - Revered"] = "灵翼之龙 - 崇敬"
	L["Shattered Sun Offensive"] = "破碎残阳"
		L["Phase 1"] = "第一阶段"
			 L["Recovering the Sun's Reach Sanctum"] = "收复阳湾圣殿"
		 L["Phase 2"] = "第二阶段"
			 L["Recovering the Sun's Reach Armory"] = "收复阳湾军械库"
		 L["Phase 2B"] = "第二阶段"
			 L["Open the Sunwell Portal"] = "开启太阳之井传送门"
		 L["Phase 3"] = "第三阶段"
			 L["Recovering the Sun's Reach Harbor"] = "收复阳湾港口"
		 L["Phase 3B"] = "第三阶段"
			 L["Building the Anvil"] = "建造铁砧"
		 L["Phase 4"] = "第四阶段"
			 L["The Final Push"] = "后期建设"
		 L["Phase 4B"] = "第四阶段"
			 L["Memorial for the Fallen"] = "殉难者纪念碑"
		 L["Associated Daily Quests"] = "关联每日任务"
	L["SSO_TEXT"] = "查看 >> http://www.wowwiki.com/SSO << 以获取最新的日常任务列表"
	L["Wintersaber Trainer"] = "冬刃豹训练师"
	
L["PvP"] = "PvP"
	L["Horde PvP"] = "部落PvP"
	L["Alliance PvP"] = "联盟PvP"
	L["Battlegrounds"] = "战场"
	L["World PvP"] = "世界PvP"
	
L["Instance"] = "副本"
	L["Instance - Normal"] = "副本 - 普通"
	L["Instance - Heroic"] = "副本 - 英雄"
		L["The Eye"] = "风暴要塞"
		L["Serpentshrine Cavern"] = "毒蛇神殿"
		L["Hellfire Citadel"] = "地狱火堡垒"
		L["Caverns of Time"] = "时光之穴"
		L["Auchindoun"] = "奥金顿"
		L["Magister's Terrace"] = "魔导师平台"
		
L["Cooking"] = "烹饪"
L["Fishing"] = "钓鱼"
L["Profession"] = "商业"

--Special Tool Tips
L["This will toggle the quest on both Doryn and the Prisoner"] = "可以同时在空军上尉杜尔因和天空卫队囚犯处获得任务"
L["|cffFF0000WARNING!!!|r, This Option also toggles both Scryer and Aldor Quests"] = "|cffFF0000注意！|r，这个选项同时对占星和奥尔多的任务有效"  ---Warning Color Code included in this string
L["\nAll Non-Heroic Quests are from |cff00ff00'Nether-Stalker Mah'duun'|r in LowerCity"] = "\n从贫民窟的|cff00ff00'虚空猎手玛哈杜恩'|r处获得所有普通任务"
L["\nAll Heroic Dailies from |cff00ff00'Wind Trader Zhareem'|r in LowerCity"] = "\n从贫民窟的|cff00ff00'商人扎雷姆'|r处获得所有英雄任务"
L["Accepting All Eggs is not included because it's not a Daily Quest"] = "没有包括“所有的龙卵”任务，它不是日常任务"

--Quest Options

L["Select what Potion you want for the 'Escape from Skettis' quest"] = "选择任务“逃离斯克提斯”的奖励药水 --此任务已无药水奖励，该功能失效了"
L["Health Potion"] = "生命药水"
L["Mana Potion"] = "法力药水"
L["Barrel of Fish"] = "一桶鱼"
L["Crate of Meat"] = "一箱肉"
L["Mark of Sargeras"] = "萨格拉斯印记"
L["Sunfury Signet"] = "日怒徽记"
L["Blessed Weapon Coating"] = "神圣武器涂层"
L["Righteous Weapon Coating"] = "正义武器涂层"
end