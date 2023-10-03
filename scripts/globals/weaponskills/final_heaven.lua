-------------------------------
-- Skill: Final Heaven
-- Hand-to-Hand weapon skill
-- Skill Level N/A
-- Additional effect: temporarily enhances Subtle Blow tpz.effect.
-- Mods : VIT:60%
-- 100%TP     200%TP     300%TP
-- 3.0x        3.0x    3.0x
-- +10 Subtle Blow for a short duration after using the weapon skill. (Not implemented)
-------------------------------
require("scripts/globals/aftermath")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/weaponskills")
-------------------------------
function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    -- number of normal hits for ws
    params.numHits = 1 -- all h2h weaponskills less than 3 hits are really numHits == 1 with a bonus offhand hit
    -- stat-modifiers (0.0 = 0%, 0.2 = 20%, 0.5 = 50%..etc)
    params.str_wsc = 0.0        params.dex_wsc = 0.0
    params.vit_wsc = 0.6        params.agi_wsc = 0.0
    params.int_wsc = 0.0        params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    -- ftp damage mods (for Damage Varies with TP lines are calculated in the function params.ftp)
    params.ftp100 = 3.0 params.ftp200 = 3.0 params.ftp300 = 3.0
    -- critical modifiers (0.0 = 0%, 0.2 = 20%, 0.5 = 50%..etc)
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    -- accuracy modifiers (0.0 = 0%, 0.2 = 20%, 0.5 = 50%..etc) Keep 0 if ws doesn't have accuracy modification.
    params.acc100 = 0.0 params.acc200 = 0.0 params.acc300 = 0.0
    -- attack multiplier (only some WSes use this, this varies the actual ratio value, see Tachi: Kasha) 1 is default.
    params.atk100 = 1; params.atk200 = 1; params.atk300 = 1

    if USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.vit_wsc = 0.8
    end

    -- Apply aftermath
    tpz.aftermath.addStatusEffect(player, tp, tpz.slot.MAIN, tpz.aftermath.type.RELIC)

    -- damage = damage * ftp(tp, ftp100, ftp200, ftp300)
    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

	if damage > 0 then player:trySkillUp(target, tpz.skill.HAND_TO_HAND, tpHits+extraHits) end
	if damage > 0 then target:tryInterruptSpell(player, tpHits+extraHits) end
    return tpHits, extraHits, criticalHit, damage
end
