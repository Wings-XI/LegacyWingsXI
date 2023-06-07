---------------------------------------------------
-- Holy Roll 1
---------------------------------------------------
require("scripts/globals/summon")
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/magic")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local power = 1
    local dMND = math.floor(mob:getStat(tpz.mod.MND) - target:getStat(tpz.mod.MND))
    local ele = tpz.damageType.LIGHT
    local dmg = 0

    local dmgmod = 1
    local basedmg = mob:getWeaponDmg() * power + (dMND * 1.5)
    if target:getMainLvl() % power == 0 then
        local info = MobMagicalMove(mob, target, skill, basedmg, ele - 5, dmgmod, TP_NO_EFFECT)
        dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, ele, MOBPARAM_IGNORE_SHADOWS)
        target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, ele)
    else
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
    end
    return dmg
end
