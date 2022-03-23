-----------------------------------------
-- Spell: Sleep
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)

    if target:isUndead() and target:getFamily() ~= 52 and target:getFamily() ~= 121 then -- non-ghost undead
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return tpz.effect.SLEEP_I
    end

    if target:getMod(tpz.mod.STATUSRES) >= 100 or target:getMod(tpz.mod.SLEEPRES) >= 100 then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return tpz.effect.SLEEP_I
    end

    local dINT = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    
    local params = {}
    params.diff = dINT
    params.skillType = tpz.skill.ENFEEBLING_MAGIC
    params.bonus = 0
    params.effect = tpz.effect.SLEEP_I
    local resist = applyResistanceEffect(caster, target, spell, params)
    
    local calcDuration = calculateDuration(60, spell:getSkillType(), spell:getSpellGroup(), caster, target)
    local duration = math.ceil(calcDuration * resist * tryBuildResistance(tpz.mod.RESBUILD_SLEEP, target))
    if resist >= 0.5 then
        if target:addStatusEffect(params.effect, 1, 0, duration) then
            spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
    end

    return params.effect
end
