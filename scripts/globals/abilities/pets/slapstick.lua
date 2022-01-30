---------------------------------------------------
-- Slapstick
---------------------------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/automatonweaponskills")

---------------------------------------------------

function onMobSkillCheck(target, automaton, skill)
    local master = automaton:getMaster()
    return master:countEffect(tpz.effect.THUNDER_MANEUVER)
end

function onPetAbility(target, automaton, skill, master, action)
    local params = {
        numHits = 3,
        atkmulti = 1,
        damageType = tpz.damageType.BLUNT,
        ftp100 = 1.5,
        ftp200 = 2.0,
        ftp300 = 3.0,
        acc100 = 0.0,
        acc200 = 0.0,
        acc300 = 0.0,
        str_wsc = 0.3,
        dex_wsc = 0.3,
        vit_wsc = 0.0,
        agi_wsc = 0.0,
        int_wsc = 0.0,
        mnd_wsc = 0.0,
        chr_wsc = 0.0
    }

    if USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftp100 = 2.66
        params.ftp200 = 2.66
        params.ftp300 = 2.66
        params.accBonus = 0.04 * skill:getTP()
    end

    local damage, criticalHit, tpHits, extraHits = doAutoPhysicalWeaponskill(automaton, target, 0, skill:getTP(), true, action, false, params, skill)
    if damage > 0 then
        master:trySkillUp(target, tpz.skill.AUTOMATON_MELEE, tpHits+extraHits)
        target:tryInterruptSpell(automaton, tpHits+extraHits)
    end
    return damage
end
