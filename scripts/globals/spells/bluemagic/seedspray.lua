-----------------------------------------
-- Spell: Seedspray
-- Delivers a threefold attack. Additional effect: Weakens defense. Chance of effect varies with TP
-- Spell cost: 61 MP
-- Monster Type: Plantoids
-- Spell Type: Physical (Slashing)
-- Blue Magic Points: 2
-- Stat Bonus: VIT+1
-- Level: 61
-- Casting Time: 4 seconds
-- Recast Time: 35 seconds
-- Skillchain Element(s): Ice (Primary) and Wind (Secondary) - (can open Impaction, Compression, Fragmentation, Scission or Gravitation can close Induration or Detonation)
-- Combos: Beast Killer
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
    params.eco = ECO_PLANTOID
    params.attackType = tpz.attackType.PHYSICAL -- wiki: despite the 11 yalm range, it's still considered melee
    params.damageType = tpz.damageType.SLASHING
    params.scattr = SC_GRAVITATION
    params.numhits = 3
    params.multiplier = 3.2
    params.tp150 = 3.2
    params.tp300 = 3.2
    params.azuretp = 3.2
    params.duppercap = 61
    params.str_wsc = 0.0
    params.dex_wsc = 0.30
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 2.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    local damage = 0
    local hitslanded = 0
    local taChar = nil
    damage, hitslanded, taChar = BluePhysicalSpell(caster, target, spell, params)
    if hitslanded == 0 then return 0 end
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    params = {}
    params.eco = ECO_PLANTOID
    params.diff = caster:getStat(tpz.mod.DEX) - target:getStat(tpz.mod.AGI)
    params.attribute = tpz.mod.DEX
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = caster:hasStatusEffect(tpz.effect.AZURE_LORE) and 70 or (caster:hasStatusEffect(tpz.effect.CHAIN_AFFINITY) and math.floor(caster:getTP()/50) or 0)
    params.effect = nil
    local resist = applyResistanceEffect(caster, target, spell, params)

    if resist >= 0.5 and not target:hasStatusEffect(tpz.effect.DEFENSE_DOWN) then
        target:addStatusEffect(tpz.effect.DEFENSE_DOWN, 8, 0, 30*resist)
    end

    return damage
end
