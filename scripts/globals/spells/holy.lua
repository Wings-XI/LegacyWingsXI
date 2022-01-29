-----------------------------------------
-- Spell: Holy
-- Deals light damage to an enemy.
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    -- doDivineNuke(V, M, caster, spell, target, hasMultipleTargetReduction, resistBonus)
    local params = {}
    params.dmg = 125
    params.multiplier = 1
    params.hasMultipleTargetReduction = false
    params.resistBonus = 0
    if caster:hasStatusEffect(tpz.effect.AFFLATUS_SOLACE) then
        local solace = caster:getLocalVar("SolaceCureRecording")
        local dmgmult = 1 + solace / 589
        params.dmg = params.dmg * dmgmult
        caster:setLocalVar("SolaceCureRecording",0)
    end
    dmg = doDivineNuke(caster, target, spell, params)
    return dmg
end
