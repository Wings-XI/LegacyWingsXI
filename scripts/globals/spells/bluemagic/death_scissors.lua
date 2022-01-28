-----------------------------------------
-- Spell: Death Scissors
-- Damage varies with TP
-- Spell cost: 51 MP
-- Monster Type: Vermin
-- Spell Type: Physical (Slashing)
-- Blue Magic Points: 5
-- Stat Bonus: MND+2, CHR+2, HP+5
-- Level: 60
-- Casting Time: 0.5 seconds
-- Recast Time: 24.5 seconds
-- Skillchain Properties: Compression(Primary)/Reverberation(Secondary) - (can open Transfixion, Detonation, Impaction, or Induration can close Compression, Reverberation, or Gravitation)
-- Combos: Attack Bonus
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
    params.eco = ECO_VERMIN
    params.attackType = tpz.attackType.PHYSICAL
    params.damageType = tpz.damageType.SLASHING
    params.scattr = SC_COMPRESSION
    params.spellLevel = 60
    params.numhits = 1
    params.multiplier = 1.5
    params.tp150 = 2.75
    params.tp300 = 3.25
    params.azuretp = 3.3
    params.duppercap = 74
    params.str_wsc = 0.6
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
