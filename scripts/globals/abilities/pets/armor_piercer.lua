---------------------------------------------------
-- Armor Piercer
---------------------------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/automatonweaponskills")

---------------------------------------------------

function onMobSkillCheck(target, automaton, skill)
    local master = automaton:getMaster()
    return master:countEffect(tpz.effect.DARK_MANEUVER)
end

function onPetAbility(target, automaton, skill, master, action)
    local params = {
        numHits = 1,
        atkmulti = 1.0,
        accBonus = 100,
        ftp100 = 4.0,
        ftp200 = 4.5,
        ftp300 = 5.0,
        acc100 = 0.0,
        acc200 = 0.0,
        acc300 = 0.0,
        ignoresDef = true,
        ignored100 = 0.5,
        ignored200 = 0.5,
        ignored300 = 0.5,
        str_wsc = 0.0,
        dex_wsc = 0.0,
        vit_wsc = 0.0,
        agi_wsc = 0.0,
        int_wsc = 0.0,
        mnd_wsc = 0.0,
        chr_wsc = 0.0
    }

    if USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftp100 = 4.0
        params.ftp200 = 5.5
        params.ftp300 = 7.0
        params.ignored100 = 0.5
        params.ignored200 = 0.5
        params.ignored300 = 0.5
    end

    local damage, criticalHit, tpHits, extraHits = doAutoRangedWeaponskill(automaton, target, 0, params, skill:getTP(), true, skill, action)
    if damage > 0 then
        master:trySkillUp(target, tpz.skill.AUTOMATON_RANGED, tpHits+extraHits)
        target:tryInterruptSpell(automaton, tpHits+extraHits)
    end
    return damage
end
