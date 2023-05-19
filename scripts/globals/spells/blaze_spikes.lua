-----------------------------------------
-- Spell: Blaze Spikes
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    -- don't spam blaze spikes as PW/PL
    if (caster:getFamily() == 316 or caster:getFamily() == 91) and target:hasStatusEffect(tpz.effect.BLAZE_SPIKES) then
        return 1
    end
    return 0
end

function onSpellCast(caster, target, spell)
    local duration = calculateDuration(SPIKE_EFFECT_DURATION, spell:getSkillType(), spell:getSpellGroup(), caster, target)
    local typeEffect = tpz.effect.BLAZE_SPIKES

    local int = caster:getStat(tpz.mod.INT)
    local magicAtk = caster:getMod(tpz.mod.MATT)
    local power = math.floor( ((int + 2) / 12 + 4) * (1 + magicAtk / 100) )

    if target:addStatusEffect(typeEffect, power, 0, duration) then
        spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    return typeEffect
end
