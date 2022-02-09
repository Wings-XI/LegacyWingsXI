-----------------------------------------
-- Spell: Enervation
-- Lowers the defense and magical defense of enemies within range
-- Spell cost: 48 MP
-- Monster Type: Beastmen
-- Spell Type: Magical (Dark)
-- Blue Magic Points: 5
-- Stat Bonus: HP-5, MP+5
-- Level: 67
-- Casting Time: 6 seconds
-- Recast Time: 60 seconds
-- Magic Bursts on: Compression, Gravitation, and Darkness
-- Combos: Counter
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
    local params = {}
    params.eco = ECO_NONE
    params.diff = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = caster:getStatusEffect(tpz.effect.CONVERGENCE) == nil and 0 or (caster:getStatusEffect(tpz.effect.CONVERGENCE)):getPower()
    params.bonus = params.bonus + caster:getMerit(tpz.merit.MAGICAL_ACCURACY)
    params.effect = nil
    local resist = applyResistanceEffect(caster, target, spell, params)

    if resist >= 0.5 then
        if target:hasStatusEffect(tpz.effect.DEFENSE_DOWN) and target:hasStatusEffect(tpz.effect.MAGIC_DEF_DOWN) then
            spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
            return tpz.effect.DEFENSE_DOWN
        elseif target:hasStatusEffect(tpz.effect.DEFENSE_DOWN) then
            if target:addStatusEffect(tpz.effect.MAGIC_DEF_DOWN, 8, 0, 30*resist) then
                spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
                return tpz.effect.MAGIC_DEF_DOWN
            end
        elseif target:hasStatusEffect(tpz.effect.MAGIC_DEF_DOWN) then
            if target:addStatusEffect(tpz.effect.DEFENSE_DOWN, 10, 0, 30*resist) then
                spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
                return tpz.effect.DEFENSE_DOWN
            end
        else
            local defSuccess = target:addStatusEffect(tpz.effect.DEFENSE_DOWN, 10, 0, 30*resist)
            local magSuccess = target:addStatusEffect(tpz.effect.MAGIC_DEF_DOWN, 8, 0, 30*resist)
            if defSuccess or magSuccess then
                spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
                if defSuccess then return tpz.effect.DEFENSE_DOWN else return tpz.effect.MAGIC_DEF_DOWN end
            end
        end
    end
    
    spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
    return tpz.effect.DEFENSE_DOWN
end
