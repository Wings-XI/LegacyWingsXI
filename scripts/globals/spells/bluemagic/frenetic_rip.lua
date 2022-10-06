-----------------------------------------
-- Spell: Frenetic Rip
-- Delivers a threefold attack. Damage varies with TP
-- Spell cost: 61 MP
-- Monster Type: Demon
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 3
-- Stat Bonus: INT+1
-- Level: 63
-- Casting Time: 0.5 seconds
-- Recast Time: 28.5 seconds
-- Skillchain Element: Ice (can open Impaction, Compression, or Fragmentation can close Induration)
-- Combos: Accuracy Bonus
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
    params.attackType = tpz.attackType.PHYSICAL
    params.damageType = tpz.damageType.BLUNT
    params.scattr = SC_INDURATION
    params.spellLevel = 63
    params.numhits = 3
    params.multiplier = 4.0
    params.tp150 = 4.3
    params.tp300 = 4.6
    params.azuretp = 4.7
    params.att0 = 1.5
    params.att150 = 1.5
    params.att300 = 1.5
    params.azureatt = 1.5
    params.duppercap = 75
    params.str_wsc = 0.2
    params.dex_wsc = 0.2
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    local damage = 0
    local hitslanded = 0
    local taChar = nil
    damage, hitslanded, taChar = BluePhysicalSpell(caster, target, spell, params)
    if hitslanded == 0 then return 0 end
    damage = BlueFinalAdjustments(caster, target, spell, damage, params, taChar)

    return damage
end
