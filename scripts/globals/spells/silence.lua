-----------------------------------------
-- Spell: Silence
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)

    if target:getMod(tpz.mod.STATUSRES) >= 100 or target:getMod(tpz.mod.SILENCERES) >= 100 then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return tpz.effect.SILENCE
    end

    local dMND = (caster:getStat(tpz.mod.MND) - target:getStat(tpz.mod.MND))
    
    --Resist
    local params = {}
    params.diff = dMND
    params.skillType = tpz.skill.ENFEEBLING_MAGIC
    params.bonus = 0
    params.effect = tpz.effect.SILENCE
    local resist = applyResistanceEffect(caster, target, spell, params)
    
    local calcDuration = calculateDuration(120, spell:getSkillType(), spell:getSpellGroup(), caster, target)
    local duration = math.ceil(calcDuration * resist * tryBuildResistance(tpz.mod.RESBUILD_SILENCE, target))
    if resist >= 0.5 then --Do it!
        if target:addStatusEffect(params.effect, 1, 0, duration) then
            spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT) -- no effect
        end
    else
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
    end

    return params.effect
end
