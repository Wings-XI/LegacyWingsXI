-----------------------------------------
--
-- Spell: Auspice
--
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/status")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local subPowerCarryOver = 0
    local misery = target:getStatusEffect(tpz.effect.AFFLATUS_MISERY)
    if misery ~= nil then
        subPowerCarryOver = misery:getSubPower()
    end
    
    local effect = tpz.effect.AUSPICE
    doEnspell(caster, target, spell, effect)
    
    if misery ~= nil then
        target:addMod(tpz.mod.ACC, subPowerCarryOver)
        misery:setSubPower(subPowerCarryOver)
    end
    
    return effect
end
