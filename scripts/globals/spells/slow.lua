-----------------------------------------
-- Spell: Slow
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

    if target:hasStatusEffect(tpz.effect.HASTE) then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return tpz.effect.SLOW
    end

    if target:getMod(tpz.mod.STATUSRES) >= 100 or target:getMod(tpz.mod.SLOWRES) >= 100 then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return tpz.effect.SLOW
    end

    local dMND = caster:getStat(tpz.mod.MND) - target:getStat(tpz.mod.MND)
    
    local params = {}
    params.diff = dMND
    params.skillType = tpz.skill.ENFEEBLING_MAGIC
    params.bonus = 0
    params.effect = tpz.effect.SLOW
    local resist = applyResistanceEffect(caster, target, spell, params)
    
    local calcDuration = calculateDuration(180, spell:getSkillType(), spell:getSpellGroup(), caster, target)
    local duration = math.ceil(calcDuration * resist * tryBuildResistance(tpz.mod.RESBUILD_SLOW, target))
    
        if resist >= 0.5 then --Do it!
            -- Lowest ~7.3%
            -- Highest ~29.2%
            local power = utils.clamp(math.floor(dMND * 73 / 5) + 1825, 730, 2920)
            power = calculatePotency(power, spell:getSkillType(), caster, target)
        
            if target:addStatusEffect(params.effect, power, 0, duration, 0, 1) then
                spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
            else
                spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
            end
        else
            spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
        end

    return params.effect
end
