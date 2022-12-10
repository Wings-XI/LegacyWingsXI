---------------------------------------------
-- Exuviation
-- Family: Wamoura
-- Type: Healing and Full Erase
-- Range: Self
-- Notes: Erases all negative effects on the mob and heals an amount for each removed.
-- eraseAllStatusEffects() doesn't work that well.
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


    if mob:hasStatusEffect(tpz.effect.SILENCE) == true then
        mob:delStatusEffect(tpz.effect.SILENCE)
        effectCount = effectCount + 1
    end

    if mob:hasStatusEffect(tpz.effect.BIND) == true then
        mob:delStatusEffect(tpz.effect.BIND)
        effectCount = effectCount + 1
    end

    if mob:hasStatusEffect(tpz.effect.WEIGHT) == true then
        mob:delStatusEffect(tpz.effect.WEIGHT)
        effectCount = effectCount + 1
    end

    if mob:hasStatusEffect(tpz.effect.PARALYSIS) == true then
        mob:delStatusEffect(tpz.effect.PARALYSIS)
        effectCount = effectCount + 1
    end

    if mob:hasStatusEffect(tpz.effect.BLINDNESS) == true then
        mob:delStatusEffect(tpz.effect.BLINDNESS)
        effectCount = effectCount + 1
    end

    if mob:hasStatusEffect(tpz.effect.ELEGY) == true then
        mob:delStatusEffect(tpz.effect.ELEGY)
        effectCount = effectCount + 1
    end

    if mob:hasStatusEffect(tpz.effect.SLOW) == true then
        mob:delStatusEffect(tpz.effect.SLOW)
        effectCount = effectCount + 1
    end

    if mob:hasStatusEffect(tpz.effect.BIO) == true then
        mob:delStatusEffect(tpz.effect.BIO)
        effectCount = effectCount + 1
    end

    if mob:hasStatusEffect(tpz.effect.DIA) == true then
        mob:delStatusEffect(tpz.effect.DIA)
        effectCount = effectCount + 1
    end

    if mob:hasStatusEffect(tpz.effect.POISON) == true then
        mob:delStatusEffect(tpz.effect.POISON)
        effectCount = effectCount + 1
    end

    if mob:hasStatusEffect(tpz.effect.ACCURACY_DOWN) == true then
        mob:delStatusEffect(tpz.effect.ACCURACY_DOWN)
        effectCount = effectCount + 1
    end

    if mob:hasStatusEffect(tpz.effect.ATTACK_DOWN) == true then
        mob:delStatusEffect(tpz.effect.ATTACK_DOWN)
        effectCount = effectCount + 1
    end

    if mob:hasStatusEffect(tpz.effect.EVASION_DOWN) == true then
        mob:delStatusEffect(tpz.effect.EVASION_DOWN)
        effectCount = effectCount + 1
    end

    if mob:hasStatusEffect(tpz.effect.DEFENSE_DOWN) == true then
        mob:delStatusEffect(tpz.effect.DEFENSE_DOWN)
        effectCount = effectCount + 1
    end

    skill:setMsg(tpz.msg.basic.SELF_HEAL)
    return MobHealMove(mob, statusHeal * effectCount + baseHeal)
end
