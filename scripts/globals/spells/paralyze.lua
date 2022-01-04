-----------------------------------------
-- Spell: Paralyze
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

    local dMND = caster:getStat(tpz.mod.MND) - target:getStat(tpz.mod.MND)

    local params = {}
    params.diff = dMND
    params.skillType = tpz.skill.ENFEEBLING_MAGIC
    params.bonus = 0
    params.effect = tpz.effect.PARALYSIS
    local resist = applyResistanceEffect(caster, target, spell, params)
    
    local duration = calculateDuration(120, spell:getSkillType(), spell:getSpellGroup(), caster, target) * tryBuildResistance(tpz.mod.RESBUILD_PARALYZE, target)
    if resist >= 0.5 then -- There are no quarter or less hits, if target resists more than .5 spell is resisted completely
        -- Calculate potency.
        local potency = utils.clamp(math.floor(dMND / 4) + 15, 5, 25)
        potency = calculatePotency(potency, spell:getSkillType(), caster, target)
        -- Calculate duration.
        -- printf("Duration : %u", duration)
        -- printf("Potency : %u", potency)
        if target:addStatusEffect(params.effect, potency, 0, math.ceil(duration * resist)) then
            spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
        else
            -- no effect
            spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        -- resist
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
    end

    return params.effect
end
