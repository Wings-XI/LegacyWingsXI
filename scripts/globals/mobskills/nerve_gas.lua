---------------------------------------------
-- Nerve Gas
--
-- Description: Inflicts curse and powerful poison tpz.effect.
-- Type: Magical
-- Wipes Shadows
-- Range: 10' Radial
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)

    if (mob:getFamily() == 316) then -- PW
        local mobSkin = mob:getModelId()
        if (mobSkin == 1796) then
            return 0
        else
            return 1
        end
    elseif (mob:getFamily() == 313) then -- Tinnin can use at will
        return 0
    else
        if (mob:AnimationSub() == 0 and mob:getHPP() <= 25) then -- Only used when all 3 Hydra heads alive
            if (mob:getID() == 17093003) and (mob:getInstance():getStage() ~= 100) then -- Nyzul Isle Hydra will only use this on floor 100
                return 1
            end
            return 0
        else
            return 1
        end
    end
end

function onMobWeaponSkill(target, mob, skill)
    local cursePower = 50
    local poisonPower = 20
    local dmgmod = 1

    if (mob:getID() == 17093003) then -- Nyzul Isle Hydra
        cursePower = 30
        poisonPower = 15
        dmgmod = 1
    end
    -- Perform damage before curse - similar to chaos blade. Otherwise this is a instant kill vs anyone but Galka
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*5, tpz.magic.ele.NONE, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.NONE, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.NONE)

    MobStatusEffectMove(mob, target, tpz.effect.CURSE_I, cursePower, 0, 420)
    MobStatusEffectMove(mob, target, tpz.effect.POISON, poisonPower, 3, 60)
   
    return dmg
end
