-----------------------------------
-- Howling Fist
-- Hand-to-Hand weapon skill
-- Skill Level: 200
-- Damage varies with TP.
-- Will stack with Sneak Attack.
-- Ignores some defense.
-- Aligned with the Light Gorget & Thunder Gorget.
-- Aligned with the Light Belt & Thunder Belt.
-- Element: None
-- Modifiers: STR:20%  VIT:50%
-- 100%TP    200%TP    300%TP
-- 2.50      2.75      3.00
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.numHits = 2
    params.ftp100 = 2.5 params.ftp200 = 2.75 params.ftp300 = 3
    params.str_wsc = 0.2 params.dex_wsc = 0.0 params.vit_wsc = 0.5 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200= 0.0 params.acc300= 0.0
    -- Physical WS/Attack Power Modification
    -- https://w.atwiki.jp/studiogobli/pages/93.html
    -- ignores def via attack x1.5 (exactly like ascetic's fury)
    params.atk100 = 1.5; params.atk200 = 1.5; params.atk300 = 1.5

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.ftp200 = 4.75 params.ftp300 = 8
        params.str_wsc = 0.2 params.dex_wsc = 0.5 params.vit_wsc = 0.0
    end

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
	if damage > 0 then player:trySkillUp(target, tpz.skill.HAND_TO_HAND, tpHits+extraHits) end
	if damage > 0 then target:tryInterruptSpell(player, tpHits+extraHits) end
    return tpHits, extraHits, criticalHit, damage

end
