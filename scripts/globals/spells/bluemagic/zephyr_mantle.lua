-----------------------------------------
-- Spell: Zephyr Mantle
-- Creates shadow images that each absorb a single attack directed at you
-- Spell cost: 31 MP
-- Monster Type: Dragons
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 2
-- Stat Bonus: AGI+2
-- Level: 65
-- Casting Time: 7 seconds
-- Recast Time: 60 seconds
-- Duration: 5 minutes
--
-- Combos: Conserve MP
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local power = 4
    local duration = 300
    
    if caster:hasStatusEffect(tpz.effect.DIFFUSION) then
        --duration = duration + duration * caster:getMeritCount(tpz.merit.DIFFUSION) / 100 -- OOE Buff from May 16, 2012 update
        caster:delStatusEffect(tpz.effect.DIFFUSION)
    end
    
    if target:addStatusEffect(tpz.effect.BLINK, power, 0, duration) == false then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end
    
    return tpz.effect.BLINK
end
