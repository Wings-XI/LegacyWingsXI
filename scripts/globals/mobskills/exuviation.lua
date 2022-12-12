---------------------------------------------
-- Exuviation
-- Family: Wamoura
-- Type: Healing and Full Erase
-- Range: Self
-- Notes: Erases all negative effects on the mob and heals an amount for each removed.
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
    local baseHeal = 500
    local statusHeal = 750
    local effectCount = 0

    for i, effect in ipairs(mob:getStatusEffects()) do
        -- check mask bit for tpz.effectFlag.DISPELABLE
        if (utils.mask.getBit(effect:getFlag(), tpz.effectFlag.WALTZABLE) and effectCount < 10) then
            effectCount = effectCount + 1
        end
    end
    mob:delStatusEffectsByFlag(tpz.effectFlag.WALTZABLE, false)

    skill:setMsg(tpz.msg.basic.SELF_HEAL)
    return MobHealMove(mob, statusHeal * effectCount + baseHeal)
end
