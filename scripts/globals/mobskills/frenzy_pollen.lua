---------------------------------------------
-- Frenzy Pollen
-- Description
-- Simulates Hundred Fists.
-- Family: Bee
-- Type: Enhancing
-- Can be dispelled: No
-- Utsusemi/Blink absorb: N/A
-- Range: Self
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    local duration = 30

    MobBuffMove(mob, tpz.effect.HUNDRED_FISTS, 1, 0, duration)

    skill:setMsg(tpz.msg.basic.SKILL_GAIN_EFFECT)

    return tpz.effect.HUNDRED_FISTS
end
