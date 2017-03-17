
local _MAP_ADJACENT_DISTANCE = 20
local secure_hooked,node_index
local Festival_Data_Table

local _MAP_MARK_TEXTURE = {
	[MAP_MARK_TheSpringFestival]	= "Interface\\AddOns\\FestivalHelper\\material\\TheSpringFestival",
	[MAP_MARK_ValentineDay]			= "Interface\\AddOns\\FestivalHelper\\material\\Valentine'sDay",
}

local _MAP_MARK_DATA_TEXTURE = {
	["情人节成就目标"] = MAP_MARK_ValentineDay,
	["成就危险的爱起始"] = MAP_MARK_ValentineDay,
	["友善地交谈"] = MAP_MARK_ValentineDay,
	
}

-- 6.0
local zoneList = {}
local zonetoMapID = {}
local reverseZoneC = {}
local reverseZoneZ = {}
local continentList = {}

local reverseMapFileC = {
	["Cosmic"] = WORLDMAP_COSMIC_ID,
	["World"] = WORLDMAP_AZEROTH_ID,
}
local reverseMapFileZ = {
	["Cosmic"] = 0,
	["World"] = 0,
}

local mapIDtoMapFile = {
	[WORLDMAP_COSMIC_ID] = "Cosmic",
	[WORLDMAP_AZEROTH_ID] = "World",
}
local mapFiletoMapID = {
	["Cosmic"] = -1,
	["World"] = 0,
}

local continentMapFile = {
	[WORLDMAP_COSMIC_ID] = "Cosmic", -- That constant is -1
	[WORLDMAP_AZEROTH_ID] = "World",
}

local continentTempList = {GetMapContinents()}
for i = 1, #continentTempList, 2 do
	local C = (i + 1) / 2
	local mapID, CName = continentTempList[i], continentTempList[i+1]
	SetMapZoom(C, 0)
	local mapFile = GetMapInfo()
	reverseZoneC[CName] = C
	reverseZoneZ[CName] = 0
	continentList[C] = CName
	reverseMapFileC[mapFile] = C
	reverseMapFileZ[mapFile] = 0
	mapIDtoMapFile[mapID] = mapFile
	mapFiletoMapID[mapFile] = mapID
	continentMapFile[C] = mapFile
	zoneList[C] = {}
	local zoneTempList = {GetMapZones(C)}
	for j = 1, #zoneTempList, 2 do
		local mapID, ZName = zoneTempList[j], zoneTempList[j+1]
		SetMapByID(mapID)
		local Z = GetCurrentMapZone()
		local mapFile = GetMapInfo()
		zoneList[C][Z] = ZName
		reverseMapFileC[mapFile] = C
		reverseMapFileZ[mapFile] = Z
		reverseZoneC[ZName] = C
		reverseZoneZ[ZName] = Z
		mapIDtoMapFile[mapID] = mapFile
		mapFiletoMapID[mapFile] = mapID
		zonetoMapID[ZName] = mapID
	end

	-- map things we don't have on the map zones
	local areas = GetAreaMaps()
	for i, mapID in pairs(areas) do
		SetMapByID(mapID)
		local mapFile = GetMapInfo()
		local ZName = GetMapNameByID(mapID)
		local C, Z = GetCurrentMapContinent(), GetCurrentMapZone()
		
		-- nil out invalid C/Z values (Cosmic/World)
		if C == -1 or C == 0 then C = nil end
		if Z == 0 then Z = nil end
		
		-- insert into the zonelist, but don't overwrite entries
		if C and zoneList[C] and Z and not zoneList[C][Z] then
			zoneList[C][Z] = ZName
		end
		mapIDtoMapFile[mapID] = mapFile
		-- since some mapfiles are used twice, don't overwrite them here
		-- the second usage is usually a much weirder place (instances, scenarios, ...)
		if not mapFiletoMapID[mapFile] then
			mapFiletoMapID[mapFile] = mapID
			reverseMapFileC[mapFile] = C
			reverseMapFileZ[mapFile] = Z
		end
		if not zonetoMapID[ZName] then
			zonetoMapID[ZName] = mapID
			reverseZoneC[ZName] = C
			reverseZoneZ[ZName] = Z
		end
	end
end

