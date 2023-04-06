---------------------------------------------
-- Dream Flower
-- 15' AoE sleep
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.SLEEP_I
    -- Nightmare Mandragora
    local power = 20        -- ATTP reduction
    local tick = 3
    local duration = 60     -- Unresisted, 20 ticks at 21 hp/tick = 420hp per target
    local subEffect = tpz.effect.BIO
    local subPower = 10 -- Must be greater than 9 in order for target to stay asleep through damage.  See nightmare.lua for full description

    if (mob:getZone():getType() == tpz.zoneType.DYNAMIS) then
        skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, power, tick, duration, subEffect, subPower))
        target:delStatusEffectSilent(subEffect)
    else
        skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 1, 0, math.random(20, 30)))
    end

    return typeEffect
end
