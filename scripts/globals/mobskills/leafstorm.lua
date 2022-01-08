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
    if mob:getID() == 17555863 or mob:getID() == 16932881 then -- Cemetery Cherry Leafstorm dispels all effects and gives slow instead of damage.
        local dispel =  target:dispelAllStatusEffect(bit.bor(tpz.effectFlag.DISPELABLE, tpz.effectFlag.FOOD))

        if dispel == 0 then
            -- no effect
            skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT) -- no effect
        else
            skill:setMsg(tpz.msg.basic.DISAPPEAR_NUM)
        end

        target:addStatusEffect(tpz.effect.SLOW, 1250, 0, 120)

        return dispel
    else
        local dmgmod = 1
        local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*math.random(4, 5), tpz.magic.ele.WIND, dmgmod, TP_NO_EFFECT)
        local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.WIND, MOBPARAM_WIPE_SHADOWS)
        target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.WIND)
        return dmg
    end
end