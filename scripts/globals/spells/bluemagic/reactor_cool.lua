-----------------------------------------
-- Spell: Reactor Cool
-- Enhances defense and covers you with magical ice spikes. Enemies that hit you take ice damage
-- Spell cost: 28 MP
-- Monster Type: Luminions
-- Spell Type: Magical (Ice)
-- Blue Magic Points: 5
-- Stat Bonus: INT+3 MND+3
-- Level: 74
-- Casting Time: 3 seconds
-- Recast Time: 60 seconds
-- Duration: 120 seconds (2 minutes)
--
-- Combos: Magic Attack Bonus
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local duration = 120

    if caster:hasStatusEffect(tpz.effect.DIFFUSION) then
        --duration = duration + duration * caster:getMeritCount(tpz.merit.DIFFUSION) / 100 -- OOE Buff from May 16, 2012 update
        caster:delStatusEffect(tpz.effect.DIFFUSION)
    end
    
    local successSpikes = target:addStatusEffect(tpz.effect.ICE_SPIKES, 5, 0, duration)
    local successDefense = target:addStatusEffect(tpz.effect.DEFENSE_BOOST, 12, 0, duration)

    if successSpikes == false and successDefense == false then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return tpz.effect.ICE_SPIKES
    elseif successSpikes == false then
        spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)
        return tpz.effect.DEFENSE_BOOST
    else
        spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)
        return tpz.effect.ICE_SPIKES
    end
end
