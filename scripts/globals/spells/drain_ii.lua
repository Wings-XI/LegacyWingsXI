-----------------------------------------
-- Spell: Drain II
-- Drain functions only on skill level!!
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    if target:isUndead() then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return 0
    end
    --calculate raw damage (unknown function  -> only dark skill though) - using http://www.bluegartr.com/threads/44518-Drain-Calculations
    -- also have small constant to account for 0 dark skill
    local dmg = 20 + (1.236 * caster:getSkillLevel(tpz.skill.DARK_MAGIC))

    if (dmg > (caster:getSkillLevel(tpz.skill.DARK_MAGIC) + 85)) then
        dmg = (caster:getSkillLevel(tpz.skill.DARK_MAGIC) + 85)
    end

    --get resist multiplier (1x if no resist)
    local params = {}
    params.diff = caster:getStat(tpz.mod.INT)-target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.DARK_MAGIC
    params.bonus = 1.0
    local resist = applyResistance(caster, target, spell, params)
    --get the resisted damage
    dmg = dmg*resist
    --add on bonuses (staff/day/weather/jas/mab/etc all go in this function)
    dmg = addBonuses(caster, spell, target, dmg)
    --add in target adjustment
    dmg = adjustForTarget(target, dmg, spell:getElement())
    --add in final adjustments

    if (dmg < 0) then
        dmg = 0
    end

    dmg = finalMagicAdjustments(caster, target, spell, dmg)

    local leftOver = (caster:getHP() + dmg) - caster:getMaxHP()
    local overHeal = (leftOver/caster:getMaxHP())*100
    if caster:hasStatusEffect(tpz.effect.WEAKNESS) then
        overHeal = (leftOver/(caster:getBaseHP() + caster:getMod(tpz.mod.HP)))*100
    end

    if (leftOver > 0) then
        caster:addStatusEffect(tpz.effect.MAX_HP_BOOST, overHeal, 0, 60)
    end

    dmg = caster:addHP(dmg)
    
    return dmg
end
