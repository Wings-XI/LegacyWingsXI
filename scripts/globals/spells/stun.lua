-----------------------------------------
-- Spell: Stun
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)

    if target:getMod(tpz.mod.STATUSRES) >= 100 or target:getMod(tpz.mod.STUNRES) >= 100 then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return tpz.effect.STUN
    end

    local duration = 5

    local params = {}
    params.diff = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.DARK_MAGIC
    params.bonus = 0
    params.effect = tpz.effect.STUN
    local resist = applyResistanceEffect(caster, target, spell, params)
    duration = math.ceil(duration * resist * tryBuildResistance(tpz.mod.RESBUILD_STUN, target))
    if (resist <= (1/16)) then
        -- resisted!
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
        return 0
    end

    if (target:hasStatusEffect(tpz.effect.STUN)) then
        -- no effect
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    else
        if (target:addStatusEffect(tpz.effect.STUN, 1, 0, duration)) then
            spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        end
    end

    return tpz.effect.STUN
end
