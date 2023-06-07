---------------------------------------------
-- Divine Favor
-- Family: Cait Sith
-- Type: Full Erase
-- Range: Self
-- Notes: Erases all negative effects on the mob
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
    local effectCount = 0

    for i, effect in ipairs(mob:getStatusEffects()) do
        -- check mask bit for tpz.effectFlag.DISPELABLE
        if bit.band(effect:getFlag(), tpz.effectFlag.WALTZABLE) == tpz.effectFlag.WALTZABLE or
            bit.band(effect:getFlag(), tpz.effectFlag.ERASABLE) == tpz.effectFlag.ERASABLE then
                effectCount = effectCount + 1
        end
    end
    mob:delStatusEffectsByFlag(tpz.effectFlag.WALTZABLE, false)
    mob:delStatusEffectsByFlag(tpz.effectFlag.ERASABLE, false)  -- don't think this is necessary, but look for both types just in case

    skill:setMsg(tpz.msg.basic.NONE)
    if effectCount == 0 then
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
    end
    return effectCount
end
