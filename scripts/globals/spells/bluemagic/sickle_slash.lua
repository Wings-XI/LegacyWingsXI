-----------------------------------------
-- Spell: Sickle Slash
-- Deals critical damage. Chance of critical hit varies with TP
-- Spell cost: 41 MP
-- Monster Type: Vermin
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 4
-- Stat Bonus: HP-5, MP+15
-- Level: 48
-- Casting Time: 0.5 seconds
-- Recast Time: 20.5 seconds
-- Skillchain Element: Dark (can open Transfixion or Detonation can close Compression or Gravitation)
-- Combos: Store TP
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
    params.damageType = tpz.damageType.H2H
    params.scattr = SC_COMPRESSION
    params.spellLevel = 48
    params.numhits = 1
    params.multiplier = 1.5
    params.tp150 = 1.5
    params.tp300 = 1.5
    params.azuretp = 1.5
    params.duppercap = 49
    params.str_wsc = 0.0
    params.dex_wsc = 0.5
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
