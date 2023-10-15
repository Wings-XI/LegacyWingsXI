-----------------------------------------
-- Spell: Sheep Song
-- Puts all enemies within range to sleep
-- Spell cost: 22 MP
-- Monster Type: Beasts
-- Spell Type: Magical (Light)
-- Blue Magic Points: 2
-- Stat Bonus: CHR+1, HP+5
-- Level: 16
-- Casting Time: Casting Time: 3 seconds
-- Recast Time: Recast Time: 60 seconds
-- Duration: 60 seconds
-- Magic Bursts on: Transfixion, Fusion, and Light
-- Combos: Auto Regen
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

    if target:getMod(tpz.mod.STATUSRES) >= 100 or target:getMod(tpz.mod.LULLABYRES) >= 100 then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return tpz.effect.SLEEP_I
    end
    
    local params = {}
    params.eco = ECO_BEAST
    params.diff = caster:getStat(tpz.mod.CHR) - target:getStat(tpz.mod.CHR)
    params.attribute = tpz.mod.CHR
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = caster:getStatusEffect(tpz.effect.CONVERGENCE) == nil and 0 or (caster:getStatusEffect(tpz.effect.CONVERGENCE)):getPower()
    params.effect = tpz.effect.LULLABY
    params.bonus = params.bonus + caster:getMerit(tpz.merit.MAGICAL_ACCURACY)
    local resist = applyResistanceEffect(caster, target, spell, params)
    -- reset for documentation of which effect is applied, but the above function uses dark sleep restrait if you pass sleep_II
    -- effect is applied below
    params.effect = tpz.effect.SLEEP_I
    
    local duration = math.ceil(60 * resist * tryBuildResistance(tpz.mod.RESBUILD_LULLABY, target))
    
    if target:hasStatusEffect(tpz.effect.SLEEP_I) or target:hasStatusEffect(tpz.effect.SLEEP_II) or target:hasStatusEffect(tpz.effect.LULLABY) then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    elseif resist >= 0.5 then
        if target:addStatusEffect(tpz.effect.SLEEP_I, 1, 0, duration) then
            spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
    end

    return tpz.effect.SLEEP_I
end
