if GetLocale() == "zhCN" then
	L_VALENTINE = "情人节"
	L_SPRING = "春节"
	L_RELACHIEVEMENT ="大脚提示点击查看成就:"
elseif GetLocale() == "zhTW" then
	L_VALENTINE = "情人节"
	L_SPRING = "春節"
	L_RELACHIEVEMENT = "大腳提示點擊查看成就:"
end
t_ValentineQuestForAchi = {}
DayEvent_QuestForAchivment = {}
DayEvent_QuestForAchivment[L_VALENTINE] = QuestForAchiDB.Valentine
-----------------
FestivalModToggleList={}
FestivalModToggleList[L_VALENTINE] = function(toggle)   ---------情人节相关模块开关
		if toggle then
			BigFoot_DelayCall(function()
			Init_ValentineQuestAchi()			--------任务追踪面板成就按纽模块初始化
			end,0.3)
		end
	end
FestivalModToggleList[L_SPRING] =function (toggle)     --------------春节 相关模块开关
		if toggle then
		end
	end
function BF_OpenAllCurrentFestival()   ---打开当日所有节日对应模块
	local args1,month,day,year = CalendarGetDate()
	CalendarSetAbsMonth(month,2012)   
		for i=1,CalendarGetNumDayEvents(0,5) do  ------
			local title, hour, minute, calendarType, sequenceType, eventType, texture, modStatus, inviteStatus, invitedBy, difficulty, inviteType = CalendarGetDayEvent(0,5,i)
			if eventType == 0 and FestivalModToggleList[title] then
				FestivalModToggleList[title](true)
			end
		end
end
------------------------------情人节模块---------------
function Update_ValentineQuestAchi()        --------刷新情人节成就按纽
	local achiindex  = 0
	local questindex = 0
	for i =1 ,GetNumQuestWatches()+GetNumTrackedAchievements() do                 
		local questid
		if _G["WatchFrameLinkButton" .. i] then
			if _G["WatchFrameLinkButton" .. i].type == "QUEST" then                     -----将任务很成就分别进行索引
				questindex = questindex+1
			elseif _G["WatchFrameLinkButton" .. i].type == "ACHIEVEMENT" then
				achiindex = achiindex+1
			end
			-- print(questindex)
			if questindex~=0 then
				questid = GetQuestIdByQuestLink(GetQuestLink(GetQuestIndexForWatch(questindex)))
			end
			-- print(type(questid))
			local achiid = Valentine_GetAchiIDByQuestID(tonumber(questid))
			-- print (achiid)
			
			if not _G["WatchFrameLinkButton" .. i].achibutton then  
				_G["WatchFrameLinkButton" .. i].achibutton = CreateFrame("Button","QuestAchiButton" .. i,SpellAdminFrame,"ActionButtonTemplate")
				_G["WatchFrameLinkButton" .. i].achibutton:SetSize(36,36)
				_G["WatchFrameLinkButton" .. i].achibutton:SetFrameLevel(4)
				_G["WatchFrameLinkButton" .. i].achibutton:SetPoint("TOPRIGHT",_G["WatchFrameLinkButton" .. i],"TOPLEFT",-10,0)
				_G["WatchFrameLinkButton" .. i].achibutton:SetParent(_G["WatchFrameLinkButton" .. i])
			end
			if not _G["WatchFrameLinkButton" .. i].type == "QUEST"  then ----区分watchframe 中的 成就追踪和任务追踪
				_G["WatchFrameLinkButton" .. i].achibutton:Hide()
				-- WATCHFRAME_QUESTLINES[_G["WatchFrameLinkButton" .. i].startLine].text:SetTextColor(0.75, 0.61, 0); ----------本色。。
			else
				-- WATCHFRAME_QUESTLINES[_G["WatchFrameLinkButton" .. i].startLine].text:SetTextColor(1, 0.75,0.79);  -----------情人节粉色。
				_G["WatchFrameLinkButton" .. i].achibutton:Show()
			end
			if achiid  then              --------当不存在对应成就时的处理
				local args0 ,achiname ,args1,args2,args3,args4,args5,args6,args7,achiicon = GetAchievementInfo(achiid)
				_G["QuestAchiButton" .. i].achiid = achiid
				-- print(achiicon)
				_G["QuestAchiButton" .. i].icon:SetTexture(achiicon)
				-- _G["QuestAchiButton" .. i].icon:Show()
				_G["QuestAchiButton" .. i].achiname = achiname
				_G["QuestAchiButton" .. i].questid = questid
			else
				_G["QuestAchiButton" .. i].achiid = nil
				-- _G["QuestAchiButton" .. i].icon:Hide()
				_G["QuestAchiButton" .. i].achiname = nil
				_G["QuestAchiButton" .. i].questid = nil
				_G["WatchFrameLinkButton" .. i].achibutton:Hide()
			end
			_G["WatchFrameLinkButton" .. i].achibutton:SetScript("OnClick",function (self)
				if self.achiid then 
					BF_ShowAchiByid(self.achiid)
				end
				-- print("Show achi" .. self.achiid)
			end)
			_G["WatchFrameLinkButton" .. i].achibutton:SetScript("OnEnter",function (self)
				ValentineAchi_tooltipShow(self)
			end)
			_G["WatchFrameLinkButton" .. i].achibutton:SetScript("OnLeave",function (self)
				ValentineAchi_tootipHide(self)
			end)
			-- _G["WatchFrameLinkButton" .. i]:HookScript("OnLeave",function (self)
				-- print(self.achibutton.achiid ,Valentine_GetAchiIDByQuestID(self.achibutton.questid))
				-- if self.achibutton.achiid  and Valentine_GetAchiIDByQuestID(self.achibutton.questid) then
					-- WATCHFRAME_QUESTLINES[self.startLine].text:SetTextColor(1, 0.75,0.79);
				-- end
			-- end)
		end
	end
