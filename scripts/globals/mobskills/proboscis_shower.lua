---------------------------------------------
-- Proboscis Shower
-- Description: Restores HP.
-- Copied from Healing Breeze: needs retail calculations
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local potency = skill:getParam()

    if potency == 0 then
        potency = 13
    end

    potency = potency - math.random(0, potency/4)

    skill:setMsg(tpz.msg.basic.SELF_HEAL)
    local divisor = 100

    if mob:getID() == 16986429 then -- Iriz Ima Proboscis Shower (video calculations)
        divisor = 350
    end
    return MobHealMove(mob, mob:getMaxHP() * potency / divisor)
end
