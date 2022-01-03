-----------------------------------------
-- Spell: Aquaveil
-- Reduces chance of having a spell interrupted.
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    target:delStatusEffect(tpz.effect.AQUAVEIL)

    -- duration is said to be based on enhancing skill with max 5 minutes, but I could find no
    -- tests that quantify the relationship so I'm using 5 minutes for now.
    local duration = calculateDuration(300, spell:getSkillType(), spell:getSpellGroup(), caster, target)
    local enhskill = caster:getSkillLevel(tpz.skill.ENHANCING_MAGIC)
    -- there are no set formulas from in-era, this thread seems to have the closest forumla
    -- https://www.bluegartr.com/threads/82143-Spell-interruption-down-cap-and-Aquaveil-Tests/page2
    -- Arguments between 20-25% but one test seems to be pretty concrete on 23% being the cap
    local power = enhskill / 12
  
    if power > 23 then
        power = 23
    end

    target:addStatusEffect(tpz.effect.AQUAVEIL, power, 0, duration)
    spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)

    return tpz.effect.AQUAVEIL
end
