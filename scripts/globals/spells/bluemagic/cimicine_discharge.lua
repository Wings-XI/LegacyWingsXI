-----------------------------------------
-- Spell: Cimicine Discharge
-- Reduces the attack speed of enemies within range
-- Spell cost: 32 MP
-- Monster Type: Vermin
-- Spell Type: Magical (Earth)
-- Blue Magic Points: 3
-- Stat Bonus: DEX+1, AGI+2
-- Level: 78
-- Casting Time: 3 seconds
-- Recast Time: 20 seconds
--
-- Combos: Magic Burst Bonus
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local params = {}
    params.eco = ECO_VERMIN
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = 0
    params.effect = nil
    local resist = applyResistance(caster, target, spell, params)

    if resist < 0.5 then
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
    else
        if target:addStatusEffect(tpz.effect.SLOW, 2000, 0, 90*resist) then
            spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        end
    end

    return tpz.effect.SLOW
end
