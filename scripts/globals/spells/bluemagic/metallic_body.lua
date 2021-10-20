-----------------------------------------
-- Spell: Metallic Body
-- Absorbs an certain amount of damage from physical and magical attacks
-- Spell cost: 19 MP
-- Monster Type: Aquans
-- Spell Type: Magical (Earth)
-- Blue Magic Points: 1
-- Stat Bonus: None
-- Level: 8
-- Casting Time: 7 seconds
-- Recast Time: 60 seconds
-- Duration: 5 minutes
--
-- Combos: Max MP Boost
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local blueskill = caster:getSkillLevel(tpz.skill.BLUE_MAGIC)
    local power = (blueskill/3) + (caster:getMainLvl()/3) + 10
    if power > 150 then power = 150 end
    local duration = 300
    
    if caster:hasStatusEffect(tpz.effect.DIFFUSION) then
        --duration = duration + duration * caster:getMeritCount(tpz.merit.DIFFUSION) / 100 -- OOE Buff from May 16, 2012 update
        caster:delStatusEffect(tpz.effect.DIFFUSION)
    end

    if not target:addStatusEffect(tpz.effect.STONESKIN, power, 0, duration, 0, 0, 2) then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    return tpz.effect.STONESKIN
end
