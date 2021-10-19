-----------------------------------------
-- Spell: Occultation
-- Creates shadow images that each absorb a single attack directed at you
-- Spell cost: 138 MP
-- Monster Type: Seethers
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 3
-- Stat Bonus: VIT+3 CHR-2
-- Level: 88
-- Casting Time: 2 seconds
-- Recast Time: 1 minute, 30 seconds
--
-- Combos: Evasion Bonus
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local power = math.floor(caster:getSkillLevel(tpz.skill.BLUE_MAGIC) / 50)
    if power < 2 then power = 2 end
    local duration = 300

    -- 400 skill = 8 shadows, 450 = 9 shadows, so I am assuming every 50 skill is a shadow.
    -- Also assuming minimum of 2 shadows.
    -- I've never seen the spell cast with under 100 skill, so I could be wrong.

    if caster:hasStatusEffect(tpz.effect.DIFFUSION) then
        duration = duration + duration * caster:getMeritCount(tpz.merit.DIFFUSION) / 100
        caster:delStatusEffect(tpz.effect.DIFFUSION)
    end

    if target:addStatusEffect(tpz.effect.BLINK, power, 0, duration) == false then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    return tpz.effect.BLINK
end
