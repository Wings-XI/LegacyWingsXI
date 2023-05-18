---------------------------------------------
-- Pyric Bulwark
--
-- Description: Grants a Magic Shield effect for a time.
-- Type: Enhancing
--
-- Range: Self
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    --Used only if all 3 heads are alive
    if (mob:AnimationSub() == 0) then
        return 0
    else
        return 1
    end
end

function onMobWeaponSkill(target, mob, skill)
    local effectType = tpz.effect.PHYSICAL_SHIELD
    mob:delStatusEffectSilent(tpz.effect.PHYSICAL_SHIELD)
    mob:delStatusEffectSilent(tpz.effect.MAGIC_SHIELD)
    mob:addStatusEffect(effectType, 0, 1, 40, 0)
    mob:getStatusEffect(effectType):unsetFlag(tpz.effectFlag.DISPELABLE) -- Cannot be dispelled
    skill:setMsg(tpz.msg.basic.SKILL_GAIN_EFFECT)
    if (mob:getFamily() == 313) then -- Tinnin follows this up immediately with Nerve Gas
        mob:useMobAbility(1836)
    end

    return effectType
end
