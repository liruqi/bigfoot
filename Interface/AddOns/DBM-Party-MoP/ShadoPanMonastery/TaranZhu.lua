﻿local mod	= DBM:NewMod(686, "DBM-Party-MoP", 3, 312)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")

mod:SetRevision(("$Revision: 9656 $"):sub(12, -3))
mod:SetCreatureID(56884)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"SPELL_DAMAGE",
	"SPELL_MISSED"
)

local warnRingofMalice		= mod:NewSpellAnnounce(131521, 3)
local warnGrippingHatred	= mod:NewSpellAnnounce(115002, 2)
local warnHazeofHate		= mod:NewTargetAnnounce(107087, 4)
local warnRisingHate		= mod:NewCastAnnounce(107356, 4, 5)

local specWarnGrippingHatred= mod:NewSpecialWarningSwitch("ej5817")
local specWarnHazeofHate	= mod:NewSpecialWarningYou(107087)
local specWarnRisingHate	= mod:NewSpecialWarningInterrupt(107356, not mod:IsHealer())
local specWarnDarkH			= mod:NewSpecialWarningMove(112933)

local timerRingofMalice		= mod:NewBuffActiveTimer(15, 131521)
local timerGrippingHartedCD	= mod:NewNextTimer(45.5, 115002)

mod:AddBoolOption("InfoFrame", true)

local Hate = EJ_GetSectionInfo(5827)

function mod:OnCombatStart(delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(Hate)
		DBM.InfoFrame:Show(5, "playerpower", 5, ALTERNATE_POWER_INDEX)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 131521 then
		warnRingofMalice:Show()
		timerRingofMalice:Start()
	elseif args.spellId == 107087 then
		warnHazeofHate:Show(args.destName)
		if args:IsPlayer() then
			specWarnHazeofHate:Show()
			sndWOP:Play("ex_mop_zhgg")--憎恨過高
		end
	elseif args.spellId == 107356 then
		warnRisingHate:Show()
		specWarnRisingHate:Show(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 115002 and self:AntiSpam(5, 2) then
		warnGrippingHatred:Show()
		specWarnGrippingHatred:Show()
		timerGrippingHartedCD:Start()
		sndWOP:Play("ex_mop_zqkd")--紫球快打
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 125891 then
		DBM:EndCombat(self)
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, _, _, _, overkill)
	if spellId == 112933 and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then
		specWarnDarkH:Show()
		if not mod:IsTank() then
			sndWOP:Play("runaway")--快躲開
		end
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE