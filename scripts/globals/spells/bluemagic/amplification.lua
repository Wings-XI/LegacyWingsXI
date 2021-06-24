-----------------------------------------
-- Spell: Amplification
-- Enhances magic attack and magic defense
-- Spell cost: 48 MP
-- Monster Type: Amorphs
-- Spell Type: Magical (Water)
-- Blue Magic Points: 3
-- Stat Bonus: HP-5, MP+5
-- Level: 70
-- Casting Time: 7 seconds
-- Recast Time: 120 seconds
-- Duration: 90 seconds
--
-- Combos: None
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
    local duration = 90

    if caster:hasStatusEffect(tpz.effect.DIFFUSION) then
        duration = duration + duration * caster:getMerit(tpz.merit.DIFFUSION) / 100
        caster:delStatusEffect(tpz.effect.DIFFUSION)
    end
    
    local attackSuccess = target:addStatusEffect(tpz.effect.MAGIC_ATK_BOOST, 10, 0, duration)
    local defenseSuccess = target:addStatusEffect(tpz.effect.MAGIC_DEF_BOOST, 10, 0, duration)
    
    if attackSuccess == false and defenseSuccess == false then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return tpz.effect.MAGIC_ATK_BOOST
    elseif attackSuccess == false then
        spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)
        return tpz.effect.MAGIC_DEF_BOOST
    else
        spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)
        return tpz.effect.MAGIC_ATK_BOOST
    end
end
