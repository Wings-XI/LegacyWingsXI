---------------------------------------------
-- Fulmination
--
-- Description: Deals heavy magical damage in an area of effect. Additional effect: Paralysis + Stun
-- Type: Magical
-- Utsusemi/Blink absorb: Wipes Shadows
-- Range: 30 yalms
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    local family = mob:getFamily()

    if(family == 316) then
        local mobSkin = mob:getModelId()

        if (mobSkin == 1805) then
            return 0
        else
            return 1
        end
    end

    local mobhp = mob:getHPP()
    local result = 1

    if (family == 168 and mobhp <= 35) then -- Khimaira < 35%
        if (mob:getID() == 17093002) then -- Nyzul Isle Khimaira will only use this on floor 100 and below 25%
            if (mob:getInstance():getStage() == 100) and (mobhp <= 25) then
                return 0
            else
                return 1
            end
        end
        result = 0
    elseif (family == 315 and mobhp <= 50) then -- Tyger < 50%
        result = 0
    end

    return result
end

function onMobWeaponSkill(target, mob, skill)

    local dmgmod = 8
    if (mob:getID() == 17093002) then -- Nyzul Isle Khimaira
        dmgmod = 5
    end
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg(), tpz.magic.ele.THUNDER, dmgmod, TP_MAB_BONUS, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.LIGHTNING, MOBPARAM_WIPE_SHADOWS)
    MobStatusEffectMove(mob, target, tpz.effect.PARALYSIS, 50, 0, 60)
    MobStatusEffectMove(mob, target, tpz.effect.STUN, 1, 0, 4)

    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.LIGHTNING)
    return dmg
end
