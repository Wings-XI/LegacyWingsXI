-----------------------------------------
-- Spell: Warm-Up
-- Enhances accuracy and evasion
-- Spell cost: 59 MP
-- Monster Type: Beastmen
-- Spell Type: Magical (Earth)
-- Blue Magic Points: 4
-- Stat Bonus: VIT+1
-- Level: 68
-- Casting Time: 7 seconds
-- Recast Time: 120 seconds
-- Duration: 180 seconds
--
-- Combos: Clear Mind
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
    local duration = 180

    if caster:hasStatusEffect(tpz.effect.DIFFUSION) then
        duration = duration + duration * caster:getMerit(tpz.merit.DIFFUSION) / 100
        caster:delStatusEffect(tpz.effect.DIFFUSION)
    end
    
    local accuracySuccess = target:addStatusEffect(tpz.effect.ACCURACY_BOOST, 10, 0, duration)
    local evasionSuccess = target:addStatusEffect(tpz.effect.EVASION_BOOST, 10, 0, duration)

    if accuracySuccess == false and evasionSuccess == false then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return tpz.effect.ACCURACY_BOOST
    elseif accuracySuccess == false then
        spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)
        return tpz.effect.EVASION_BOOST
    else
        spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)
        return tpz.effect.ACCURACY_BOOST
    end
end
