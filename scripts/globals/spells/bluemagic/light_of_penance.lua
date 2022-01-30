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
    if not target:isFacing(caster, 40) then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return tpz.effect.BIND
    end

    local returnEffect = nil
    local params = {}
    params.eco = ECO_NONE
    params.diff = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = caster:getStatusEffect(tpz.effect.CONVERGENCE) == nil and 0 or (caster:getStatusEffect(tpz.effect.CONVERGENCE)):getPower()
    
    params.effect = tpz.effect.BLINDNESS
    local blindResist = applyResistanceEffect(caster, target, spell, params)
    local blindDuration = math.ceil(30 * blindResist * tryBuildResistance(tpz.mod.RESBUILD_BLIND, target))
    
    params.effect = tpz.effect.BIND
    local bindResist = applyResistanceEffect(caster, target, spell, params)
    local bindDuration = math.ceil(30 * bindResist * tryBuildResistance(tpz.mod.RESBUILD_BIND, target))
    
    if target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.BLINDRES) < 100 then
        if blindResist >= 0.5 then
            target:delTP(100*blindResist)
            if not target:hasStatusEffect(tpz.effect.BLINDNESS) and target:addStatusEffect(tpz.effect.BLINDNESS, 25, 0, blindDuration) then
                returnEffect = tpz.effect.BLINDNESS
            end
        end
    end
    
    if target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.BINDRES) < 100 then
        if bindResist >= 0.5 then
            target:delTP(100*bindResist)
            if not target:hasStatusEffect(tpz.effect.BIND) and target:addStatusEffect(tpz.effect.BIND, 1, 0, bindDuration) then
                returnEffect = tpz.effect.BIND
            end
        end
    end
    
    if returnEffect == nil then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return tpz.effect.BIND
    else
        spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
        return returnEffect
    end
end
