-----------------------------------------
-- Spell: Ice Break
-- Deals ice damage to enemies within range. Additional Effect: "Bind"
-- Spell cost: 142 MP
-- Monster Type: Arcana
-- Spell Type: Magical (Ice)
-- Blue Magic Points: 3
-- Stat Bonus: INT+1
-- Level: 50
-- Casting Time: 5.25 seconds
-- Recast Time: 33.75 seconds
-- Magic Bursts on: Induration, Distortion, and Darkness
-- Combos: Magic Defense Bonus
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
    params.attackType = tpz.attackType.MAGICAL
    params.damageType = tpz.damageType.ICE
    params.multiplier = caster:hasStatusEffect(tpz.effect.AZURE_LORE) and 4.5 or 3.2
    params.tMultiplier = 1.0
    params.duppercap = 69
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.3
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    local damage = BlueMagicalSpell(caster, target, spell, params, INT_BASED)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    params = {}
    params.eco = ECO_ARCANA
    params.diff = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = caster:getStatusEffect(tpz.effect.CONVERGENCE) == nil and 0 or (caster:getStatusEffect(tpz.effect.CONVERGENCE)):getPower()
    params.bonus = params.bonus + caster:getMerit(tpz.merit.MAGICAL_ACCURACY)
    params.effect = tpz.effect.BIND
    local resist = applyResistanceEffect(caster, target, spell, params)

    local duration =  math.ceil(30 * tryBuildResistance(tpz.mod.RESBUILD_BIND, target))
    if target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.BINDRES) < 100 then
        if resist >= 0.5 then
            target:delStatusEffect(tpz.effect.BIND)
            target:addStatusEffect(tpz.effect.BIND, 1, 0, duration*resist)
        end
    end

    return damage
end
