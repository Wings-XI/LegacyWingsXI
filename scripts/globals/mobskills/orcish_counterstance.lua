---------------------------------------------
-- Orcish Counterstance
-- Used only by Orcs in Wings of the Goddess Areas.
-- Certain NMs may have a higher power version of the tpz.effect.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
require("scripts/globals/zone")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (mob:getContinentID() == tpz.continent.THE_SHADOWREIGN_ERA) then
        return 0
    else
        return 1
    end
end

function onMobWeaponSkill(target, mob, skill)
    local power = 50
    local duration = 60
    local typeEffect = tpz.effect.COUNTERSTANCE

    -- technically there should not be a "mob gains the effect of Counterstance" message
    skill:setMsg(MobBuffMove(mob, typeEffect, power, 0, duration))

    return typeEffect
end
