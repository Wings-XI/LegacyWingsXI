-----------------------------------------
-- Spell: Animating Wail
-- Increases attack speed
-- Spell cost: 53 MP
-- Monster Type: Undead
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 5
-- Stat Bonus: HP+20
-- Level: 79
-- Casting Time: 2 Seconds
-- Recast Time: 45 Seconds
-- 5 minutes
--
-- Combos: Dual Wield
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local duration = 300

    if caster:hasStatusEffect(tpz.effect.DIFFUSION) then
        duration = duration + duration * caster:getMerit(tpz.merit.DIFFUSION) / 100
        caster:delStatusEffect(tpz.effect.DIFFUSION)
    end

    if not target:addStatusEffect(tpz.effect.HASTE, 1500, 0, duration) then -- 15%
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    return tpz.effect.HASTE
end
