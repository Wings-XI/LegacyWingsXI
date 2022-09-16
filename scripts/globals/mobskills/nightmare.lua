---------------------------------------------------
-- Nightmare - NM Diabolos
-- AoE Sleep
-- Sleep that is not broken from DoT effects (any dmg source that doesn't break bind). 
-- + I.e. if a mob has helix, nightmare will still sleep the target
-- When this sleep is applied, it is accompanied by a Bio effect. That Bio effect doesn't break _any_ types of sleep
-- + I.e. if you nightmare a mob, then layer sleep II, the mob will stay asleep
-- The Bio does that by explicitly dealing lua dmg with the `wakeUp` flag set to false. 
--
-- This sleep is _also_ very difficult to break from any other dmg sources: "High chance to not break nightmare sleep from any damage"
-- This is hardcoded to be 90% chance to not break when the dmg normally would have woken the target
-- + I.e. NM diabolos applies nightmare, then uses Camisado. There is a 90% chance you stay asleep
-- the identifier for this more-powerful Nightmare sleep is when the subpower is 10 or more. You'll see references of SubPower() > 9 in both 
-- + status_effect_container.cpp
-- + lua_baseentity.cpp
-- 
-- Note that the sleep effect is not the thing doing damage. When nightmare is applied, you also get a Bio effect
-- if you erase the bio effect, the Sleep (with a subeffect of Bio) still behaves exactly the same as before
-- The AMOUNT of damage done to the target is irrelevant to the behavior of nightmare sleep, only the source of the damage.
---------------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.SLEEP_I
    local power = 20        -- ATTP reduction
    local tick = 3
    local duration = 60     -- Unresisted, 20 ticks at 21 hp/tick = 420hp per target
    local subEffect = tpz.effect.BIO
    local subPower = 21 -- 21 HP/tick drain

    -- Adjust parameters for CoP Diabolos.  This is an estimate, will need some battletesting
    local copDiabolos = 16818177
    if mob:getID() >= copDiabolos and mob:getID() <= copDiabolos + 14 then  -- three possible instances of Diabolos
        power = 10          -- ATTP reduction
        duration = 30
        subPower = 14       -- Unresisted, 10 ticks at 14 hp/tick = 140hp per target
    end
    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, power, tick, duration, subEffect, subPower))
    
    return typeEffect
end