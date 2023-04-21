-----------------------------------------
-- Spell: Haste
-- Composure increases duration 3x
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local duration = calculateDuration(180, spell:getSkillType(), spell:getSpellGroup(), caster, target)
    duration = calculateDurationForLvl(duration, 48, target:getMainLvl())

    local power = 1465 -- 150/1024 ~14.65%

    -- Special modification to allow regular haste to overwrite hastega as in era.
    local currentHaste = target:getStatusEffect(tpz.effect.HASTE)
    if currentHaste then
        if currentHaste:getPower() < 1500 then
            target:delStatusEffect(tpz.effect.HASTE)
        end
    end

    if not target:addStatusEffect(tpz.effect.HASTE, power, 0, duration) then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    return tpz.effect.HASTE
end
