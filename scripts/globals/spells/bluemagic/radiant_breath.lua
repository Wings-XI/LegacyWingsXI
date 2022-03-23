-----------------------------------------
-- Spell: Radiant Breath
-- Deals light damage to enemies within a fan-shaped area of effect originating from the caster. Additional effect: Slow and Silence.
-- Spell cost: 116 MP
-- Monster Type: Wyverns
-- Spell Type: Magical (Light)
-- Blue Magic Points: 4
-- Stat Bonus: CHR+1, HP+5
-- Level: 54
-- Casting Time: 5.25 seconds
-- Recast Time: 33.75 seconds
-- Magic Bursts on: Transfixion, Fusion, Light
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
    local BLUlvl = caster:getMainJob() == tpz.job.BLU and caster:getMainLvl() or caster:getSubLvl()
    local params = {}
    params.eco = ECO_DRAGON
    params.attackType = tpz.attackType.BREATH
    params.damageType = tpz.damageType.LIGHT
    params.multiplier = caster:hasStatusEffect(tpz.effect.AZURE_LORE) and 1.25 or 1
    params.tMultiplier = 1.5
    params.D = caster:getHP()/5 + BLUlvl/0.75
    params.duppercap = 2000
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = caster:getStatusEffect(tpz.effect.CONVERGENCE) == nil and 0 or (caster:getStatusEffect(tpz.effect.CONVERGENCE)):getPower()
    
    local damage = BlueMagicalSpell(caster, target, spell, params, nil)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    params.bonus = params.bonus + caster:getMerit(tpz.merit.MAGICAL_ACCURACY)
    params.diff = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.effect = tpz.effect.SLOW
    local resistSlow = applyResistanceEffect(caster, target, spell, params)
    params.effect = tpz.effect.SILENCE
    local resistSilence = applyResistanceEffect(caster, target, spell, params)
    
    
    local slowDuration = math.ceil(90 * tryBuildResistance(tpz.mod.RESBUILD_SLOW, target))
    local silenceDuration = math.ceil(90 * tryBuildResistance(tpz.mod.RESBUILD_SILENCE, target))
    
    if target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.SLOWRES) < 100 then
        if resistSlow >= 0.5 and not target:hasStatusEffect(tpz.effect.SLOW) then
            local cMND = caster:getStat(tpz.mod.MND)
            local tMND = target:getStat(tpz.mod.MND)
            local power = 1800
            
            if cMND < tMND then
                power = power - (tMND - cMND)*50
                if power < 300 then power = 300 end
            end
            
            target:addStatusEffect(tpz.effect.SLOW, power, 0, slowDuration*resistSlow)
        end
    end

    if target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.SILENCERES) < 100 then
        if resistSilence >= 0.5 and not target:hasStatusEffect(tpz.effect.SILENCE) then
            target:addStatusEffect(tpz.effect.SILENCE, 25, 0, silenceDuration*resistSilence)
        end
    end

    return damage
end
