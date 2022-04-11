---------------------------------------------
-- Nightmare
-- AOE Sleep with Bio dot
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
    local power = 20
    local tick = 3
    local duration = 60     -- Unresisted, 20 ticks at 21 hp/tick = 420hp per target
    local subEffect = tpz.effect.BIO
    local subPower = 21 -- 21 HP/tick drain

    -- Adjust parameters for CoP Diabolos.  This is an estimate, will need some battletesting
    local copDiabolos = 16818177
    if mob:getID() >= copDiabolos and mob:getID() <= copDiabolos + 14 then  -- three possible instances of Diabolos
        power = 10
        duration = 30
        subPower = 14       -- Unresisted, 10 ticks at 14 hp/tick = 140hp per target
    end
    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, power, tick, duration, subEffect, subPower))
    
    return typeEffect
end