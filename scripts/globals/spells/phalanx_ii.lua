-----------------------------------------
-- Spell: Phalanx II
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local enhskill = caster:getSkillLevel(tpz.skill.ENHANCING_MAGIC)
    local power = 0
    local merits = caster:getMerit(tpz.merit.PHALANX_II)

    -- Duration Caps at 240s w/ +30s per merit (https://ffxiclopedia.fandom.com/wiki/Phalanx_II?oldid=1009846)
    local duration = calculateDuration(90, spell:getSkillType(), spell:getSpellGroup(), caster, target)
    -- Implementing merit bonuses prior to level calculation as all testing is presumed done at 75
    duration = duration + (merits * 10)
    print("Duration :".. duration)
    duration = calculateDurationForLvl(duration, 75, target:getMainLvl())

    -- Power Formula Sources: (http://nullvector.com/enhancing.php, https://www.bg-wiki.com/index.php?title=Phalanx_II&oldid=65695, and https://ffxiclopedia.fandom.com/wiki/Phalanx_II?oldid=1009846)
    power = math.max(math.floor((enhskill / 25) + (1 + merits)), 0)
    print("Power: ".. power)

    if target:addStatusEffect(tpz.effect.PHALANX, power, 0, duration) then
        spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    return tpz.effect.PHALANX
end
