-----------------------------------------
-- Spell: Sandspin
-- Deals earth damage to enemies within range. Additional Effect: Accuracy Down
-- Spell cost: 10 MP
-- Monster Type: Amorphs
-- Spell Type: Magical (Earth)
-- Blue Magic Points: 2
-- Stat Bonus: VIT+1
-- Level: 1
-- Casting Time: 1.5 seconds
-- Recast Time: 9.75 seconds
-- Magic Bursts on: Scission, Gravitation, Darkness
-- Combos: None
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
    params.eco = ECO_AMORPH
    params.attackType = tpz.attackType.MAGICAL
    params.damageType = tpz.damageType.EARTH
    params.multiplier = caster:hasStatusEffect(tpz.effect.AZURE_LORE) and 1.3 or 0.8
    params.tMultiplier = 0.9
    params.duppercap = 10
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.2
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    local damage = BlueMagicalSpell(caster, target, spell, params, INT_BASED)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    local params = {}
    params.diff = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = caster:getStatusEffect(tpz.effect.CONVERGENCE) == nil and 0 or (caster:getStatusEffect(tpz.effect.CONVERGENCE)):getPower()
    params.effect = nil
    params.bonus = params.bonus + caster:getMerit(tpz.merit.MAGICAL_ACCURACY)
    
    local resist = applyResistanceEffect(caster, target, spell, params)

    if resist >= 0.5 and target:canGainStatusEffect(tpz.effect.ACCURACY_DOWN) then
        -- BG wiki lists acc down effect as -25
        -- Neither Studio Globi nor ffxiwiki have a value
        target:addStatusEffect(tpz.effect.ACCURACY_DOWN, 25, 3, 30*resist)
    end

    return damage
end
