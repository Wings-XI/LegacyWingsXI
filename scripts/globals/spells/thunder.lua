-----------------------------------------
-- Spell: Fire
-- Deals fire damage to an enemy.
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local spellParams = {}
    spellParams.hasMultipleTargetReduction = false
    if caster:getName() == "Shantotto" then
        spellParams.resistBonus = 1.0
        spellParams.V = 472
        spellParams.V0 = 520
        spellParams.V50 = 730
        spellParams.V100 = 915
        spellParams.V200 = 1200
        spellParams.M = 2
        spellParams.M0 = 4.2
        spellParams.M50 = 3.7
        spellParams.M100 = 2.85
        spellParams.M200 = 2
        spellParams.I = 506
    else
        spellParams.resistBonus = 1.0
        spellParams.V = 60
        spellParams.V0 = 85
        spellParams.V50 = 135
        spellParams.V100 = 185
        spellParams.V200 = 185
        spellParams.M = 1
        spellParams.M0 = 1
        spellParams.M50 = 1
        spellParams.M100 = 0
        spellParams.M200 = 0
        spellParams.I = 78
    end

    return doElementalNuke(caster, spell, target, spellParams)
end