end
function Init_ValentineQuestAchi()
	t_ValentineQuestForAchi = GetDayEventQuestForAchi(L_VALENTINE)
	Update_ValentineQuestAchi()                         --------创建对应成就按钮
	ValentineFrame = CreateFrame("FRAME","ValentineFrame")
	ValentineFrame:RegisterEvent("QUEST_LOG_UPDATE")   ---------ZONE_CHANGED_NEW_AREA -DISPLAY_SIZE_CHANGED -WORLD_MAP_UPDATE
	ValentineFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	ValentineFrame:RegisterEvent("DISPLAY_SIZE_CHANGED")
	ValentineFrame:RegisterEvent("WORLD_MAP_UPDATE")
	hooksecurefunc("WatchFrame_Update",function ()
		-- print("wathcFrameUpdate")
		Update_ValentineQuestAchi()
	end)
	ValentineFrame:SetScript("OnEvent",function (self,event)
		Update_ValentineQuestAchi()
		-- print(event)
	end)
end
function Valentine_GetAchiIDByQuestID(questId)  --------通过任务ID获取情人节成就ID
	if #t_ValentineQuestForAchi~= 0 then
		for i =1 ,#t_ValentineQuestForAchi do
			if t_ValentineQuestForAchi[i][1] == questId then
				return t_ValentineQuestForAchi[i][2]
			end
		end
	end
end
function ValentineAchi_tooltipShow(self)
	if self.achiname then
		GameTooltip:SetOwner(self,"ANCHOR_LEFT")
		GameTooltip:SetText(L_RELACHIEVEMENT .. self.achiname)
		GameTooltip:Show()
	end
end
function ValentineAchi_tootipHide(self)
	if GameTooltip:IsShown() then
		GameTooltip:Hide()
	end
end













---------------------------------------公共任务相关函数------------------------------
function GetDayEventQuestForAchi (name)   ---------------参数: 节日名 返回: 节日任务相关成就表
	if DayEvent_QuestForAchivment[name] then
		t_QuestForAchi = DayEvent_QuestForAchivment[name]
	end
	return t_QuestForAchi
end
function GetQuestIdByQuestLink(questlink)   ------------参数:任务连接 返回:对应任务ID
	args1,args2,questId = string.find(questlink,"Hquest:(%d+):")
	return questId
end
function BF_ShowAchiByid(achiid)     ----------参数:成就id 通过成就ID打开成就面板 会强制加载Blizzard_AchievementUI
	if not IsAddOnLoaded("Blizzard_AchievementUI") then
		LoadAddOn("Blizzard_AchievementUI")
	end
	AchievementFrame_ToggleAchievementFrame()
	AchievementFrame_SelectAchievement(achiid,true)
	
end