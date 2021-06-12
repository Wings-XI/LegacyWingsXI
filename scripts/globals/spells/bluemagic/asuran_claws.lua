-----------------------------------------
-- Spell: Asuran Claws
-- Delivers a sixfold attack. Accuracy varies with TP
-- Spell cost: 81 MP
-- Monster Type: Beasts
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 2
-- Stat Bonus: AGI +3
-- Level: 70
-- Casting Time: 3 seconds
-- Recast Time: 60 seconds
-- Skillchain Element(s): Fire (Primary) and Lightning (Secondary) - (can open Scission, Detonation, Liquefaction, or Fusion can close Liquefaction, Impaction, or Fusion)
-- Combos: Counter
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
    params.tpmod = TPMOD_ACC
    params.attackType = tpz.attackType.PHYSICAL
    params.damageType = tpz.damageType.HTH
    params.scattr = SC_IMPACTION
    params.numhits = 6
    params.multiplier = 1.0
    params.tp150 = 1.05
    params.tp300 = 1.1
    params.azuretp = 1.2
    params.duppercap = 21
    params.str_wsc = 0.3
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
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    return damage
end
