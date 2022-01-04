-----------------------------------
-- Tachi Hobaku
-- Great Katana weapon skill
-- Skill Level: 30
-- Stuns enemy. Chance of stun varies with TP.
-- Will stack with Sneak Attack.
-- Aligned with the Snow Gorget.
-- Aligned with the Snow Belt.
-- Element: None
-- Modifiers: STR:60%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.numHits = 1
    params.ftp100 = 1 params.ftp200 = 1 params.ftp300 = 1
    params.str_wsc = 0.3 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200= 0.0 params.acc300= 0.0
    params.atk100 = 1; params.atk200 = 1; params.atk300 = 1

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.str_wsc = 0.6
    end

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    local chance = (tp - 1000) * applyResistanceAddEffect(player, target, tpz.magic.ele.LIGHTNING, 0) > math.random() * 150
    if target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.STUNRES) < 100 then
        if (damage > 0 and chance) then
            if (target:hasStatusEffect(tpz.effect.STUN) == false) then
                target:addStatusEffect(tpz.effect.STUN, 1, 0, 4)
            end
        elseif damage > 0 and target:hasStatusEffect(tpz.effect.STUN) == false and target:getMod(tpz.mod.SUSC_TO_WS_STUN) == 1 then
            target:addStatusEffect(tpz.effect.STUN, 1, 0, math.random(2,4))
        end
    end
    if damage > 0 then player:trySkillUp(target, tpz.skill.GREAT_KATANA, tpHits+extraHits) end
	if damage > 0 then target:tryInterruptSpell(player, tpHits+extraHits) end
    return tpHits, extraHits, criticalHit, damage

end
