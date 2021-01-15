---------------------------------------------
--  Meteor
--
--  Description: Hardcore non-elemental damage
--  Type: Magical
--
--
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    local dmgmod = 1.3
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*6, -1, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.DARK, MOBPARAM_IGNORE_SHADOWS)
    
    if target:hasStatusEffect(tpz.effect.FEALTY) then
        dmg = math.floor(dmg / 16)
    end
    
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.DARK)
    return dmg
end
