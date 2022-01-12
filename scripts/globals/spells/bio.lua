-----------------------------------------
-- Spell: Bio
-- Deals dark damage that weakens an enemy's attacks and gradually reduces its HP.
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/utils")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local dia = target:getStatusEffect(tpz.effect.DIA)
    if dia ~= nil and dia:getTier() >= 2 then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return 0
    end

    local skillLvl = caster:getSkillLevel(tpz.skill.DARK_MAGIC)
    local basedmg = skillLvl / 4
    local params = {}
    params.dmg = basedmg
    params.multiplier = 1
    params.skillType = tpz.skill.DARK_MAGIC
    params.attribute = tpz.mod.INT
    params.hasMultipleTargetReduction = false
    params.diff = caster:getStat(tpz.mod.INT)-target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.DARK_MAGIC
    params.bonus = 1.0

    -- Calculate raw damage
    local dmg = calculateMagicDamage(caster, target, spell, params)
    -- Softcaps at 15, should always do at least 1
    dmg = utils.clamp(dmg, 1, 15)
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
    local duration = 60

    -- Calculate DoT effect
    -- Caps at 2 dmg/tick (http://wiki.ffo.jp/wiki.cgi?Command=HDetail&articleid=110731&id=1954)
    local dotdmg = 0
    if skillLvl > 40 then
        dotdmg = 2
    else                
        dotdmg = 1
    end

    -- Do it!
    target:delStatusEffect(tpz.effect.DIA)
    -- Bio's attack down in era is 5.1% (http://wiki.ffo.jp/wiki.cgi?Command=HDetail&articleid=110731&id=1954)
    target:addStatusEffect(tpz.effect.BIO, dotdmg, 3, duration, 0, 5, 1)
    spell:setMsg(tpz.msg.basic.MAGIC_DMG)

    return final
end
