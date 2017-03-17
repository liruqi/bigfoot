local function __OnButtonEnter(self)
	-- GameTooltip_SetDefaultAnchor(GameTooltip, self);
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip:AddLine(Valentine_USED_ITEM_TIP);
	GameTooltip:Show()
end
local function FestivalHelper__CreatNewButton()
	local f =CreateFrame("Button", "TargetFrameTFrameValentine",TargetFrame,"SecureActionButtonTemplate,SecureHandlerEnterLeaveTemplate");
	f:SetHeight(28)
	f:SetWidth(28)
	f:SetPoint("TOPLEFT",TargetFrame,"TOPLEFT",80,0)
	-- f:SetFrameStrata(TargetFrame:GetFrameStrata())
	f:SetFrameLevel(TargetFrame:GetFrameLevel()+2)
	f:SetAttribute("type","macro");
	f:SetAttribute("macrotext","/use "..USED_ITEM_NAME);
	f.OnEnterFrame = __OnButtonEnter
	f.OnLeaveFrame = function()GameTooltip:Hide() end
	f:SetAttribute("_onenter",[[
		control:CallMethod("OnEnterFrame",self)
	]])
	f:SetAttribute("_onleave",[[
		control:CallMethod("OnLeaveFrame",self)
	]]
	)
	local border = f:CreateTexture(f:GetName().."Border","OVERLAY")
	-- local border = f:CreateTexture(f:GetName().."Border")
	local texture = f:CreateTexture(f:GetName().."Texture")
	-- border:SetHeight(20)
	-- border:SetWidth(20)
	-- border:SetPoint("TOPLEFT",f,"TOPLEFT",0,0)
	border:SetTexture([[Interface\Minimap\MiniMap-TrackingBorder]])
	border:SetTexCoord(0.05,0.6,0.04,0.6)
	border:SetAllPoints()
	texture:SetPoint("TOPLEFT",border,"TOPLEFT",0,0)
	texture:SetHeight(28)
	texture:SetWidth(28)
	texture:SetTexture([[Interface\AddOns\FestivalHelper\material\BF_Valentine.tga]])
	-- local coords = CLASS_BUTTONS["PALADIN"]
	texture:SetTexCoord(0,1,0,1)
	texture:Show()
	border:Show()
end

local function FestivalHelper_TargetFrame_Update(self)
	if InCombatLockdown() then return end
	if ( UnitExists(self.unit) and ValentineModOpen ) then
		local bfind = FestivalHelper_CheckUnit(self.unit);
		if TargetFrameTFrameValentine then
			if bfind then
				TargetFrameTFrameValentine:Show()
			else
				TargetFrameTFrameValentine:Hide()
			end
		end
	else
		TargetFrameTFrameValentine:Hide()
	end
end
FestivalHelper__CreatNewButton();
hooksecurefunc("TargetFrame_Update",FestivalHelper_TargetFrame_Update);