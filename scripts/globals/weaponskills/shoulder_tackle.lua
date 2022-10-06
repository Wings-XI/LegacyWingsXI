-----------------------------------
-- Shoulder Tackle
-- Hand-to-Hand weapon skill
-- Skill Level: 40
-- Stuns target. Chance of stunning varies with TP.
-- Will stack with Sneak Attack.
-- Aligned with the Aqua Gorget & Thunder Gorget.
-- Aligned with the Aqua Belt & Thunder Belt.
-- Element: None
-- Modifiers: VIT:100%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.numHits = 1 -- all h2h weaponskills less than 3 hits are really numHits == 1 with a bonus offhand hit
    params.ftp100 = 1 params.ftp200 = 1 params.ftp300 = 1
    params.str_wsc = 0.0 params.dex_wsc = 0.0 params.vit_wsc = 0.3 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200= 0.0 params.acc300= 0.0
    params.atk100 = 1; params.atk200 = 1; params.atk300 = 1
    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.vit_wsc = 1.0
    end
    if target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.STUNRES) < 100 then
        if (damage > 0 and target:hasStatusEffect(tpz.effect.STUN) == false) then
            local duration = (tp/500) * applyResistanceAddEffect(player, target, tpz.magic.ele.LIGHTNING, 0)
            target:addStatusEffect(tpz.effect.STUN, 1, 0, duration)
        elseif damage > 0 and target:hasStatusEffect(tpz.effect.STUN) == false and target:getMod(tpz.mod.SUSC_TO_WS_STUN) == 1 then
            target:addStatusEffect(tpz.effect.STUN, 1, 0, math.random(2,4))
        end
    end
    if damage > 0 then player:trySkillUp(target, tpz.skill.HAND_TO_HAND, tpHits+extraHits) end
	if damage > 0 then target:tryInterruptSpell(player, tpHits+extraHits) end
    return tpHits, extraHits, criticalHit, damage

end