local Map_id_Table = {
	[520] = "魔枢",
	[523] = "乌特加德城堡",
	[524] = "乌特加德之巅",
	[526] = "岩石大厅",
	[530] = "古达克",
	[533] = "艾卓-尼鲁布",
	[534] = "达克萨隆要塞",
	[686] = "祖尔法拉克",
	[687] = "阿塔哈卡神庙",
	[704] = "黑石深渊",
	[721] = "黑石塔",
	[750] = "玛拉顿",
	[765] = "斯坦索姆",
}

local function _HideNodes()
	local _i = 1
	while _G["FestivalMapMark".._i] do
		_G["FestivalMapMark".._i]:Hide()
		_i = _i + 1
	end
end

local function GetCZToZone(C, Z)
	if not C or not Z then return end
	if Z == 0 then
		return continentList[C]
	elseif C > 0 then
		return zoneList[C][Z]
	end
end

local function _getCurrentMapName()
	local mapId = GetCurrentMapZone();
	if mapId >0 then
		local currLevel = GetCurrentMapDungeonLevel();
		if currLevel == 0 then currLevel = 1 end
		return GetCZToZone(GetCurrentMapContinent(),mapId), currLevel;
	end
	local _MapID = GetCurrentMapAreaID();
	if  Map_id_Table[_MapID] then
		local currLevel = GetCurrentMapDungeonLevel();
		if currLevel == 0 then currLevel = 1 end
		return Map_id_Table[_MapID], currLevel;
	end
end

local function _GetDataType(_type)
	if _MAP_MARK_DATA_TEXTURE[_type] then
		return _MAP_MARK_DATA_TEXTURE[_type]
	end
	return _type
end

local function coord_transform(width,height,x,y)
	return x*width/100,-y*height/100
end

local function showNodes(_type,name,...)
	local function showNode(name,_type,x,y)
		local texture = _MAP_MARK_TEXTURE[_GetDataType(_type)];
		local button =  _G["FestivalMapMark"..node_index]
		if not button then
			button = CreateFrame("Button","FestivalMapMark"..node_index,WorldMapDetailFrame,"FestivalHelperMapMarkTemplate")
		end
		button:SetPoint("CENTER",WorldMapDetailFrame,"TOPLEFT",coord_transform(WorldMapDetailFrame:GetWidth(), WorldMapDetailFrame:GetHeight(),x,y))
		_G[button:GetName().."Icon"]:SetTexture(texture);
		button.text2 = name
		button.text = _type
		node_index = node_index + 1
		button:Show()
	end
	local _coord = ...
	showNode(name,_type,_coord[1],_coord[2])
end

function Festival_MarkUpdate(self)
	_HideNodes();
	if not FestivalHelper_Config.showFestivalMarks then return end
	node_index = 1;
	local mapName, currLevel = _getCurrentMapName();
	if mapName and Festival_Data_Table and type(Festival_Data_Table) == "table" and #Festival_Data_Table > 0 then
		for i,data in ipairs(Festival_Data_Table) do
			if Festival_Data_Table[i] and Festival_Data_Table[i][mapName] then
				local mapNodes = Festival_Data_Table[i][mapName];
				for _,_node in pairs(mapNodes) do
					if _node[4] and _node[4] == currLevel then
						showNodes(_node[1],_node[2],select(3,unpack(_node)))
					end
				end
			end
		end
	end
end

local function Distance(coord1,coord2)
	return (coord1[1]-coord2[1])^2 + (coord1[2]-coord2[2])^2
end

local camp = {
	["Orc"] = 1,
	["Tauren"] = 1,
	["Scourge"] = 1,
	["BloodElf"] = 1,
	["Troll"] = 1,
	["Goblin"] = 1,
	["Human"] = 2,
	["NightElf"] = 2,
	["Dwarf"] = 2,
	["Gnome"] = 2,
	["Draenei"] = 2,
	["Worgen"] = 2,
}

local function getCamp(race)
	if race and camp[race] then
		return camp[race];
	end
end

local function IsFestivalAdjacent(dbTable, entry)
	if not dbTable or not dbTable[entry[1]] then return false end
	for _,coord in pairs(dbTable[entry[1]]) do
		if Distance(coord,entry[3]) < _MAP_ADJACENT_DISTANCE then
			return true
		end
	end
	return false
end

