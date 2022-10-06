-----------------------------------------
-- Spell: Terror Touch
-- Additional effect: Weakens attacks. Accuracy varies with TP
-- Spell cost: 62 MP
-- Monster Type: Undead
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 3
-- Stat Bonus: HP-5 MP+10
-- Level: 40
-- Casting Time: 3.25 seconds
-- Recast Time: 21 seconds
-- Duration: 60~ seconds
-- Skillchain Element(s): Dark (Primary) and Water (Secondary) - (can open Transfixion, Detonation, Impaction, or Induration can close Compression, Reverberation, or Gravitation)
-- Combos: Defense Bonus
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local params = {}
    params.eco = ECO_UNDEAD
    params.attackType = tpz.attackType.PHYSICAL
    params.damageType = tpz.damageType.H2H
    params.scattr = SC_COMPRESSION
    params.spellLevel = 40
    params.numhits = 1
    params.multiplier = 3
    params.tp150 = 3
    params.tp300 = 3
    params.azuretp = 3
    params.duppercap = 41
    params.str_wsc = 0.0
    params.dex_wsc = 0.2
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.2
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    params.bonusacc = caster:hasStatusEffect(tpz.effect.AZURE_LORE) and 70 or (caster:hasStatusEffect(tpz.effect.CHAIN_AFFINITY) and math.floor(caster:getTP()/50) or nil)
    local damage = 0
    local hitslanded = 0
    local taChar = nil
    damage, hitslanded, taChar = BluePhysicalSpell(caster, target, spell, params)
    if hitslanded == 0 then return 0 end
    damage = BlueFinalAdjustments(caster, target, spell, damage, params, taChar)

    params = {}
    params.eco = ECO_UNDEAD
    params.diff = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = 0
    params.effect = nil
    local resist = applyResistanceEffect(caster, target, spell, params)

    if resist >= 0.5 and not target:hasStatusEffect(tpz.effect.ATTACK_DOWN) then
        target:addStatusEffect(tpz.effect.ATTACK_DOWN, 15, 0, 30*resist)
    end

    return damage
end
