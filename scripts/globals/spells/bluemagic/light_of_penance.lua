-----------------------------------------
-- Spell: Light of Penance
-- Reduces an enemy's TP. Additional effect: Blindness and "Bind"
-- Spell cost: 53 MP
-- Monster Type: Beastmen
-- Spell Type: Magical (Light)
-- Blue Magic Points: 5
-- Stat Bonus: CHR+1, HP+15
-- Level: 58
-- Casting Time: 3 seconds
-- Recast Time: 60 seconds
-- Magic Bursts on: Transfixion, Fusion, and Light
-- Combos: Auto Refresh
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local typeEffectOne = tpz.effect.BLINDNESS
    local typeEffectTwo = tpz.effect.BIND
    local params = {}
    params.diff = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = 1.0
    local resist = applyResistance(caster, target, spell, params)
    local power = 100 * resist
    local returnEffect = typeEffectOne
    
    local blindDuration = math.ceil(30 * resist * tryBuildResistance(tpz.mod.RESBUILD_BLIND, target))
    local bindDuration = math.ceil(30 * resist * tryBuildResistance(tpz.mod.RESBUILD_BIND, target))
    if (resist >= 0.5) then
        if (target:isFacing(caster)) then
            if (target:hasStatusEffect(typeEffectOne) and target:hasStatusEffect(typeEffectTwo) and target:getTP() == 0) then
                spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT) -- no effect
            elseif (target:hasStatusEffect(typeEffectOne) and target:hasStatusEffect(typeEffectTwo)) then
                target:delTP(power)
                spell:setMsg(tpz.msg.basic.MAGIC_TP_REDUCE)
            elseif target:hasStatusEffect(typeEffectOne) then
                target:addStatusEffect(typeEffectTwo, 1, 0, bindDuration)
                target:delTP(power)
                returnEffect = typeEffectTwo -- make it return bind message if blind can't be inflicted
                spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
            else
                target:addStatusEffect(typeEffectTwo, 1, 0, bindDuration)
                target:addStatusEffect(typeEffectOne, 100, 0, blindDuration)
                target:delTP(power)
                spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
            end
        else
            spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        end
    end

    return returnEffect
end
