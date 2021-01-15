-----------------------------------------
-- Spell: Repose
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local dMND = (caster:getStat(tpz.mod.MND) - target:getStat(tpz.mod.MND))
    local params = {}
    params.diff = nil
    params.attribute = tpz.mod.MND
    params.skillType = tpz.skill.DIVINE_MAGIC
    params.bonus = 0
    params.effect = tpz.effect.SLEEP_II
    local resist = applyResistanceEffect(caster, target, spell, params)
    local duration = 90 * resist
    duration = math.ceil(duration * tryBuildResistance(tpz.magic.buildcat.LULLABY, target))
    
    -- Lii Jixa the Somnolist
    if caster:isMob() and caster:getID() == 17395896 and resist > 0.0625 and math.random() < 0.98 then
        resist = 1
        duration = 90
    end
    
    if (resist < 0.5) then
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST) -- Resist
        return tpz.effect.SLEEP_II
    end

    if (target:addStatusEffect(tpz.effect.SLEEP_II, 2, 0, duration)) then
        spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB)
    else
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT) -- No effect
    end

    return tpz.effect.SLEEP_II
end
