-----------------------------------------
-- Spell: Dia III
-- Lowers an enemy's defense and gradually deals light elemental damage.
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
    local bio = target:getStatusEffect(tpz.effect.BIO)
    if bio ~= nil and bio:getTier() >= 3 then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return 0
    end
    
    local basedmg = caster:getSkillLevel(tpz.skill.ENFEEBLING_MAGIC) / 4
    local params = {}
    params.dmg = basedmg
    params.multiplier = 5
    params.skillType = tpz.skill.ENFEEBLING_MAGIC
    params.attribute = tpz.mod.MND
    params.hasMultipleTargetReduction = false
    params.diff = caster:getStat(tpz.mod.MND) - target:getStat(tpz.mod.MND)
    params.bonus = 1.0

    -- Calculate raw damage
    local dmg = calculateMagicDamage(caster, target, spell, params)
    -- Softcaps at 32, should always do at least 1
    dmg = utils.clamp(dmg, 1, 32)
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

    -- Calculate duration and bonus
    local merits = caster:getMerit(tpz.merit.DIA_III)
    local duration = calculateDuration(180, spell:getSkillType(), spell:getSpellGroup(), caster, target)

    local dotBonus = caster:getMod(tpz.mod.DIA_DOT) -- Dia Wand

    -- Do it!
    target:delStatusEffect(tpz.effect.BIO)
    if caster:isPC() then
        target:addStatusEffect(tpz.effect.DIA, 3 + dotBonus, 3, merits, 0, 20, 3)
    else
        target:addStatusEffect(tpz.effect.DIA, 3 + dotBonus, 3, duration, 0, 20, 3)
    end
    spell:setMsg(tpz.msg.basic.MAGIC_DMG)

    return final
end
