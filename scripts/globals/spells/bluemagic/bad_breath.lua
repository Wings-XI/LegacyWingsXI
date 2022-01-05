-----------------------------------------
-- Spell: Bad Breath
-- Deals earth damage that inflicts multiple status ailments on enemies within a fan-shaped area originating from the caster
-- Spell cost: 212 MP
-- Monster Type: Plantoids
-- Spell Type: Magical (Earth)
-- Blue Magic Points: 5
-- Stat Bonus: INT+2, MND+2
-- Level: 61
-- Casting Time: 8.75 seconds
-- Recast Time: 120 seconds
-- Magic Bursts on: Scission, Gravitation, Darkness
-- Combos: Fast Cast
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local BLUlvl = caster:getMainJob() == tpz.job.BLU and caster:getMainLvl() or caster:getSubLvl()
    local params = {}
    params.eco = ECO_PLANTOID
    params.attackType = tpz.attackType.BREATH
    params.damageType = tpz.damageType.EARTH
    params.multiplier = caster:hasStatusEffect(tpz.effect.AZURE_LORE) and 1.25 or 1
    params.tMultiplier = 1.5
    params.D = caster:getHP()/8 + BLUlvl/3
    params.duppercap = 2000
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    local damage = BlueMagicalSpell(caster, target, spell, params, nil)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    params = {}
    params.diff = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = caster:getStatusEffect(tpz.effect.CONVERGENCE) == nil and 0 or (caster:getStatusEffect(tpz.effect.CONVERGENCE)):getPower()
    local resist = 1
    local duration = 1

    if target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.PARALYZERES) < 100 then
        params.effect = tpz.effect.PARALYSIS
        resist = applyResistanceEffect(caster, target, spell, params)
        duration = math.ceil(90 * tryBuildResistance(tpz.mod.RESBUILD_PARALYZE, target))
        if resist >= 0.5 and not target:hasStatusEffect(tpz.effect.PARALYSIS) then
            target:addStatusEffect(tpz.effect.PARALYSIS, 25, 0, duration*resist)
        end
    end
    
    if target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.GRAVITYRES) < 100 then
        params.effect = tpz.effect.WEIGHT
        resist = applyResistanceEffect(caster, target, spell, params)
        duration = math.ceil(60 * tryBuildResistance(tpz.mod.RESBUILD_GRAVITY, target))
        if resist >= 0.5 and not target:hasStatusEffect(tpz.effect.WEIGHT) then
            target:addStatusEffect(tpz.effect.WEIGHT, 25, 0, duration*resist)
        end
    end

    if target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.POISONRES) < 100 then
        params.effect = tpz.effect.POISON
        resist = applyResistanceEffect(caster, target, spell, params)
        duration = math.ceil(90 * tryBuildResistance(tpz.mod.RESBUILD_POISON, target))
        if resist >= 0.5 and not target:hasStatusEffect(tpz.effect.POISON) then
            target:addStatusEffect(tpz.effect.POISON, 4, 0, duration*resist)
        end
    end
    
    if target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.SLOWRES) < 100 then
        params.effect = tpz.effect.SLOW
        resist = applyResistanceEffect(caster, target, spell, params)
        duration = math.ceil(60 * tryBuildResistance(tpz.mod.RESBUILD_SLOW, target))
        if resist >= 0.5 and not target:hasStatusEffect(tpz.effect.SLOW) then
            target:addStatusEffect(tpz.effect.SLOW, 2000, 0, duration*resist)
        end
    end

    if target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.SILENCERES) < 100 then
        params.effect = tpz.effect.SILENCE
        resist = applyResistanceEffect(caster, target, spell, params)
        duration = math.ceil(60 * tryBuildResistance(tpz.mod.RESBUILD_SILENCE, target))
        if resist >= 0.5 and not target:hasStatusEffect(tpz.effect.SILENCE) then
            target:addStatusEffect(tpz.effect.SILENCE, 25, 0, duration*resist)
        end
    end
    
    if target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.BINDRES) < 100 then
        params.effect = tpz.effect.BIND
        resist = applyResistanceEffect(caster, target, spell, params)
        duration = math.ceil(60 * tryBuildResistance(tpz.mod.RESBUILD_BIND, target))
        if resist >= 0.5 and not target:hasStatusEffect(tpz.effect.BIND) then
            target:addStatusEffect(tpz.effect.BIND, 1, 0, duration*resist)
        end
    end
    
    if target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.BLINDRES) < 100 then
        params.effect = tpz.effect.BLINDNESS
        resist = applyResistanceEffect(caster, target, spell, params)
        duration = math.ceil(90 * tryBuildResistance(tpz.mod.RESBUILD_BLIND, target))
        if resist >= 0.5 and not target:hasStatusEffect(tpz.effect.BLINDNESS) then
            target:addStatusEffect(tpz.effect.BLINDNESS, 25, 0, duration*resist)
        end
    end

    return damage

end
