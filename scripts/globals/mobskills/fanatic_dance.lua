---------------------------------------------
-- Fanatic Dance
-- Family: Orc
-- Description: Charms all targets in an area of effect.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: N/A
-- Range: AoE around user
-- Notes: Dynamis NM Orcs only
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (mob:getID() == 17534978 or
        mob:getID() == 17534979 or
        mob:getID() == 17535006 or
        mob:getID() == 17535032 or
        mob:getID() == 17535044 or
        mob:getID() == 17535207 or
        mob:getID() == 17535208 or
        mob:getID() == 17535209 or
        mob:getID() == 17535210 or
        mob:getID() == 17535211) then
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.CHARM_I
    local power = 0

    if (not target:isPC()) then
        skill:setMsg(tpz.msg.basic.SKILL_MISS)
        return typeEffect
    end

    local msg = MobStatusEffectMove(mob, target, typeEffect, power, 3, 60)
    if (msg == tpz.msg.basic.SKILL_ENFEEB_IS) then
        mob:charm(target)
        mob:resetEnmity(target)
    end
    skill:setMsg(msg)

    return typeEffect
end
