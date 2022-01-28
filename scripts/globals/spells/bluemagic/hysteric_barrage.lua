-----------------------------------------
-- Spell: Hysteric Barrage
-- Delivers a fivefold attack. Damage varies with TP
-- Spell cost: 61 MP
-- Monster Type: Beastmen
-- Spell Type: Physical (Hand-to-Hand)
-- Blue Magic Points: 5
-- Stat Bonus: DEX+2, AGI+1
-- Level: 69
-- Casting Time: 0.5 seconds
-- Recast Time: 28.5 seconds
-- Skillchain Element: Wind (can open Scission or Gravitation can close Detonation)
-- Combos: Evasion Bonus
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
    params.eco = ECO_NONE
    params.attackType = tpz.attackType.PHYSICAL
    params.damageType = tpz.damageType.H2H
    params.scattr = SC_DETONATION
    params.spellLevel = 69
    params.numhits = 5
    params.multiplier = 1.25
    params.tp150 = 1.625
    params.tp300 = 1.75
    params.azuretp = 1.875
    params.att0 = 0.9
    params.att150 = 0.9
    params.att300 = 0.9
    params.azureatt = 0.9
    params.duppercap = 80
    params.str_wsc = 0.0
    params.dex_wsc = 0.3
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
