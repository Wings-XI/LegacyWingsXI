---------------------------------------------
-- Vile Belch
--
-- Description: plague and silence Area of Effect (10.0')
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if mob:getID() == 16998874 then
        if mob:getLocalVar("Phase") == 2 then
            return 0
        else
            return 1
        end
    else
        return 0
    end

end

function onMobWeaponSkill(target, mob, skill)
    local plagued = false
    local silence = false
    local typeEffect

    plagued = MobStatusEffectMove(mob, target, tpz.effect.PLAGUE, 5, 3, 60)
    silence = MobStatusEffectMove(mob, target, tpz.effect.SILENCE, 1, 0, 60)

    skill:setMsg(tpz.msg.basic.SKILL_ENFEEB_IS)

    -- display plague first, else silence
    if plagued == tpz.msg.basic.SKILL_ENFEEB_IS then
        typeEffect = tpz.effect.PLAGUE
    elseif silence == tpz.msg.basic.SKILL_ENFEEB_IS then
        typeEffect = tpz.effect.SILENCE
    else
        skill:setMsg(tpz.msg.basic.SKILL_MISS)
    end

    return typeEffect
end
