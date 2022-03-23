-----------------------------------------
-- Spell: Soporific
-- Puts all enemies within range to sleep
-- Spell cost: 38 MP
-- Monster Type: Plantoids
-- Spell Type: Magical (Dark)
-- Blue Magic Points: 4
-- Stat Bonus: HP-5, MP+5
-- Level: 24
-- Casting Time: 3 seconds
-- Recast Time: 90 seconds
-- Duration: 90 seconds
-- Magic Bursts on: Compression, Gravitation, and Darkness
-- Combos: Clear Mind
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    if target:isUndead() and target:getFamily() ~= 52 and target:getFamily() ~= 121 then -- non-ghost undead
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
        return tpz.effect.SLEEP_I
    end

    if target:getMod(tpz.mod.STATUSRES) >= 100 or target:getMod(tpz.mod.SLEEPRES) >= 100 then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return tpz.effect.SLEEP_I
    end

    local params = {}
    params.diff = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = caster:getStatusEffect(tpz.effect.CONVERGENCE) == nil and 0 or (caster:getStatusEffect(tpz.effect.CONVERGENCE)):getPower()
    params.bonus = params.bonus + caster:getMerit(tpz.merit.MAGICAL_ACCURACY)
    params.effect = tpz.effect.SLEEP_I
    local resist = applyResistanceEffect(caster, target, spell, params)
    
    local duration = math.ceil(90 * resist * tryBuildResistance(tpz.mod.RESBUILD_SLEEP, target))
    
    if target:hasStatusEffect(tpz.effect.SLEEP_I) or target:hasStatusEffect(tpz.effect.SLEEP_II) or target:hasStatusEffect(tpz.effect.LULLABY) then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    elseif resist >= 0.5 then
        if target:addStatusEffect(tpz.effect.SLEEP_I, 2, 0, duration) then
            spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
    end

    return tpz.effect.SLEEP_I
end
