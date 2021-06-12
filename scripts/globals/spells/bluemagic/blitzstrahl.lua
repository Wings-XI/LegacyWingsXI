-----------------------------------------
-- Spell: Blitzstrahl
-- Deals lightning damage to an enemy. Additional effect: "Stun"
-- Spell cost: 70 MP
-- Monster Type: Arcana
-- Spell Type: Magical (Lightning)
-- Blue Magic Points: 4
-- Stat Bonus: DEX+3
-- Level: 44
-- Casting Time: 4.5 seconds
-- Recast Time: 29.25 seconds
-- Magic Bursts on: Impaction, Fragmentation, Light
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
    params.eco = ECO_ARCANA
    params.attackType = tpz.damageType.MAGICAL
    params.damageType = tpz.damageType.LIGHTNING
    params.multiplier = 1.5625
    params.tMultiplier = 1.0
    params.duppercap = 61
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.3
    params.mnd_wsc = 0.1
    params.chr_wsc = 0.0
    local damage = BlueMagicalSpell(caster, target, spell, params, INT_BASED)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    params = {}
    params.diff = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = 1
    params.effect = tpz.effect.STUN
    local resist = applyResistanceEffect(caster, target, spell, params)
    
    local duration = math.ceil(4 * resist * tryBuildResistance(tpz.mod.RESBUILD_STUN, target))
    if resist >= 0.25 and not target:hasStatusEffect(tpz.effect.STUN) then
        target:addStatusEffect(tpz.effect.STUN, 1, 0, duration)
    end

    return damage
end
