---------------------------------------------
-- Zantetsuken
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/summon")
---------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onPetAbility(target, pet, skill, master)
    local power = (master:getMP() / master:getMaxMP())*.8 + getSummoningSkillOverCap(pet)*.004 -- cap at 80% but increase 0.4% per summoning skill over cap
    master:setMP(0)
    master:delStatusEffect(tpz.effect.ASTRAL_FLOW)

    if (target:isNM()) then
        local dmg = 0.142 * target:getHP() + 0.142 * target:getHP() * power
        if (dmg > 9999) then
            dmg = 9999
        end
        dmg = MobMagicalMove(pet, target, skill, dmg, tpz.magic.ele.DARK, 1, TP_NO_EFFECT, 0)
        dmg = mobAddBonuses(pet, nil, target, dmg.dmg, tpz.magic.ele.DARK)
        dmg = AvatarFinalAdjustments(dmg, pet, skill, target, tpz.attackType.MAGICAL, tpz.damageType.DARK, 1)
        target:takeDamage(damage, pet, tpz.attackType.MAGICAL, tpz.damageType.DARK)
        target:updateEnmityFromDamage(pet, dmg)
        return dmg
    else
        local chance = power / skill:getTotalTargets()
        if target:getHP() / target:getMaxHP() < 0.5 then
            chance = chance + 0.2
        end
        local leveldiff = pet:getMainLvl() - target:getMainLvl()
        if leveldiff < -3 then
            leveldiff = -3
        end
        if leveldiff > 20 then
            leveldiff = 20
        end
        chance = chance + leveldiff/100
        if math.random() < chance and target:getAnimation() ~= 33 then
            skill:setMsg(tpz.msg.basic.SKILL_ENFEEB_IS)
            target:takeDamage(target:getHP(), pet, tpz.attackType.MAGICAL, tpz.damageType.DARK)
            return tpz.effect.KO
        else
            skill:setMsg(tpz.msg.basic.EVADES)
            return 0
        end
    end
end
