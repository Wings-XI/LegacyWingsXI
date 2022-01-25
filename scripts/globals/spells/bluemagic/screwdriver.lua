-----------------------------------------
-- Spell: Screwdriver
-- Deals critical damage. Chance of critical hit varies with TP
-- Spell cost: 21 MP
-- Monster Type: Aquans
-- Spell Type: Physical (Piercing)
-- Blue Magic Points: 3
-- Stat Bonus: VIT+1, CHR+1, HP+10
-- Level: 26
-- Casting Time: 0.5 seconds
-- Recast Time: 14 seconds
-- Skillchain Element(s): Light (Primary) and Earth (Secondary) -- (can open Compression, Reverberation, Detonation, Liquefaction, or Distortion can close Transfixion, Scission, or Distortion)
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
    params.eco = ECO_AQUAN
    params.attackType = tpz.attackType.PHYSICAL
    params.damageType = tpz.damageType.PIERCING
    params.scattr = SC_TRANSFIXION
    params.scattr2 = SC_SCISSION
    params.spellLevel = 26
    params.numhits = 1
    params.multiplier = 1.375
    params.tp150 = 1.375
    params.tp300 = 1.375
    params.azuretp = 1.375
    params.duppercap = 27
    params.str_wsc = 0.2
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.2
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
