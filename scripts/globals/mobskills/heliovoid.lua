---------------------------------------------
-- Skill: Heliovoid
-- Absorbs one status effect from all players in range.
-- Type: Magical
-- Utsusemi/Blink absorb: 1 shadow
-- Range: Melee
-- Notes: If used against undead, it will simply do damage and not drain HP.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    -- try to drain buff
    local effect = mob:stealStatusEffect(target, tpz.effectFlag.DISPELABLE)

    if (effect ~= 0) then
        skill:setMsg(tpz.msg.basic.EFFECT_DRAINED)
        return 1
    else
        skill:setMsg(tpz.msg.basic.NO_EFFECT)
        return 0
    end
end
