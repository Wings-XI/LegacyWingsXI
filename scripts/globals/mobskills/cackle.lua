---------------------------------------------------
--  Cackle
--  Reduces magical attack, accuracy, and defense of targets in an area of effect.
---------------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    -- smaller range to use, but 30 yalm AoE. Effectively cannot out-range the skill
    if mob:checkDistance(target) > 10 then
        return 1
    end

    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local power = 40
    local duration = 60
    local returnEffect = tpz.effect.NONE
    local typeEffect = {
        tpz.effect.MAGIC_ATK_DOWN,
        tpz.effect.MAGIC_ACC_DOWN,
        tpz.effect.MAGIC_DEF_DOWN,
    }

    skill:setMsg(tpz.msg.basic.SKILL_MISS)
    for i = 1, 3 do
        if MobStatusEffectMove(mob, target, typeEffect[i], power, 0, duration) == tpz.msg.basic.SKILL_ENFEEB_IS then
            returnEffect = typeEffect[i]
            skill:setMsg(tpz.msg.basic.SKILL_ENFEEB_IS)
        end
    end
    return returnEffect
end
