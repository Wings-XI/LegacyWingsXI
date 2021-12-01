---------------------------------------------
-- Pollen
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
        potency = 12
    end

    potency = potency - math.random(0, potency/4)

    skill:setMsg(tpz.msg.basic.SELF_HEAL)

    if mob:getID() == 17584398 then -- Demonic Tiphia pollen recovers 3k+ HP
        return MobHealMove(mob, 3300) -- TODO: Working out correct potency
    else
        return MobHealMove(mob, mob:getMaxHP() * potency / 100)
    end
end
