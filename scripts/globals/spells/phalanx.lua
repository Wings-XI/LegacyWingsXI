-----------------------------------------
-- Spell: Phalanx
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
    local duration = calculateDuration(180, spell:getSkillType(), spell:getSpellGroup(), caster, target)
    duration = calculateDurationForLvl(duration, 33, target:getMainLvl())

    -- Era Agreed Formula is ((enhskill/10) - 2)) (http://nullvector.com/enhancing.php, https://ffxiclopedia.fandom.com/wiki/Talk:Phalanx?oldid=999586, and https://www.bg-wiki.com/index.php?title=Phalanx&oldid=65694)
    power = math.max(math.floor((enhskill / 10) - 2), 0)

    -- Cap at 35
    power = math.min(power, 35)

    if target:addStatusEffect(tpz.effect.PHALANX, power, 0, duration) then
        spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    return tpz.effect.PHALANX
end
