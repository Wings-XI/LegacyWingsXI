-----------------------------------------
-- Spell: Bio III
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
    local skillLvl = caster:getSkillLevel(tpz.skill.DARK_MAGIC)
    local basedmg = skillLvl / 4
    local params = {}
    params.dmg = basedmg
    params.multiplier = 3
    params.skillType = tpz.skill.DARK_MAGIC
    params.attribute = tpz.mod.INT
    params.hasMultipleTargetReduction = false
    params.diff = caster:getStat(tpz.mod.INT)-target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.DARK_MAGIC
    params.bonus = 1.0

    -- Calculate raw damage
    local dmg = calculateMagicDamage(caster, target, spell, params)
    -- Softcaps at 62, should always do at least 1
    dmg = utils.clamp(dmg, 1, 62)
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
    local merits = caster:getMerit(tpz.merit.BIO_III)
    local duration = calculateDuration(180, spell:getSkillType(), spell:getSpellGroup(), caster, target)

    -- Calculate DoT effect
    -- http://wiki.ffo.jp/wiki.cgi?Command=HDetail&articleid=110731&id=1954
    local dotdmg = 0
    if skillLvl > 251 then 
        dotdmg =  9
    elseif skillLvl > 211 then
        dotdmg =  8
    elseif skillLvl < 171 then
        dotdmg =  7
    elseif skillLvl > 131 then
        dotdmg =  6
    else
        dotdmg =  5
    end

    -- Do it!
    target:delStatusEffect(tpz.effect.DIA)
    if caster:isPC() then
        -- Bio III's attack down effect in era is 15.2% (http://wiki.ffo.jp/wiki.cgi?Command=HDetail&articleid=110731&id=1954)
        target:addStatusEffect(tpz.effect.BIO, dotdmg, 3, merits, 0, 15, 3)
    else
        -- Bio III's attack down effect in era is 15.2% (http://wiki.ffo.jp/wiki.cgi?Command=HDetail&articleid=110731&id=1954)
        target:addStatusEffect(tpz.effect.BIO, dotdmg, 3, duration, 0, 15, 3)
    end
    spell:setMsg(tpz.msg.basic.MAGIC_DMG)

    return final
end
