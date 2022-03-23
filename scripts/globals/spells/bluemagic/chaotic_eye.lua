-----------------------------------------
-- Spell: Chaotic Eye
-- Silences an enemy
-- Spell cost: 13 MP
-- Monster Type: Beasts
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 2
-- Stat Bonus: AGI+1
-- Level: 32
-- Casting Time: 3 seconds
-- Recast Time: 10 seconds
-- Magic Bursts on: Detonation, Fragmentation, and Light
-- Combos: Conserve MP
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)

    if target:getMod(tpz.mod.STATUSRES) >= 100 or target:getMod(tpz.mod.SILENCERES) >= 100 then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return tpz.effect.SILENCE
    end
    
    local params = {}
    params.eco = ECO_BEAST
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = caster:getStatusEffect(tpz.effect.CONVERGENCE) == nil and 0 or (caster:getStatusEffect(tpz.effect.CONVERGENCE)):getPower()
    params.bonus = params.bonus + caster:getMerit(tpz.merit.MAGICAL_ACCURACY)
    params.effect = tpz.effect.SILENCE
    
    local resist = applyResistanceEffect(caster, target, spell, params)
    -- Per wiki "Roughly equivalent to the Enfeebling Magic spell, Silence."
    -- Per bgwiki - 5-120 seconds
    local duration = math.ceil(120 * resist * tryBuildResistance(tpz.mod.RESBUILD_SILENCE, target))
    if resist >= 0.5 then
        if target:isFacing(caster) then
            if target:addStatusEffect(tpz.effect.SILENCE, 1, 0, duration*resist) then
                spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
            else
                spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
            end
        else
            spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
    end

    return tpz.effect.SILENCE
end
