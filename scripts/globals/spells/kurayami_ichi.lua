-----------------------------------------
-- Spell: Kurayami:Ichi
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
        return tpz.effect.BLINDNESS
    end
    
    -- Base Stats
    local params = {}
    params.diff = (caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT))
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.NINJUTSU
    params.bonus = 0
    local resist = applyResistance(caster, target, spell, params)

    local duration = math.ceil(180 * resist * tryBuildResistance(tpz.mod.RESBUILD_BLIND, target))
    if (resist >= 0.5) then
        --Kurayami base power is 20 and is not affected by resistaces.
        local power = 20
        if (target:addStatusEffect(tpz.effect.BLINDNESS, power, 0, duration)) then
            spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
    end

    return tpz.effect.BLINDNESS
end
