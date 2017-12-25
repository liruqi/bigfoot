local L = LibStub("AceLocale-3.0"):NewLocale("WorldQuestTrackerAddon", "zhCN")
if not L then return end

L["A blue star indicates all party members have this quest as well (if they have world quest tracker installed)."] = "蓝星说明所有队员都有此任务（如果他们也使用了本插件）。"
L["Click on Summary to see statistics and a saved list of quests on other characters."] = "点击奖励统计可查看帐号下其他角色的统计数据。"
L["S_APOWER_AVAILABLE"] = "可用的"
L["S_APOWER_DOWNVALUE"] = "奖励神器能量的任务显示 %s 就说明它可以在新的笔记研究后再去完成。"
L["S_APOWER_NEXTLEVEL"] = "下一等级"
L["S_ENABLED"] = "已启用"
L["S_ERROR_NOTIMELEFT"] = "此任务已过期。"
L["S_ERROR_NOTLOADEDYET"] = "这个任务尚未加载，请稍候。"
L["S_FLYMAP_SHOWTRACKEDONLY"] = "仅被追踪"
L["S_FLYMAP_SHOWTRACKEDONLY_DESC"] = "仅显示正在被追踪的任务"
L["S_FLYMAP_SHOWWORLDQUESTS"] = "显示世界任务"
L["S_GROUPFINDER_ACTIONS_CANCEL_APPLICATIONS"] = "点击取消申请…"
L["S_GROUPFINDER_ACTIONS_CANCELING"] = "取消中..."
L["S_GROUPFINDER_ACTIONS_CREATE"] = "未找到？点击创建一个小队"
L["S_GROUPFINDER_ACTIONS_CREATE_DIRECT"] = "创建队伍"
L["S_GROUPFINDER_ACTIONS_LEAVEASK"] = "你确定要离开小队吗？"
L["S_GROUPFINDER_ACTIONS_LEAVINGIN"] = "离开小队（点击立即离开）"
L["S_GROUPFINDER_ACTIONS_RETRYSEARCH"] = "尝试重新寻找"
L["S_GROUPFINDER_ACTIONS_SEARCH"] = "点击寻找小队"
L["S_GROUPFINDER_ACTIONS_SEARCH_RARENPC"] = "寻找队伍击杀稀有"
L["S_GROUPFINDER_ACTIONS_SEARCH_TOOLTIP"] = "加入一个小队做此任务"
L["S_GROUPFINDER_ACTIONS_SEARCHING"] = "正在寻找..."
L["S_GROUPFINDER_ACTIONS_SEARCHMORE"] = "点击寻找更多队伍成员"
L["S_GROUPFINDER_ACTIONS_SEARCHOTHER"] = "离开并寻找其他的小队？"
L["S_GROUPFINDER_ACTIONS_UNAPPLY1"] = "点击拒绝申请，以便于我们可以创建新小队"
L["S_GROUPFINDER_ACTIONS_UNLIST"] = "点击后不列出你的队伍"
L["S_GROUPFINDER_ACTIONS_UNLISTING"] = "不列出…"
L["S_GROUPFINDER_ACTIONS_WAITING"] = "等待中…"
L["S_GROUPFINDER_AUTOOPEN_RARENPC_TARGETED"] = "目标为稀有怪物时自动打开"
L["S_GROUPFINDER_ENABLED"] = "新任务时自动启用"
L["S_GROUPFINDER_INVASION_ENABLED"] = "到入侵点时自动打开"
L["S_GROUPFINDER_LEAVEOPTIONS"] = "离开小队选项"
L["S_GROUPFINDER_LEAVEOPTIONS_AFTERX"] = "X 秒后离开"
L["S_GROUPFINDER_LEAVEOPTIONS_ASKX"] = "不自动离开，只提示 X 秒"
L["S_GROUPFINDER_LEAVEOPTIONS_DONTLEAVE"] = "不要显示离开面板"
L["S_GROUPFINDER_LEAVEOPTIONS_IMMEDIATELY"] = "任务完成时立即离开小队"
L["S_GROUPFINDER_NOPVP"] = "避开 PVP 服务器"
L["S_GROUPFINDER_OT_ENABLED"] = "任务追踪上显示按钮"
L["S_GROUPFINDER_QUEUEBUSY"] = "你已经在队列中。"
L["S_GROUPFINDER_QUEUEBUSY2"] = "不显示团队查找器窗口：已在队伍或查找时。"
L["S_GROUPFINDER_RESULTS_APPLYING"] = "有 %d 个剩余的队伍，请再点击一次"
L["S_GROUPFINDER_RESULTS_APPLYING1"] = "有1个剩余的队伍可加入，请再点击一次"
L["S_GROUPFINDER_RESULTS_FOUND"] = [=[找到 %d 个队伍
点击开始加入]=]
L["S_GROUPFINDER_RESULTS_FOUND1"] = [=[找到1个队伍
点击开始加入]=]
L["S_GROUPFINDER_RESULTS_UNAPPLY"] = "%d 个剩余申请…"
L["S_GROUPFINDER_RIGHTCLICKCLOSE"] = "右击关闭"
L["S_GROUPFINDER_SECONDS"] = "秒"
L["S_GROUPFINDER_TITLE"] = "队伍寻找"
L["S_GROUPFINDER_TUTORIAL1"] = "加入队伍完成相同任务能更快的完成世界任务！"
L["S_MAPBAR_AUTOWORLDMAP"] = "自动世界地图"
L["S_MAPBAR_AUTOWORLDMAP_DESC"] = [=[在达拉然或职业大厅中时，按“M”键直接显示破碎群岛地图。

连续两次按“M”键显示你所在的地图。]=]
L["S_MAPBAR_FILTER"] = "过滤"
L["S_MAPBAR_FILTERMENU_FACTIONOBJECTIVES"] = "阵营目标（使者任务）"
L["S_MAPBAR_FILTERMENU_FACTIONOBJECTIVES_DESC"] = "始终显示阵营目标任务即使他们已被过滤。"
L["S_MAPBAR_OPTIONS"] = "配置"
L["S_MAPBAR_OPTIONSMENU_ARROWSPEED"] = "箭头更新频率"
L["S_MAPBAR_OPTIONSMENU_ARROWSPEED_HIGH"] = "快"
L["S_MAPBAR_OPTIONSMENU_ARROWSPEED_MEDIUM"] = "中"
L["S_MAPBAR_OPTIONSMENU_ARROWSPEED_REALTIME"] = "实时"
L["S_MAPBAR_OPTIONSMENU_ARROWSPEED_SLOW"] = "慢"
L["S_MAPBAR_OPTIONSMENU_EQUIPMENTICONS"] = "装备图标"
L["S_MAPBAR_OPTIONSMENU_QUESTTRACKER"] = "启用任务追踪"
L["S_MAPBAR_OPTIONSMENU_REFRESH"] = "刷新"
L["S_MAPBAR_OPTIONSMENU_SHARE"] = "分享这个插件"
L["S_MAPBAR_OPTIONSMENU_SOUNDENABLED"] = "启用音效"
L["S_MAPBAR_OPTIONSMENU_STATUSBARANCHOR"] = "菜单置顶"
L["S_MAPBAR_OPTIONSMENU_TOMTOM_WPPERSISTENT"] = "路径点持续"
L["S_MAPBAR_OPTIONSMENU_TRACKER_CURRENTZONE"] = "只显示当前地图任务"
L["S_MAPBAR_OPTIONSMENU_TRACKER_SCALE"] = "追踪列表缩放: %s"
L["S_MAPBAR_OPTIONSMENU_TRACKERCONFIG"] = "追踪列表设置"
L["S_MAPBAR_OPTIONSMENU_TRACKERMOVABLE_AUTO"] = "默认位置"
L["S_MAPBAR_OPTIONSMENU_TRACKERMOVABLE_CUSTOM"] = "自定义位置"
L["S_MAPBAR_OPTIONSMENU_TRACKERMOVABLE_LOCKED"] = "位置锁定"
L["S_MAPBAR_OPTIONSMENU_UNTRACKQUESTS"] = "取消追踪所有任务"
L["S_MAPBAR_OPTIONSMENU_WORLDMAPCONFIG"] = "破碎群岛地图设置"
L["S_MAPBAR_OPTIONSMENU_YARDSDISTANCE"] = "显示距离码数"
L["S_MAPBAR_OPTIONSMENU_ZONE_QUESTSUMMARY"] = "显示任务概览（需全屏地图）"
L["S_MAPBAR_OPTIONSMENU_ZONEMAPCONFIG"] = "区域地图设置"
L["Small Text Size"] = "字号-小"
L["Medium Text Size"] = "字号-中"
L["Large Text Size"] = "字号-大"
L["Scale - Small"] = "图标-小"
L["Scale - Medium"] = "图标-中"
L["Scale - Big"] = "图标-大"
L["Scale - Very Big"] = "图标-超大"
L["Quest Summary"] = "当前地图任务"
L["Click to Add to Tracker"] = "点击追踪任务"
L["Small Quest Icons"] = "任务点标识-小"
L["Medium Quest Icons"] = "任务点标识-中"
L["Large Quest Icons"] = "任务点标识-大"
L["Very Large Quest Icons"] = "任务点标识-超大"
L["S_MAPBAR_RESOURCES_TOOLTIP_TRACKALL"] = "点击追踪所有：|cFFFFFFFF%s|r任务。"
L["S_MAPBAR_SORTORDER"] = "排序"
L["S_MAPBAR_SORTORDER_TIMELEFTPRIORITY_FADE"] = "大于指定时间半透明显示"
L["S_MAPBAR_SORTORDER_TIMELEFTPRIORITY_OPTION"] = "小于%d小时"
L["S_MAPBAR_SORTORDER_TIMELEFTPRIORITY_SHOWTEXT"] = "显示剩余时间"
L["S_MAPBAR_SORTORDER_TIMELEFTPRIORITY_SORTBYTIME"] = "以时间排序"
L["S_MAPBAR_SORTORDER_TIMELEFTPRIORITY_TITLE"] = "剩余时间"
L["S_MAPBAR_SUMMARY"] = "奖励统计"
L["S_MAPBAR_SUMMARYMENU_ACCOUNTWIDE"] = "账号内所有角色汇总"
L["S_MAPBAR_SUMMARYMENU_MOREINFO"] = "点击查看更多信息"
L["S_MAPBAR_SUMMARYMENU_NOATTENTION"] = [=[你其他角色正在追踪的任务，
剩余时限均大于2小时。]=]
L["S_MAPBAR_SUMMARYMENU_REQUIREATTENTION"] = "任务过期提示"
L["S_MAPBAR_SUMMARYMENU_TODAYREWARDS"] = "今日奖励"
L["S_OVERALL"] = "全部"
L["S_PARTY"] = "队伍"
L["S_PARTY_DESC1"] = "蓝星标识说明全部队友有此任务。"
L["S_PARTY_DESC2"] = "红星标识说明有队友没有此世界任务或未使用 WQT 。"
L["S_PARTY_PLAYERSWITH"] = "队伍中使用 WQT 的玩家："
L["S_PARTY_PLAYERSWITHOUT"] = "队伍中未使用 WQT 的玩家："
L["S_QUESTSCOMPLETED"] = "完成的任务数量"
L["S_QUESTTYPE_ARTIFACTPOWER"] = "神器能量"
L["S_QUESTTYPE_DUNGEON"] = "地下城"
L["S_QUESTTYPE_EQUIPMENT"] = "装备"
L["S_QUESTTYPE_GOLD"] = "金币"
L["S_QUESTTYPE_PETBATTLE"] = "宠物对战"
L["S_QUESTTYPE_PROFESSION"] = "专业"
L["S_QUESTTYPE_PVP"] = "PvP"
L["S_QUESTTYPE_RESOURCE"] = "职业大厅资源"
L["S_QUESTTYPE_TRADESKILL"] = "制造材料"
L["S_RAREFINDER_ADDFROMPREMADE"] = "在预创建队伍添加已找到稀有"
L["S_RAREFINDER_NPC_NOTREGISTERED"] = "稀有不在数据库中"
L["S_RAREFINDER_OPTIONS_ENGLISHSEARCH"] = "总是使用英语查找"
L["S_RAREFINDER_OPTIONS_SHOWICONS"] = "激活稀有显示图标"
L["S_RAREFINDER_SOUND_ALWAYSPLAY"] = "音效已禁用时仍播放"
L["S_RAREFINDER_SOUND_ENABLED"] = "迷你地图出现稀有时播放音效"
L["S_RAREFINDER_SOUNDWARNING"] = "迷你地图出现稀有时已播放音效，可以在选项菜单 > 稀有查找器子菜单禁用此音效。"
L["S_RAREFINDER_TITLE"] = "稀有查找器"
L["S_RAREFINDER_TOOLTIP_REMOVE"] = "移除"
L["S_RAREFINDER_TOOLTIP_SEACHREALM"] = "在其他服务器搜索"
L["S_RAREFINDER_TOOLTIP_SPOTTEDBY"] = "发现人"
L["S_RAREFINDER_TOOLTIP_TIMEAGO"] = "分钟"
L["S_SHAREPANEL_THANKS"] = [=[请发送链接给您的朋友。
感谢分享 World Quest Tracker！]=]
L["S_SHAREPANEL_TITLE"] = "让我们一起摇摆！"
L["S_SUMMARYPANEL_EXPIRED"] = "已过期"
L["S_SUMMARYPANEL_LAST15DAYS"] = "最近15天"
L["S_SUMMARYPANEL_LIFETIMESTATISTICS_ACCOUNT"] = "账号在线统计"
L["S_SUMMARYPANEL_LIFETIMESTATISTICS_CHARACTER"] = "角色在线统计"
L["S_SUMMARYPANEL_OTHERCHARACTERS"] = "其他角色"
L["S_TUTORIAL_AMOUNT"] = "显示奖励数值"
L["S_TUTORIAL_CLICKTOTRACK"] = "点击图标可添加至追踪列表"
L["S_TUTORIAL_CLOSE"] = "关闭教程"
L["S_TUTORIAL_FACTIONBOUNTY"] = "说明此任务属于选中的阵营。"
L["S_TUTORIAL_FACTIONBOUNTY_AMOUNTQUESTS"] = "显示在地图上有多少任务属于被选中的阵营。"
L["S_TUTORIAL_HOWTOADDTRACKER"] = "点击以追踪任务。在追踪任务时，可以|cFFFFFFFF右击|r来取消追踪。"
L["S_TUTORIAL_PARTY"] = "组队时，蓝星标识代表所有队伍成员都有此任务！"
L["S_TUTORIAL_RARITY"] = "显示任务品质（普通，稀有，史诗）"
L["S_TUTORIAL_REWARD"] = "显示任务奖励（装备，金币，神器能量，职业大厅资源，制造材料）"
L["S_TUTORIAL_TIMELEFT"] = "显示任务剩余时间（大于4小时，大于90分钟，大于30分钟，小于30分钟）"
L["S_TUTORIAL_WORLDMAPBUTTON"] = "点击回到破碎群岛地图。"
L["S_UNKNOWNQUEST"] = "未知任务"
L["S_WORLDMAP_TOOGLEQUESTS"] = "切换任务"
L["S_WORLDQUESTS"] = "世界任务"
L["Options are here, show all quests or only those being tracked"] = "在此切换显示所有任务或仅显示已追踪任务"
L["World Quest Tracker"] = "世界任务追踪"
