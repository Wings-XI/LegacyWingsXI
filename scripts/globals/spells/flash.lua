-----------------------------------------
-- Spell: Flash
-- Temporarily blinds an enemy, greatly lowering its accuracy.
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)

    if target:getMod(tpz.mod.STATUSRES) >= 100 or target:getMod(tpz.mod.BLINDRES) >= 100 then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return tpz.effect.FLASH
    end

    -- Pull base stats.
    local params = {}

    params.diff = (caster:getStat(tpz.mod.MND) - target:getStat(tpz.mod.MND))

    params.attribute = tpz.mod.MND

    params.skillType = tpz.skill.DIVINE_MAGIC

    params.bonus =  150

    params.effect = nil

    local resist = applyResistance(caster, target, spell, params)
    
    local duration = math.ceil(12 * resist * tryBuildResistance(tpz.mod.RESBUILD_BLIND, target))
    if (resist > 0.0625) then
        if (target:addStatusEffect(tpz.effect.FLASH, 200, 0, duration)) then
            spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
    end
    return tpz.effect.FLASH
end
