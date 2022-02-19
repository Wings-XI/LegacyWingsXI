-----------------------------------------
-- Spell: Heat Breath
-- Deals fire damage to enemies within a fan-shaped area originating from the caster
-- Spell cost: 169 MP
-- Monster Type: Beasts
-- Spell Type: Magical (Fire)
-- Blue Magic Points: 4
-- Stat Bonus: STR+3
-- Level: 71
-- Casting Time: 7.5 seconds
-- Recast Time: 49 seconds
-- Magic Bursts on: Liquefaction, Fusion, Light
-- Combos: Magic Attack Bonus
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local params = {}
    params.eco = ECO_BEAST
    params.attackType = tpz.attackType.BREATH
    params.damageType = tpz.damageType.FIRE
    params.multiplier = caster:hasStatusEffect(tpz.effect.AZURE_LORE) and 1.25 or 1
    params.tMultiplier = 1.5
    params.D = caster:getHP()/2
    params.duppercap = 2000
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    params.bonus = caster:getMerit(tpz.merit.MAGICAL_ACCURACY)
    local damage = BlueMagicalSpell(caster, target, spell, params, nil)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    return damage
end
