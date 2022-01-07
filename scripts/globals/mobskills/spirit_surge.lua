---------------------------------------------
-- Spirit Surge
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local mhp_boost = target:getMaxHP()*0.05
    strBoost = (1 + target:getMainLvl()/5)
    target:addTP(3000)
    local duration = 60

    target:addStatusEffect(tpz.effect.SPIRIT_SURGE, mhp_boost, 0, duration, 0, strBoost)

    skill:setMsg(tpz.msg.basic.USES)

    return tpz.effect.SPIRIT_SURGE
end
