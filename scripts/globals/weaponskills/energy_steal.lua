------------------------
--    Energy Steal    --
------------------------

require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/msg")

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)
   -- TODO: Should steal MP based on TP and not wake the mob involved.
   
	local daggerbonus = player:getSkillLevel(dsp.skill.DAGGER) / 20
	local mndbonus = player:getStat(dsp.mod.MND) / 3
	local tpmult = 1 + ((tp - 1000)/3200)
   
	local mpgained = (2 + daggerbonus + mndbonus) * tpmult
	mpgained = mpgained * (math.random(80,120)/100)
	mpgained = 0.88 * mpgained
   
	player:addMP(mpgained)
	player:messagePublic(dsp.msg.basic.SKILL_DRAIN_MP, target, wsID, mpgained)
	player:trySkillUp(target, tpz.skill.DAGGER, 1)
	return mpgained
	--return 1, 0, false, 65
end
