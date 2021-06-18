-----------------------------------------
-- Spell: 1000 Needles
-- Shoots multiple needles at enemies within range
-- Spell cost: 350 MP
-- Monster Type: Plantoid
-- Spell Type: Magical (Light)
-- Blue Magic Points: 5
-- Stat Bonus: VIT+3, AGI+3
-- Level: 62
-- Casting Time: 12 seconds
-- Recast Time: 120 seconds
-- Bursts on Light affects accuracy only
-- Combos: Beast Killer
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
    params.eco = ECO_PLANTOID
    params.attackType = tpz.attackType.MAGICAL
    params.damageType = tpz.damageType.LIGHT
    params.diff = caster:getStat(tpz.mod.MND) - target:getStat(tpz.mod.MND)
    params.attribute = tpz.mod.MND
    params.bonus = 10
    params.effect = nil
    
    local resist = target:isNM() and applyResistanceEffect(caster, target, spell, params) or 1
    local damage = target:isPC() and 750/spell:getTotalTargets() or 1000/spell:getTotalTargets()
    damage = resist < 1 and 0 or damage
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    return damage
end
