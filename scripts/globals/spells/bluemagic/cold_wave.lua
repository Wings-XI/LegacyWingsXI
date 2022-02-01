-----------------------------------------
-- Spell: Cold Wave
-- Deals ice damage that lowers Agility and gradually reduces HP of enemies within range
-- Spell cost: 37 MP
-- Monster Type: Arcana
-- Spell Type: Magical (Ice)
-- Blue Magic Points: 1
-- Stat Bonus: INT-1
-- Level: 52
-- Casting Time: 4 seconds
-- Recast Time: 60 seconds
-- Magic Bursts on: Induration, Distortion, and Darkness
-- Combos: Auto Refresh
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
    local params = {}
    params.eco = ECO_ARCANA
    params.diff = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = caster:getStatusEffect(tpz.effect.CONVERGENCE) == nil and 0 or (caster:getStatusEffect(tpz.effect.CONVERGENCE)):getPower()
    params.effect = nil
    local resist = applyResistanceEffect(caster, target, spell, params)
    
    if target:getStatusEffect(tpz.effect.BURN) ~= nil or target:getStatusEffect(tpz.effect.FROST) ~= nil then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    elseif resist >= 0.5 then
        if target:getStatusEffect(tpz.effect.CHOKE) ~= nil then
            target:delStatusEffect(tpz.effect.CHOKE)
        end
        local BLUlvl = caster:getMainLvl()
        if caster:getMainJob() ~= tpz.job.BLU then BLUlvl = caster:getSubLvl() end
        local power = 3 + math.floor(BLUlvl/5) -- bgwiki
        target:addStatusEffect(tpz.effect.FROST, math.floor(power/3), 9, 90*resist, 0, power*2, 0) -- sadly regen_down is hard-coded to be per-3-seconds regardless of tick, so divide power by 3 for now...
        spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
    end

    return tpz.effect.FROST
end
