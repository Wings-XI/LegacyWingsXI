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
    local multi = 1.08
    if caster:hasStatusEffect(tpz.effect.AZURE_LORE) then
        multi = multi + 0.50
    end
    
    local params = {}
    params.eco = ECO_UNDEAD
    params.attackType = tpz.attackType.BREATH
    params.damageType = tpz.damageType.WATER
    params.diff = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = 0
    params.multiplier = multi
    params.tMultiplier = 1.5
    params.duppercap = 69
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.3
    params.chr_wsc = 0.0
    params.effect = tpz.effect.POISON
    local resist = applyResistanceEffect(caster, target, spell, params)
    local duration = math.ceil(60 * tryBuildResistance(tpz.mod.RESBUILD_POISON, target))
    
    local HP = caster:getHP()
    local LVL = caster:getMainLvl()
    local damage = (HP / 10) + (LVL / 1.25) -- todo for all breaths!!!!
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    if resist >= 0.5 and not target:hasStatusEffect(tpz.effect.POISON) then
        local BLUlvl = caster:getMainLvl()
        if caster:getMainJob() ~= tpz.job.BLU then BLUlvl = caster:getSubLvl() end
        local power = 3 + math.floor(BLUlvl/15)
        target:addStatusEffect(tpz.effect.POISON, power, 0, duration*resist)
    end

    return damage
end
