-----------------------------------------
-- Spell: Foot Kick
-- Deals critical damage. Chance of critical hit varies with TP
-- Spell cost: 5 MP
-- Monster Type: Beasts
-- Spell Type: Physical (Slashing)
-- Blue Magic Points: 2
-- Stat Bonus: AGI+1
-- Level: 1
-- Casting Time: 0.5 seconds
-- Recast Time: 6.5 seconds
-- Skillchain Property: Detonation (can open Scission or Gravitation)
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
    params.scattr = SC_DETONATION
    params.spellLevel = 1
    params.numhits = 1
    params.multiplier = 1.0
    params.tp150 = 1.0
    params.tp300 = 1.0
    params.azuretp = 1.0
    params.duppercap = 9
    params.str_wsc = 0.1
    params.dex_wsc = 0.1
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    params.critchance = caster:hasStatusEffect(tpz.effect.AZURE_LORE) and 55 or (caster:hasStatusEffect(tpz.effect.CHAIN_AFFINITY) and math.floor(caster:getTP()/75)+8 or 8)
    local damage = 0
    local hitslanded = 0
    local taChar = nil
    damage, hitslanded, taChar = BluePhysicalSpell(caster, target, spell, params)
    if hitslanded == 0 then return 0 end
    damage = BlueFinalAdjustments(caster, target, spell, damage, params, taChar)

    return damage
end
