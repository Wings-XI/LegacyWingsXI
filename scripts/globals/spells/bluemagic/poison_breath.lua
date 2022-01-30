-----------------------------------------
-- Spell: Poison Breath
-- Deals water damage to enemies within a fan-shaped area originating from the caster. Additional effect: Poison
-- Spell cost: 22 MP
-- Monster Type: Hound
-- Spell Type: Magical (Water)
-- Blue Magic Points: 1
-- Stat Bonus: MND+1
-- Level: 22
-- Casting Time: 3 seconds
-- Recast Time: 19.5 seconds
-- Magic Bursts on: Reverberation, Distortion, and Darkness
-- Combos: Clear Mind
-- Damage formula is (Current HP)/10 + (Blue Mage level)/1.25
-- Gains a 25% damage boost when used against Arcana monsters.
-- Poison effect is 4/tick
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
    params.eco = ECO_UNDEAD
    params.attackType = tpz.attackType.BREATH
    params.damageType = tpz.damageType.WATER
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = caster:getStatusEffect(tpz.effect.CONVERGENCE) == nil and 0 or (caster:getStatusEffect(tpz.effect.CONVERGENCE)):getPower()
    params.multiplier = caster:hasStatusEffect(tpz.effect.AZURE_LORE) and 1.25 or 1
    params.tMultiplier = 1.5
    params.D = caster:getHP()/10 + BLUlvl/1.25
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
    
    params.effect = tpz.effect.POISON
    params.diff = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    local resist = applyResistanceEffect(caster, target, spell, params)
    local duration = math.ceil(60 * tryBuildResistance(tpz.mod.RESBUILD_POISON, target))
    if target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.POISONRES) < 100 then
        if resist >= 0.5 and not target:hasStatusEffect(tpz.effect.POISON) then
            local power = 3 + math.floor(BLUlvl/15)
            target:addStatusEffect(tpz.effect.POISON, power, 0, duration*resist)
        end
    end

    return damage
end
