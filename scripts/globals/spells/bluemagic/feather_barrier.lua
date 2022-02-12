-----------------------------------------
-- Spell: Feather Barrier
-- Enhances evasion
-- Spell cost: 29 MP
-- Monster Type: Birds
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 2
-- Stat Bonus: None
-- Level: 56
-- Casting Time: 2 seconds
-- Recast Time: 120 seconds
-- Duration: 30 Seconds
--
-- Combos: Resist Gravity
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local duration = 30

    if caster:hasStatusEffect(tpz.effect.DIFFUSION) then
        --duration = duration + duration * caster:getMeritCount(tpz.merit.DIFFUSION)/100 -- OOE Buff from May 16, 2012 update
        caster:delStatusEffect(tpz.effect.DIFFUSION)
    end
    -- per bgwiki and wikiwiki.jp 25 eva boost, 30s
    if target:addStatusEffect(tpz.effect.EVASION_BOOST, 25, 0, duration) == false then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    return tpz.effect.EVASION_BOOST
end
