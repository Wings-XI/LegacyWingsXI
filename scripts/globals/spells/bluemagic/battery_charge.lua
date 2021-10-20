-----------------------------------------
-- Spell: Battery Charge
-- Gradually restores MP
-- Spell cost: 50 MP
-- Monster Type: Arcana
-- Spell Type: Magical (Light)
-- Blue Magic Points: 3
-- Stat Bonus: MP+10, MND+1
-- Level: 79
-- Casting Time: 5 seconds
-- Recast Time: 75 seconds
-- Spell Duration: 100 ticks, 300 Seconds (5 Minutes)
--
-- Combos: None
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local duration = 300

    if caster:hasStatusEffect(tpz.effect.DIFFUSION) then
        duration = duration + duration * caster:getMeritCount(tpz.merit.DIFFUSION) / 100
        caster:delStatusEffect(tpz.effect.DIFFUSION)
    end

    if target:hasStatusEffect(tpz.effect.REFRESH) then
        target:delStatusEffect(tpz.effect.REFRESH)
    end

    if target:addStatusEffect(tpz.effect.REFRESH, 3, 3, duration) == false then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    return tpz.effect.REFRESH
end
