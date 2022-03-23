-----------------------------------------
-- Spell: Digest
-- Steals an enemy's HP. Ineffective against undead
-- Spell cost: 20 MP
-- Monster Type: Amorphs
-- Spell Type: Magical (Dark)
-- Blue Magic Points: 2
-- Stat Bonus: HP-5, MP+5
-- Level: 36
-- Casting Time: 4 seconds
-- Recast Time: 90 seconds
-- Magic Bursts on: Compression, Gravitation, Darkness
-- Combos: None
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    if target:isUndead() then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return dmg
    end
    
    local dmg = 1 + 0.55 * caster:getSkillLevel(tpz.skill.BLUE_MAGIC)
    local params = {}
    params.eco = ECO_AMORPH
    params.diff = caster:getStat(tpz.mod.MND)-target:getStat(tpz.mod.MND)
    params.attribute = tpz.mod.MND
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = caster:getMerit(tpz.merit.MAGICAL_ACCURACY)
    local resist = applyResistance(caster, target, spell, params)
    dmg = dmg*resist
    dmg = addBonuses(caster, spell, target, dmg)
    dmg = adjustForTarget(target, dmg, spell:getElement())
    
    if dmg > caster:getSkillLevel(tpz.skill.BLUE_MAGIC) + 20 then
        dmg = caster:getSkillLevel(tpz.skill.BLUE_MAGIC) + 20
    end
    if dmg < 0 then dmg = 0 end
    if target:getHP() < dmg then dmg = target:getHP() end

    params.attackType = tpz.attackType.MAGICAL
    params.damageType = tpz.damageType.DARK
    dmg = BlueFinalAdjustments(caster, target, spell, dmg, params)
    caster:addHP(dmg)

    return dmg
end
