-----------------------------------------
-- Spell: Banish II
-- Deals light damage to an enemy.
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    --doDivineBanishNuke(V, M, caster, spell, target, hasMultipleTargetReduction, resistBonus)
    local params = {}
    params.dmg = 85
    params.multiplier = 1
    params.hasMultipleTargetReduction = false
    params.resistBonus = 1.0
    dmg = doDivineBanishNuke(caster, target, spell, params)
    
    -- special defense down, 50% I, 70% II, 97% III
    if target:isUndead() and target:getMod(tpz.mod.SPDEF_DOWN) == 0 then
        local duration = 30 + caster:getMerit(tpz.merit.BANISH_EFFECT)
        target:queue(0, function(target)
            target:addMod(tpz.mod.SPDEF_DOWN,70)
        end)
        target:queue(duration*1000, function(target)
            target:setMod(tpz.mod.SPDEF_DOWN,0)
        end)
    end
    
    return dmg
end
