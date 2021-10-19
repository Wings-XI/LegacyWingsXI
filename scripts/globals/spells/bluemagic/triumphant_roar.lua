-----------------------------------------
-- Spell: Triumphant Roar
-- Enhances Attack
-- Spell cost: 36 MP
-- Monster Type: Demon
-- Spell Type: Magical (Fire)
-- Blue Magic Points: 3
-- Stat Bonus: STR+3
-- Level: 71
-- Casting Time: 3 seconds
-- Recast Time: 90 seconds
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
    local duration = 60

     if caster:hasStatusEffect(tpz.effect.DIFFUSION) then
         --duration = duration + duration * caster:getMeritCount(tpz.merit.DIFFUSION) / 100 -- OOE Buff from May 16, 2012 update
         caster:delStatusEffect(tpz.effect.DIFFUSION)
     end

    if target:addStatusEffect(tpz.effect.ATTACK_BOOST, 15, 1, duration) == false then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    return tpz.effect.ATTACK_BOOST
end
