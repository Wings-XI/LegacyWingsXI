-----------------------------------------
-- Spell: Corrosive Ooze
-- Deals water damage to an enemy. Additional Effect: Attack Down and Defense Down
-- Spell cost: 55 MP
-- Monster Type: Amorphs
-- Spell Type: Magical (Water)
-- Blue Magic Points: 4
-- Stat Bonus: HP-10 MP+10
-- Level: 66
-- Casting Time: 5 seconds
-- Recast Time: 30 seconds
--
-- Combos: Clear Mind
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
    params.azuretp = 1.5
    params.attackType = tpz.attackType.MAGICAL
    params.damageType = tpz.damageType.WATER
    params.multiplier = caster:hasStatusEffect(tpz.effect.AZURE_LORE) and 2.125 or 2.125
    params.tMultiplier = 2.0
    params.duppercap = 69
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.2
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    params.enmityPercent = 10
    local damage = BlueMagicalSpell(caster, target, spell, params, INT_BASED)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    params = {}
    params.eco = ECO_AMORPH
    params.diff = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = caster:getStatusEffect(tpz.effect.CONVERGENCE) == nil and 0 or (caster:getStatusEffect(tpz.effect.CONVERGENCE)):getPower()
    params.bonus = params.bonus + caster:getMerit(tpz.merit.MAGICAL_ACCURACY)
    params.effect = nil
    local resistDef = applyResistanceEffect(caster, target, spell, params)
    local resistAtt = applyResistanceEffect(caster, target, spell, params)

    if resistDef >= 0.5 and not target:hasStatusEffect(tpz.effect.DEFENSE_DOWN) then
        target:addStatusEffect(tpz.effect.DEFENSE_DOWN, 5, 0, 60*resistDef)
    end
    
    if resistAtt >= 0.5 and not target:hasStatusEffect(tpz.effect.ATTACK_DOWN) then
        target:addStatusEffect(tpz.effect.ATTACK_DOWN, 5, 0, 60*resistAtt)
    end

    return damage
end
