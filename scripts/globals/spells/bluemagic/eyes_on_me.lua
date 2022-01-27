-----------------------------------------
-- Spell: Eyes On Me
-- Deals dark damage to an enemy
-- Spell cost: 112 MP
-- Monster Type: Demons
-- Spell Type: Magical (Dark)
-- Blue Magic Points: 4
-- Stat Bonus: HP-5, MP+15
-- Level: 61
-- Casting Time: 4.5 seconds
-- Recast Time: 29.25 seconds
-- Magic Bursts on: Compression, Gravitation, Darkness
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
    params.eco = ECO_DEMON
    params.attackType = tpz.attackType.MAGICAL
    params.damageType = tpz.damageType.DARK
    params.multiplier = caster:hasStatusEffect(tpz.effect.AZURE_LORE) and 2.625 or 2.625
    params.tMultiplier = 1.5
    params.duppercap = 69
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.4
    local damage = BlueMagicalSpell(caster, target, spell, params, CHR_BASED)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    return damage
end
