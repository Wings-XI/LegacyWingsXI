-----------------------------------------
-- Spell: Hecatomb Wave
-- Deals wind damage to enemies within a fan-shaped area originating from the caster. Additional effect: Blindness
-- Spell cost: 116 MP
-- Monster Type: Demons
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 3
-- Stat Bonus: AGI+1
-- Level: 54
-- Casting Time: 5.25 seconds
-- Recast Time: 33.75 seconds
-- Magic Bursts on: Detonation, Fragmentation, Light
-- Combos: Max MP Boost
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
    params.eco = ECO_DEMON
    params.attackType = tpz.attackType.BREATH
    params.damageType = tpz.damageType.WIND
    params.multiplier = caster:hasStatusEffect(tpz.effect.AZURE_LORE) and 1.25 or 1
    params.tMultiplier = 1.0
    params.D = caster:getHP()/4 + BLUlvl/1.5
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
    params.eco = ECO_DEMON
    params.diff = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = caster:getStatusEffect(tpz.effect.CONVERGENCE) == nil and 0 or (caster:getStatusEffect(tpz.effect.CONVERGENCE)):getPower()
    params.effect = tpz.effect.BLINDNESS
    local resist = applyResistanceEffect(caster, target, spell, params)
    
    if target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.BLINDRES) < 100 then
        local duration = math.ceil(90 * tryBuildResistance(tpz.mod.RESBUILD_BLIND, target))
        if resist >= 0.5 and not target:hasStatusEffect(tpz.effect.BLINDNESS) then
            target:addStatusEffect(tpz.effect.BLINDNESS, 25, 0, duration*resist)
        end
    end

    return damage
end
