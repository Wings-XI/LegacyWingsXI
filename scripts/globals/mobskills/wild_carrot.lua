---------------------------------------------
-- Wild Carrot
--
-- Description: Restores HP.
--
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local potency = skill:getParam()

    if (potency == 0) then
        potency = 13
    end

    potency = potency - math.random(0, potency/4)

    skill:setMsg(tpz.msg.basic.SELF_HEAL)

    if mob:getZone():getType() == tpz.zoneType.DYNAMIS then
        mob:eraseStatusEffect()
    end

    return MobHealMove(mob, mob:getMaxHP() * potency / 100)
end
