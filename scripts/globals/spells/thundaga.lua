-----------------------------------------
-- Spell: Thundaga
-- Deals thunder damage to enemies within area of effect.
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local spellParams = {}
    spellParams.hasMultipleTargetReduction = true
    if caster:getName() == "Shantotto" then
        spellParams.V = 589
        spellParams.V0 = 620
        spellParams.V50 = 830
        spellParams.V100 = 1015
        spellParams.V200 = 1300
        spellParams.M = 1.5
        spellParams.M0 = 4.2
        spellParams.M50 = 3.7
        spellParams.M100 = 2.85
        spellParams.M200 = 2
        spellParams.I = 642
    else
        spellParams.resistBonus = 1.0
        spellParams.V = 172
        spellParams.V0 = 200
        spellParams.V50 = 300
        spellParams.V100 = 375
        spellParams.V200 = 475
        spellParams.M = 1
        spellParams.M0 = 2
        spellParams.M50 = 1.5
        spellParams.M100 = 1
        spellParams.M200 = 0
        spellParams.I = 201
    end

    return doElementalNuke(caster, spell, target, spellParams)
end
