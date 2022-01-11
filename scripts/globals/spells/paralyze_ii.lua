-----------------------------------------
-- Spell: Paralyze II
-- Spell accuracy is most highly affected by Enfeebling Magic Skill, Magic Accuracy, and MND.
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
require("scripts/globals/utils")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)

    if target:getMod(tpz.mod.STATUSRES) >= 100 or target:getMod(tpz.mod.PARALYZERES) >= 100 then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return tpz.effect.PARALYSIS
    end
    
    -- Pull base stats
    local dMND = caster:getStat(tpz.mod.MND) - target:getStat(tpz.mod.MND)

    local params = {}
    params.diff = dMND
    params.skillType = tpz.skill.ENFEEBLING_MAGIC
    params.bonus = 0
    params.effect = tpz.effect.PARALYSIS
    local resist = applyResistanceEffect(caster, target, spell, params)
    
    local duration = calculateDuration(120, spell:getSkillType(), spell:getSpellGroup(), caster, target) * tryBuildResistance(tpz.mod.RESBUILD_PARALYZE, target)
    if resist >= 0.5 then
        -- Get Merit Potency Bonus 1% Potency/Upgrade
        local merits = caster:getMerit(tpz.merit.PARALYZE_II)
        -- Base Potency is 15 (Same as Paralyze)
        local potency = utils.clamp(math.floor(dMND / 4) + (15 + merits), 10, 30)
        potency = calculatePotency(potency, spell:getSkillType(), caster, target)
    
        if target:addStatusEffect(params.effect, potency, 0, math.ceil(duration * resist)) then
            spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
    end

    return params.effect
end
