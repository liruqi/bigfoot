local function FestivalHelper_SetUnit(self, __unit)
	if ValentineModOpen then
		local bfind = FestivalHelper_CheckUnit(__unit);
		if bfind then
			GameTooltip:SetBackdropColor(244/255,140/255,186/255,1);
			-- GameTooltip:SetBackdropBorderColor(244/255,140/255,186/255,1);
		end
	end
	-- print(GetUnitStr(__unit),bfind)
end

hooksecurefunc(GameTooltip, "SetUnit", FestivalHelper_SetUnit)