---------------------------------------------
-- Mighty Strikes
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    local duration = 45

    if mob:getID() == 16941057 then
        duration = 30
    end
    
    MobBuffMove(mob, tpz.effect.MIGHTY_STRIKES, 1, 0, duration)

    skill:setMsg(tpz.msg.basic.USES)

    return tpz.effect.MIGHTY_STRIKES
end
