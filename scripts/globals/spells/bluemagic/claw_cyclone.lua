-----------------------------------------
-- Spell: Claw Cyclone
-- Damages enemies within area of effect with a twofold attack. Damage varies with TP
-- Spell cost: 24 MP
-- Monster Type: Beasts
-- Spell Type: Physical (Slashing)
-- Blue Magic Points: 2
-- Stat Bonus: VIT+1
-- Level: 20
-- Casting Time: 1 seconds
-- Recast Time: 19.75 seconds
-- Skillchain Element(s): Earth (can open Liquefaction, Detonation, or Reverberation can close Scission or Distortion)
-- Combos: Lizard Killer
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
    params.attackType = tpz.attackType.PHYSICAL
    params.damageType = tpz.damageType.SLASHING
    params.scattr = SC_SCISSION
    params.spellLevel = 20
    params.numhits = 2
    params.multiplier = 1.4375
    params.tp150 = 1.4375
    params.tp300 = 1.4375
    params.azuretp = 1.4375
    params.att0 = 1.0
    params.att150 = 1.5
    params.att300 = 2.0
    params.azureatt = 2.2
    params.duppercap = 23
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
