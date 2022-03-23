-----------------------------------------
-- Spell: Blind II
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
    -- Min cap: 15 at -80 dINT
    -- Max cap: 90 at 120 dINT
    -- +1 Effect/merit sources: (https://ffxiclopedia.fandom.com/wiki/Blind_II?oldid=880850)
    local merits = caster:getMerit(tpz.merit.BLIND_II)
    -- Formula changed to an era formula (http://wiki.ffo.jp/wiki.cgi?Command=HDetail&articleid=82951&id=3449)
    local potency = math.floor(((dINT + 100)/4) + merits)

    potency = calculatePotency(potency, spell:getSkillType(), caster, target)
    
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
        if target:addStatusEffect(params.effect, potency, 0, duration) then
            spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
    end

    return params.effect
end
