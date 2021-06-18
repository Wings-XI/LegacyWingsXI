-----------------------------------------
-- Spell: Ram Charge
-- Damage varies with TP
-- Spell cost: 79 MP
-- Monster Type: Beasts
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 4
-- Stat Bonus: HP+5
-- Level: 73
-- Casting Time: 0.5 seconds
-- Recast Time: 34.75 seconds
-- Skillchain Element(s): Fragmentation (can open/close Light with Fusion WSs and spells)
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
    params.damageType = tpz.damageType.BLUNT
    params.scattr = SC_FRAGMENTATION
    params.spellLevel = 73
    params.numhits = 1
    params.multiplier = 4.0
    params.tp150 = 4.5
    params.tp300 = 5.0
    params.azuretp = 5.16
    params.duppercap = 75
    params.str_wsc = 0.3
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.5
    params.chr_wsc = 0.0
    local damage = 0
    local hitslanded = 0
    local taChar = nil
    damage, hitslanded, taChar = BluePhysicalSpell(caster, target, spell, params)
    if hitslanded == 0 then return 0 end
    damage = BlueFinalAdjustments(caster, target, spell, damage, params, taChar)
    
    return damage
end
