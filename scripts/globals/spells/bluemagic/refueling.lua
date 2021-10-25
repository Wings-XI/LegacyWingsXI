-----------------------------------------
-- Spell: Refueling
-- Increases attack speed
-- Spell cost: 29 MP
-- Monster Type: Arcana
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 4
-- Stat Bonus: AGI+2
-- Level: 48
-- Casting Time: 1.5 seconds
-- Recast Time: 30 seconds
-- Duration: 5 minutes
--
-- Combos: None
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local duration = 300

    if caster:hasStatusEffect(tpz.effect.DIFFUSION) then
        --duration = duration + duration * caster:getMeritCount(tpz.merit.DIFFUSION) / 100 -- OOE Buff from May 16, 2012 update
        caster:delStatusEffect(tpz.effect.DIFFUSION)
    end

    if not target:addStatusEffect(tpz.effect.HASTE, 1000, 0, duration) then -- 10%
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    return tpz.effect.HASTE
end
