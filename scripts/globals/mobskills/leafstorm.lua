---------------------------------------------
--  Leafstorm
--
--  Description: Deals wind damage within area of effect.
--  Type: Magical Wind
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
    if mob:GetMobByID() == 17555863 then -- Cemetery Cherry Leafstorm dispels all effects and gives slow instead of damage.
        local removables = {tpz.effect.FLASH, tpz.effect.BLINDNESS, tpz.effect.MAX_HP_DOWN, tpz.effect.MAX_MP_DOWN, tpz.effect.PARALYSIS, tpz.effect.POISON,
        tpz.effect.CURSE_I, tpz.effect.CURSE_II, tpz.effect.DISEASE, tpz.effect.PLAGUE, tpz.effect.WEIGHT, tpz.effect.BIND,
        tpz.effect.BIO, tpz.effect.DIA, tpz.effect.BURN, tpz.effect.FROST, tpz.effect.CHOKE, tpz.effect.RASP, tpz.effect.SHOCK, tpz.effect.DROWN,
        tpz.effect.STR_DOWN, tpz.effect.DEX_DOWN, tpz.effect.VIT_DOWN, tpz.effect.AGI_DOWN, tpz.effect.INT_DOWN, tpz.effect.MND_DOWN,
        tpz.effect.CHR_DOWN, tpz.effect.ADDLE, tpz.effect.SLOW, tpz.effect.HELIX, tpz.effect.ACCURACY_DOWN, tpz.effect.ATTACK_DOWN,
        tpz.effect.EVASION_DOWN, tpz.effect.DEFENSE_DOWN, tpz.effect.MAGIC_ACC_DOWN, tpz.effect.MAGIC_ATK_DOWN, tpz.effect.MAGIC_EVASION_DOWN,
        tpz.effect.MAGIC_DEF_DOWN, tpz.effect.MAX_TP_DOWN, tpz.effect.SILENCE}

        for i, effect in ipairs(removables) do
            if (mob:hasStatusEffect(effect)) then
                mob:delStatusEffect(effect)
            end
        end

        local typeEffect = tpz.effect.SLOW

        skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 1250, 0, 120))
    
        return typeEffect
    else
        local dmgmod = 1
        local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*math.random(4, 5), tpz.magic.ele.WIND, dmgmod, TP_NO_EFFECT)
        local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.WIND, MOBPARAM_WIPE_SHADOWS)
        target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.WIND)
        return dmg
    end
end