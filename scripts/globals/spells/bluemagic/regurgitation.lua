-----------------------------------------
-- Spell: Regurgitation
-- Deals Water damage to an enemy. Additional Effect: Bind
-- Spell cost: 69 MP
-- Monster Type: Lizards
-- Spell Type: Magical (Water)
-- Blue Magic Points: 1
-- Stat Bonus: INT+1 MND+1 MP+3
-- Level: 68
-- Casting Time: 5 seconds
-- Recast Time: 24 seconds
-- Magic Bursts on: Reverberation, Distortion, and Darkness
-- Combos: Resist Gravity
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
    params.eco = ECO_LIZARD
    params.attackType = tpz.attackType.MAGICAL
    params.damageType = tpz.damageType.WATER
    params.multiplier = caster:hasStatusEffect(tpz.effect.AZURE_LORE) and 4 or 3
    params.tMultiplier = 2.0
    params.duppercap = 69
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.30
    params.chr_wsc = 0.0
    params.enmityPercent = 10
    local damage = BlueMagicalSpell(caster, target, spell, params, INT_BASED)
    if caster:isBehind(target, 20) then damage = math.floor(damage * 1.25) end
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)
    
    local params = {}
    params.diff = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = caster:getStatusEffect(tpz.effect.CONVERGENCE) == nil and 0 or (caster:getStatusEffect(tpz.effect.CONVERGENCE)):getPower()
    params.bonus = params.bonus + caster:getMerit(tpz.merit.MAGICAL_ACCURACY)
    params.effect = tpz.effect.BIND

    local resist = applyResistanceEffect(caster, target, spell, params)
    local duration = math.ceil(45 * tryBuildResistance(tpz.mod.RESBUILD_BIND, target))
    if target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.BINDRES) < 100 then
        if resist >= 0.5 then
            target:delStatusEffect(tpz.effect.BIND)
            target:addStatusEffect(tpz.effect.BIND, 1, 0, duration*resist)
        end
    end

    return damage
end
