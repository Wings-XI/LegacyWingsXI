-----------------------------------------
-- Spell: Blind
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

    if target:getMod(tpz.mod.STATUSRES) >= 100 or target:getMod(tpz.mod.BLINDRES) >= 100 then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return tpz.effect.BLINDNESS
    end

    -- Pull base stats.
    local dINT = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.MND) -- blind uses caster INT vs target MND

    -- Base power
    -- Min cap: 5 at -80 dINT
    -- Max cap: 50 at 120 dINT
    -- Formula changed to era formula (http://wiki.ffo.jp/wiki.cgi?Command=HDetail&articleid=129310&id=834)
    local basePotency = math.floor((dINT + 60) / 4)
    local potency = calculatePotency(basePotency, spell:getSkillType(), caster, target)

    local params = {}
    params.diff = dINT
    params.skillType = tpz.skill.ENFEEBLING_MAGIC
    params.bonus = 0
    params.effect = tpz.effect.BLINDNESS
    local resist = applyResistanceEffect(caster, target, spell, params)
    
    local calcDuration = calculateDuration(180, spell:getSkillType(), spell:getSpellGroup(), caster, target)
    local duration = math.ceil(calcDuration * resist * tryBuildResistance(tpz.mod.RESBUILD_BLIND, target))
    if resist >= 0.5 then --Do it!
        -- Duration, including resistance.  Unconfirmed.
        if target:addStatusEffect(params.effect, potency, 0 , duration) then
            spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
    end

    return params.effect
end
