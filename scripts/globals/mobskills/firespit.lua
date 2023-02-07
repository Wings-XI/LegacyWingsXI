---------------------------------------------
-- Firespit
--
-- Description: Deals fire damage to an enemy.
-- if it s from a Mamool ja fighter (brown mamool ja): 3 hit physical (Fire)
-- if it s from a Mamool ja mage (blue mamool ja): 1 hit Magical (Fire)
-- Type: Magical (Fire)
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    if mob:getFamily() == 176 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1618 then
            local numhits = 3
            local accmod = 1
            local dmgmod = 1

            local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_ACC_VARIES, 1, 2, 3)
            local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.FIRE, info.hitslanded)
            target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.FIRE)
            if dmg > 0 and skill:getMsg() ~= 31 then 
                target:tryInterruptSpell(mob, info.hitslanded)
            end

            return dmg
        else
            local dmgmod = 1

            local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*4, tpz.magic.ele.FIRE, dmgmod, TP_NO_EFFECT)
            local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.FIRE, MOBPARAM_IGNORE_SHADOWS)
            target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.FIRE)

            return dmg
        end
    elseif mob:getFamily() == 305 then -- Gotoh Zha the Redolent

        local numhits = 3
        local accmod = 1
        local dmgmod = 3

        local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*4, tpz.magic.ele.FIRE, dmgmod, TP_NO_EFFECT)
        local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.FIRE, MOBPARAM_IGNORE_SHADOWS)
        -- scale dmg based on distance from mob when past 10 yalms: normal dmg < 10 yalms, linear reduction up to 80% reduction at 30yalms
        dmg = dmg * (1 - utils.clamp(math.max(mob:checkDistance(target) - 10, 0) / 25, 0, .8))
        target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.FIRE)

        return dmg


    end
end
