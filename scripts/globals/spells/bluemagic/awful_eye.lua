-----------------------------------------
-- Spell: Awful Eye
-- Lowers Strength of enemies within a fan-shaped area originating from the caster
-- Spell cost: 32 MP
-- Monster Type: Lizards
-- Spell Type: Magical (Water)
-- Blue Magic Points: 2
-- Stat Bonus: MND+1
-- Level: 46
-- Casting Time: 2.5 seconds
-- Recast Time: 60 seconds
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

    if target:hasStatusEffect(tpz.effect.STR_DOWN) or not target:isFacing(caster) then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return tpz.effect.STR_DOWN
    end
    
    local params = {}
    params.attribute = tpz.mod.CHR
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = caster:getStatusEffect(tpz.effect.CONVERGENCE) == nil and 0 or (caster:getStatusEffect(tpz.effect.CONVERGENCE)):getPower()
    params.bonus = params.bonus + caster:getMerit(tpz.merit.MAGICAL_ACCURACY)
    params.effect = nil
    
    local resist = applyResistance(caster, target, spell, params)
    local BLUlvl = caster:getMainLvl()
    if caster:getMainJob() ~= tpz.job.BLU then BLUlvl = caster:getSubLvl() end
    local power = 17 + math.floor(BLUlvl/5)
    
    if resist >= 0.5 then
        spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB)
        target:addStatusEffect(tpz.effect.STR_DOWN, power*resist, 3, 60*resist)
    else
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
    end

    return tpz.effect.STR_DOWN
end
