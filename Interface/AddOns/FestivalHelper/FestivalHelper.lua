
local Festival = {
	["春节"] = TheSpringFestival_NpcData,
	["情人节"] = 1,
}

local _Default = {
	["showFestivalMarks"] = true,
}

local read_date_fail = 0;
local function FestivalHelperFrame_ReadDate()
	local weekday, month, day, year = CalendarGetDate();
	if not month or not day or not year then		-- 很小的几率会读取不到。。。。。
		if read_date_fail == 3 then
			print("节日助手加载失败。。。。请尝试重载界面")			--加载失败的提示
			return;
		end
		read_date_fail = read_date_fail + 1;
		BigFoot_DelayCall(FestivalHelperFrame_ReadDate,0.5)
		return;
	end
	CalendarSetAbsMonth(month, year);
	local numEvents = CalendarGetNumDayEvents(0, day)		-- arg1:0表示当前月；-1：前一个月；1：下一个月
	if ( numEvents <= 0 ) then
		return;
	end
	for i = 1, numEvents do
		local title, hour, minute, calendarType, sequenceType, eventType, texture,modStatus, inviteStatus, invitedBy, difficulty, inviteType,sequenceIndex, numSequenceDays, difficultyName = CalendarGetDayEvent(0, day, i);		--节日名称，时间标记小时，分，节日类别，节日状态，eventType，图层，modStatus, inviteStatus, invitedBy, difficulty, inviteType,持续的第几天，一共持续多少天，difficultyName
		if calendarType == "HOLIDAY" then
			------------- 按节日添加功能相关模块 -------------
			if Festival_Data and Festival_Data[title] then		--地图数据相关开关
				FH_ReadFestivalData(Festival_Data[title])
			end
			BF_OpenAllCurrentFestival()       ----打开任务追踪面板显示成就按纽模块
			if title == ValentineName then 		-- 鼠标提示及目标点击宏
				FestivalHelper_Valentine_OpenMod(true);
			end
		end
	end
end

function FestivalHelperFrame_OnLoad()
	FestivalHelper_Config = FestivalHelper_Config or _Default
	FestivalHelperFrame_ReadDate()
end

function FestivalHelper_OnEvent(self, event, ...)
	local addon = ...;
	if event == "ADDON_LOADED" and addon == "FestivalHelper" then
		FestivalHelperFrame_OnLoad();
		self:UnregisterEvent("ADDON_LOADED");
	end
end

local function GetValentineDate()
    ---------------------情人节 ID187 爱情花族 4
	-- local id, name, points, completed, month, day, year, description, flags, icon, rewardText = GetAchievementInfo(187, 4);
	local id =1699
	local number = GetAchievementNumCriteria(id);
	local criteriaString, criteriaType, completed, quantity, reqQuantity, charName, flags, assetID, quantityString;
	local StrDataTab={};
	local zongzu,zhiye;
	for i =1,number do
		criteriaString, criteriaType, completed, quantity, reqQuantity, charName, flags, assetID, quantityString = GetAchievementCriteriaInfo(id, i);
		if not completed then
			table.insert(StrDataTab,criteriaString);
		end
	end
	return StrDataTab
end

local function GetUnitStr(unit)
	if not unit then unit = 'player' end
	local Srt1 =UnitRace(unit);
	local Srt2 = UnitClass(unit);
	local Str ="";
	if Srt1 and Srt2 then
		Str =Srt1..Srt2;
	end
	return Str;
end

function FestivalHelper_CheckUnit(__unit)
	local m_Str = GetUnitStr(__unit);
	local m_tab = GetValentineDate();
	local bfind =false;
	for k,v in pairs(m_tab)do
		if m_Str == v then
			bfind =true;
		end
	end
	return bfind;
end

function FestivalHelper_Valentine_OpenMod(bopen)
	ValentineModOpen = bopen;
end
