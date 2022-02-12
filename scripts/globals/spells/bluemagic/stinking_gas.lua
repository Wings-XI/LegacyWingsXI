-----------------------------------------
-- Spell: Stinking Gas
-- Lowers Vitality of enemies within range
-- Spell cost: 37 MP
-- Monster Type: Undead
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 2
-- Stat Bonus: AGI+1
-- Level: 44
-- Casting Time: 4 seconds
-- Recast Time: 60 seconds
-- Magic Bursts on: Detonation, Fragmentation, and Light
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
    params = {}
    params.eco = ECO_UNDEAD
    params.diff = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = caster:getStatusEffect(tpz.effect.CONVERGENCE) == nil and 0 or (caster:getStatusEffect(tpz.effect.CONVERGENCE)):getPower()
    params.bonus = params.bonus + caster:getMerit(tpz.merit.MAGICAL_ACCURACY)
    params.effect = nil
    local resist = applyResistanceEffect(caster, target, spell, params)
    
    if target:hasStatusEffect(tpz.effect.VIT_DOWN) then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    elseif resist >= 0.5 then
        if target:addStatusEffect(tpz.effect.VIT_DOWN, 10, 0, 60*resist) then
            spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
    end

    return tpz.effect.VIT_DOWN
end
