-----------------------------------------
-- Spell: Actinic Burst
-- Greatly lowers the accuracy of enemies within range for a brief period of time
-- Spell cost: 24 MP
-- Monster Type: Luminions
-- Spell Type: Magical (Light)
-- Blue Magic Points: 4
-- Stat Bonus: CHR+2, HP+20
-- Level: 74
-- Casting Time: 0.5 seconds
-- Recast Time: 60 seconds
-- Effect Time: About 15 seconds
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
    local params = {}
    params.eco = ECO_LUMINION
    params.attribute = tpz.mod.MND
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = caster:getStatusEffect(tpz.effect.CONVERGENCE) == nil and 0 or (caster:getStatusEffect(tpz.effect.CONVERGENCE)):getPower()
    params.bonus = params.bonus + caster:getMerit(tpz.merit.MAGICAL_ACCURACY)
    params.effect = nil
    local resist = applyResistance(caster, target, spell, params)
    local duration = 15 * resist

    if resist >= 0.25 then
        if target:addStatusEffect(tpz.effect.FLASH, 200, 0, duration) then
            spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
    end

    return tpz.effect.FLASH
end
