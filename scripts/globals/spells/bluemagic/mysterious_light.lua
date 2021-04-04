-----------------------------------------
-- Spell: Mysterious Light
-- Deals wind damage to enemies within range. Additional effect: Weight
-- Spell cost: 73 MP
-- Monster Type: Arcana
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 4
-- Stat Bonus: AGI+3
-- Level: 40
-- Casting Time: 3.75 seconds
-- Recast Time: 24.5 seconds
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
    local params = {}
    params.attackType = tpz.attackType.MAGICAL
    params.damageType = tpz.damageType.WIND
    params.diff = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = 1.0
    -- This data should match information on https://www.bg-wiki.com/bg/Calculating_Blue_Magic_Damage
    params.multiplier = 2.0
    params.tMultiplier = 1.0
    params.duppercap = 56
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.3

    local resist = applyResistance(caster, target, spell, params)
    local damage = BlueMagicalSpell(caster, target, spell, params, CHR_BASED)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)
    
    local duration = math.ceil(getBlueEffectDuration(caster, resist, typeEffect) * tryBuildResistance(tpz.mod.RESBUILD_GRAVITY, target))
    if damage > 0 and resist >= 0.5 then
        local typeEffect = tpz.effect.WEIGHT
        target:delStatusEffect(typeEffect)
        -- https://www.bg-wiki.com/ffxi/Mysterious_Light   26%
        target:addStatusEffect(typeEffect, 26, 0, duration)
    end

    return damage
end
