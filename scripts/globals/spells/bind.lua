-----------------------------------------
-- Spell: Bind
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)

    if target:getMod(tpz.mod.STATUSRES) >= 100 or target:getMod(tpz.mod.BINDRES) >= 100 then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return tpz.effect.BIND
    end

    -- Pull base stats.
    local dINT = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)

    -- Resist
    local params = {}
    params.diff = dINT
    params.skillType = tpz.skill.ENFEEBLING_MAGIC
    params.bonus = 0
    params.effect = tpz.effect.BIND
    local resist = applyResistanceEffect(caster, target, spell, params)
    
    local calcDuration = calculateDuration(60, spell:getSkillType(), spell:getSpellGroup(), caster, target)
    local duration = math.ceil(calcDuration * resist * tryBuildResistance(tpz.mod.RESBUILD_BIND, target))
    if resist >= 0.5 then --Do it!
        -- Duration, including resistance.  May need more research.
        --Try to erase a weaker bind.
        if target:addStatusEffect(params.effect, target:speed(), 0 , duration) then
            spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
    end

    return params.effect
end
