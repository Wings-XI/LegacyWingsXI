-----------------------------------------
-- Spell: Bio II
-- Deals dark damage that weakens an enemy's attacks and gradually reduces its HP.
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/utils")
require("scripts/globals/msg")
--------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local dia = target:getStatusEffect(tpz.effect.DIA)
    if dia ~= nil and dia:getTier() >= 3 then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return 0
    end
    
    local skillLvl = caster:getSkillLevel(tpz.skill.DARK_MAGIC)
    local basedmg = skillLvl / 4
    local params = {}
    params.dmg = basedmg
    params.multiplier = 2
    params.skillType = tpz.skill.DARK_MAGIC
    params.attribute = tpz.mod.INT
    params.hasMultipleTargetReduction = false
    params.diff = caster:getStat(tpz.mod.INT)-target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.DARK_MAGIC
    params.bonus = 1.0

    -- Calculate raw damage
    local dmg = calculateMagicDamage(caster, target, spell, params)
    -- Softcaps at 30, should always do at least 1
    dmg = utils.clamp(dmg, 1, 30)
    -- Get resist multiplier (1x if no resist)
    local resist = applyResistance(caster, target, spell, params)
    -- Get the resisted damage
    dmg = dmg * resist
    -- Add on bonuses (staff/day/weather/jas/mab/etc all go in this function)
    dmg = addBonuses(caster, spell, target, dmg)
    -- Add in target adjustment
    dmg = adjustForTarget(target, dmg, spell:getElement())
    -- Add in final adjustments including the actual damage dealt
    local final = finalMagicAdjustments(caster, target, spell, dmg)

    -- Calculate duration
    local duration = 120

    -- Calculate DoT effect
    -- http://wiki.ffo.jp/html/1954.html
    -- This formula gives correct values for every breakpoint listed on that site
    -- Caps at 8 dmg/tick (http://wiki.ffo.jp/wiki.cgi?Command=HDetail&articleid=110731&id=1954)
    local dotdmg = math.floor((skillLvl + 29) / 40)
    dotdmg = utils.clamp(dotdmg, 3, 8)

    -- Do it!
    target:delStatusEffect(tpz.effect.DIA)
    -- Bio II's attack down effect in era is 10.1% (http://wiki.ffo.jp/wiki.cgi?Command=HDetail&articleid=110731&id=1954)
    target:addStatusEffect(tpz.effect.BIO, dotdmg, 3, duration, 0, 10, 2)
    spell:setMsg(tpz.msg.basic.MAGIC_DMG)

    return final
end
