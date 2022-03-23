-----------------------------------------
-- Spell: MP Drainkiss
-- Steals an enemy's MP. Ineffective against undead
-- Spell cost: 20 MP
-- Monster Type: Amorphs
-- Spell Type: Magical (Dark)
-- Blue Magic Points: 4
-- Stat Bonus: MP+5
-- Level: 42
-- Casting Time: 4 seconds
-- Recast Time: 90 seconds
-- Magic Bursts on: Compression, Gravitation, Darkness
-- Combos: None
-- Notes:
-- Affected by Blue Magic Skill and Magic Accuracy.
-- Soft cap at 165MP before Magic Bursts / Day and Weather/Elemental Affinity effects.
-- Elemental Affinity and Elemental Obis affect both accuracy and amount of MP drained.
-- Magic Burst affects both accuracy and amount of MP drained.
-- INT increases Magic Accuracy in general, but is not a modifier of this spell.
-- Unlike Magic Hammer, MP drained is not enhanced by Magic Attack Bonus.
-- A positive Monster Correlation (vs Birds) or a negative Monster Correlation (vs Aquans), affects both accuracy and potency.
-----------------------------------------
require("scripts/globals/bluemagic")
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
    if target:isUndead() or target:hasImmunity(8192) then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return 0
    end
    
    local dmg = 5 + 0.375 * caster:getSkillLevel(tpz.skill.BLUE_MAGIC)
    if dmg > 165 then dmg = 165 + (dmg-165)/2 end -- wiki says soft cap
    
    local params = {}
    params.eco = ECO_AMORPH
    params.diff = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = caster:getMerit(tpz.merit.MAGICAL_ACCURACY)
    local resist = applyResistance(caster, target, spell, params)
    
    dmg = dmg*resist
    dmg = addBonuses(caster, spell, target, dmg) -- staff/day/weather/jas/mab/etc all go in this function
    dmg = adjustForTarget(target, dmg, spell:getElement())

    if dmg < 0 then dmg = 0 end
    dmg = dmg * BLUE_POWER
    if target:getMP() < dmg then dmg = target:getMP() end
    
    caster:addMP(dmg)
    target:delMP(dmg)

    return dmg
end
