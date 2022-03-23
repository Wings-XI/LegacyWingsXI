-----------------------------------------
-- Spell: Venom Shell
-- Poisons enemies within range and gradually reduces their HP
-- Spell cost: 86 MP
-- Monster Type: Aquans
-- Spell Type: Magical (Water)
-- Blue Magic Points: 3
-- Stat Bonus: MND+2
-- Level: 42
-- Casting Time: 3 seconds
-- Recast Time: 45 seconds
-- Magic Bursts on: Reverberation, Distortion, and Darkness
-- Combos: Clear Mind
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

    if target:getMod(tpz.mod.STATUSRES) >= 100 or target:getMod(tpz.mod.POISONRES) >= 100 then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return tpz.effect.POISON
    end

    local params = {}
    params.eco = ECO_AQUAN
    params.diff = nil
    params.attribute = tpz.mod.MND
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = caster:getStatusEffect(tpz.effect.CONVERGENCE) == nil and 0 or (caster:getStatusEffect(tpz.effect.CONVERGENCE)):getPower()
    params.effect = tpz.effect.POISON
    params.bonus = params.bonus + caster:getMerit(tpz.merit.MAGICAL_ACCURACY)
    local resist = applyResistanceEffect(caster, target, spell, params)
    local duration = math.ceil(180 * tryBuildResistance(tpz.mod.RESBUILD_POISON, target)) 
    
    if target:hasStatusEffect(tpz.effect.POISON) then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    elseif resist >= 0.5 then
        local power = caster:getMainLvl() > 50 and 6 or 5
        if target:addStatusEffect(tpz.effect.POISON, power, 0, duration*resist) then
            spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
    end

    return tpz.effect.POISON
end
