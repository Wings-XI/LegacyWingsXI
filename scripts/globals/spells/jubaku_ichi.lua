-----------------------------------------
-- Spell: Jubaku: Ichi
-- Spell accuracy is most highly affected by Enfeebling Magic Skill, Magic Accuracy, and INT.
-- taken from paralyze
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local effect = tpz.effect.PARALYSIS
    -- Base Stats
    --Duration Calculation
    local duration = 180
    local params = {}
    params.diff = (caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT))
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.NINJUTSU
    params.bonus = 0
    local resist = applyResistance(caster, target, spell, params)
    --Jubaku base powers are not effected by resistances, Ichi:20, Ni:30, San:35.
    local power = 20

    duration = math.ceil(duration * resist * tryBuildResistance(tpz.mod.RESBUILD_PARALYZE, target))
    if (resist >= 0.5) then
        -- Erases a weaker paralyze and applies the stronger one
        local paralysis = target:getStatusEffect(effect)
        if (paralysis ~= nil) then
            if (paralysis:getPower() < power) then
                target:delStatusEffect(effect)
                target:addStatusEffect(effect, power, 0, duration)
                spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB)
            else
                spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
            end
        else
            target:addStatusEffect(effect, power, 0, duration)
            spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB)
        end
    else
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
    end

    return effect
end
