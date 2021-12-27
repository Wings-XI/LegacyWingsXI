---------------------------------------------
--  Nullsong
--
--  Description: Removes all status effects in an area of effect.
--  Type: Enfeebling
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: 15' radial
--  Notes:
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    -- can only used if not silenced
    if (mob:hasStatusEffect(tpz.effect.SILENCE) == false) then
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    mob:eraseAllStatusEffect()
    local dispellCount = target:dispelAllStatusEffect()
    local totalCount = dispellCount + target:eraseAllStatusEffect()
    local damagePerBuff = math.random(80,109)

    if (totalCount == 0) then
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
    --else
        --skill:setMsg(tpz.msg.basic.DISAPPEAR_NUM)
    end
    target:takeDamage(damagePerBuff*dispellCount, mob, tpz.attackType.MAGICAL, tpz.damageType.DARK)
    return damagePerBuff * dispellCount
end
