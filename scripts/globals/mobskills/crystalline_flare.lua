---------------------------------------------------
-- Crystalline Flare - Riko Kupenriech (AMK 14)
-- 
-- Deals moderate-high damage to opponents within Area of Effect. Additional Effect: Stun + Blind
-- Only used by Riko Kupenreich. He will Draw In the entire party shortly before using this attack. The stun effect is unusually long.
---------------------------------------------------
local ID = require("scripts/zones/Throne_Room/IDs")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 1
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*math.random(5, 12), tpz.magic.ele.NONE, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.ELEMENTAL, MOBPARAM_IGNORE_SHADOWS)
    MobStatusEffectMove(mob, target, tpz.effect.STUN, 1, 0, math.random(10, 20))
    MobStatusEffectMove(mob, target, tpz.effect.BLINDNESS, 1, 0, 120)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.ELEMENTAL)
    mob:showText(mob, ID.text.CRYSTAL_PRIZE)
    return dmg
end
