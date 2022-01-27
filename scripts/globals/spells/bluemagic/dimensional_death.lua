-----------------------------------------
-- Spell: Dimensional Death
-- Damage varies with TP
-- Spell cost: 48 MP
-- Monster Type: Undead
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 5
-- Stat Bonus: DEX+1, CHR+1, HP+5
-- Level: 60
-- Casting Time: 0.5 seconds
-- Recast Time: 23.75 seconds
-- Skillchain Properties: Impaction (can open Liquefaction or Detonation can close Impaction or Fusion)
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
    params.eco = ECO_UNDEAD
    params.attackType = tpz.attackType.PHYSICAL
    params.damageType = tpz.damageType.BLUNT
    params.scattr = SC_IMPACTION
    params.spellLevel = 60
    params.numhits = 1
    params.multiplier = 2.25
    params.tp150 = 2.25
    params.tp300 = 2.25
    params.azuretp = 2.25
    params.att0 = 1.0
    params.att150 = 1.5
    params.att300 = 2.0
    params.azureatt = 2.25
    params.duppercap = 70
    params.str_wsc = 0.5
    params.dex_wsc = 0.0
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
