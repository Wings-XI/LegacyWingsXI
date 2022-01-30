-----------------------------------------
-- Spell: Lowing
-- Gives enemies within range a powerful disease that prevents recovery of HP and MP
-- Spell cost: 66 MP
-- Monster Type: Beasts
-- Spell Type: Magical (Fire)
-- Blue Magic Points: 2
-- Stat Bonus: HP-5
-- Level: 71
-- Casting Time: 7 seconds
-- Recast Time: 56 seconds
-- Magic Bursts on: Liquefaction, Fusion, and Light
-- Combos: Clear Mind
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

    if target:getMod(tpz.mod.STATUSRES) >= 100 or target:getMod(tpz.mod.VIRUSRES) >= 100 then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return tpz.effect.PLAGUE
    end
    
    local params = {}
    params.eco = ECO_BEAST
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.effect = tpz.effect.PLAGUE
    params.bonus = caster:getStatusEffect(tpz.effect.CONVERGENCE) == nil and 0 or (caster:getStatusEffect(tpz.effect.CONVERGENCE)):getPower()
    local resist = applyResistance(caster, target, spell, params)

    if resist >= 0.5 then
        if target:addStatusEffect(tpz.effect.PLAGUE, 5, 0, 60*resist) then
            spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
    end

    return tpz.effect.PLAGUE
end