local function Festival_ReadData(_table)
	if type(_table) ~= "table" then return end
	local tempDB = {}
	local outPut ={}
	for _,entry in pairs(_table) do
		tempDB[entry[1]] = tempDB[entry[1]] or {}
		if not IsFestivalAdjacent(tempDB,entry) and (entry[5] and entry[5] ~= getCamp(select(2,UnitRace("player"))) or not entry[5]) then
			tinsert(tempDB[entry[1]],entry[3])
			tinsert(outPut,entry)
		end
	end
	return outPut
end

function FH_SetToggleButton()
	if not secure_hooked then
		WorldMapFrame:HookScript("OnUpdate", Festival_MarkUpdate);
		secure_hooked = true;
	end
	
	if FestivalHelperCheckButton then return end
	
	local frame = CreateFrame("Frame", nil, WorldMapDetailFrame);
	frame:SetSize(130, 20);
	frame:SetPoint("TOPRIGHT", WorldMapDetailFrame, "TOPRIGHT", -5, -55);
	frame:EnableMouse(1);
	frame:SetFrameStrata("HIGH");
	frame:SetFrameLevel(5);
	frame:Show();

	frame.check = CreateFrame("CheckButton", "FestivalHelperCheckButton", frame, "OptionsBaseCheckButtonTemplate");
	frame.check:SetSize(22, 22);
	frame.check:SetHitRectInsets(0, 0, 0, 0);
	frame.check:SetPoint("LEFT");
	frame.check:SetChecked(FestivalHelper_Config.showFestivalMarks);
	frame.check:SetFrameLevel(6);
	frame.check:SetScript("OnClick", function(self)
		if (self:GetChecked()) then
			FestivalHelper_Config.showFestivalMarks = true
		else
			FestivalHelper_Config.showFestivalMarks = false
		end
	end)

	local font, size = GameTooltipHeader:GetFont();
	frame.text = frame:CreateFontString();
	frame.text:SetFont(font, 16, "OUTLINE");
	frame.text:SetTextColor(255/255, 210/255, 0/255, 1);
	frame.text:SetText(FestivalHelper_Title);
	frame.text:SetPoint("LEFT", frame.check, "RIGHT");
end

function FH_ReadFestivalData(data)
	if not Festival_Data_Table or type(Festival_Data_Table) ~= "table" then
		Festival_Data_Table = {}
	end
	local _tempTable = {}
	for MapName,_table in pairs(data) do
		_tempTable[MapName] = Festival_ReadData(_table)
	end
	tinsert(Festival_Data_Table,_tempTable)

	FH_SetToggleButton()
end

local function IsButtonsAdjacent(button1, button2)
	local x1, y1 = button1:GetCenter();
	local x2, y2 = button2:GetCenter();
	return ((x1-x2)^2 + (y1-y2)^2 <200)
end

function FestivalHelperMapMarkPoint_OnEnter(self)
	local x, y = self:GetCenter();
	local parentX = self:GetParent():GetCenter();
	if ( x > parentX ) then
		FestivalHelperMapMarkTooltip:SetOwner(self, "ANCHOR_LEFT");
	else
		FestivalHelperMapMarkTooltip:SetOwner(self, "ANCHOR_RIGHT");
	end
	FestivalHelperMapMarkTooltip:AddLine(self.text)
	local font = _G["FestivalHelperMapMarkTooltipTextLeft"..FestivalHelperMapMarkTooltip:NumLines()]:GetFontObject()
	FestivalHelperMapMarkTooltip:AddLine(self.text2)
	_G["FestivalHelperMapMarkTooltipTextLeft"..FestivalHelperMapMarkTooltip:NumLines()]:SetTextColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b)
	local _i = 1
	while _G["FestivalMapMark".._i] do
		local button = _G["FestivalMapMark".._i]
		if button:IsShown() and button ~= self and  IsButtonsAdjacent(button,self) then
			FestivalHelperMapMarkTooltip:AddLine(" ")
			FestivalHelperMapMarkTooltip:AddLine(button.text)
			_G["FestivalHelperMapMarkTooltipTextLeft"..FestivalHelperMapMarkTooltip:NumLines()]:SetFontObject(font)
			FestivalHelperMapMarkTooltip:AddLine(button.text2)
			_G["FestivalHelperMapMarkTooltipTextLeft"..FestivalHelperMapMarkTooltip:NumLines()]:SetTextColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b)
		end
		_i = _i + 1
	end
	FestivalHelperMapMarkTooltip:Show();
end

function FestivalHelperMapMarkPoint_OnLeave(self)
	FestivalHelperMapMarkTooltip:Hide();
end
