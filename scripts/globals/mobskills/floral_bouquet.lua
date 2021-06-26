-----------------------------------
--  Floral Bouquet
--
--  Puts enemies in area of effect to sleep. Charms nearby monsters.
--  Type: Enfeebling
--  Range: Unknown radial
--  Utsusemi/Blink absorb: Ignores shadows
--
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    -- TODO: Charm nearby monsters
    
    local typeEffect = tpz.effect.SLEEP_I

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 1, 0, math.random(20, 30)))

    return typeEffect
end