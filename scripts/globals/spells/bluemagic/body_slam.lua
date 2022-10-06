-----------------------------------------
-- Spell: Body Slam
-- Delivers an area attack. Damage varies with TP
-- Spell cost: 74 MP
-- Monster Type: Dragon
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 4
-- Stat Bonus: VIT+1, MP+5
-- Level: 62
-- Casting Time: 1 seconds
-- Recast Time: 27.75 seconds
-- Skillchain Element(s): Lightning (can open Liquefaction or Detonation can close Impaction or Fusion)
-- Combos: Max HP Boost
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
    params.eco = ECO_DRAGON
    params.attackType = tpz.attackType.PHYSICAL
    params.damageType = tpz.damageType.BLUNT
    params.scattr = SC_IMPACTION
    params.spellLevel = 62
    params.numhits = 1
    params.multiplier = 4.0
    params.tp150 = 4.5
    params.tp300 = 5.0
    params.azuretp = 5.25
    params.duppercap = 75
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.4
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
