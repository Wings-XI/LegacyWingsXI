---------------------------------------------
--  Discharge
--  Description: Deals lightning damage. Additional effect: "Paralysis"
--  Type: Magical (lightning)
--  Utsusemi/Blink absorb: Wipes shadows
--  Range: Aoe
--  Notes:
---------------------------------------------
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    MobStatusEffectMove(mob, target, tpz.effect.PARALYSIS, 20, 0, 180)

    local wDmgMultiplier = 2

    -- Nyzul Isle Racing Chariots
    if (mob:getID() >= 17092994 and mob:getID() <= 17092998) then
        -- lower damage from the racing chariots
        wDmgMultiplier = 1.5
    end

    local dmgmod = 2
    local accmod = 1
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*wDmgMultiplier, tpz.magic.ele.THUNDER, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.THUNDER, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.THUNDER)
    return dmg
end
