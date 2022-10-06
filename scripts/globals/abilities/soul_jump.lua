-----------------------------------
-- Ability: Soul Jump
-- Description: Delivers a high jumping attack on a targeted enemy which suppresses enmity. Effect enhanced when wyvern is present.
-- Obtained: DRG Level 85
-- Recast Time: 2:00
-----------------------------------
require("scripts/globals/weaponskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability, action)
    -- Reduce 99% of total accumulated enmity
    if target:isMob() then
        target:lowerEnmity(player, 99)
    end
    local params = {}
    params.numHits = 1
    local ftp = 1
    params.ftp100 = ftp
    params.ftp200 = ftp
    params.ftp300 = ftp
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    params.crit100 = 0.0
    params.crit200 = 0.0
    params.crit300 = 0.0
    if (player:getMod(tpz.mod.FORCE_JUMP_CRIT) > 0) then
        params.crit100 = 1.0
        params.crit200 = 1.0
        params.crit300 = 1.0
    end
    params.canCrit = true
    params.acc100 = 0.0
    params.acc200 = 0.0
    params.acc300 = 0.0
    params.atk100 = 1
    params.atk200 = 1
    params.atk300 = 1
    params.bonusTP = player:getMod(tpz.mod.JUMP_TP_BONUS)
    params.targetTPMult = 0
    params.hitsHigh = true
    params.preserveBuildingFlourish = true

    if (target:isMob()) then
        local enmityShed = 50
        if player:getMainJob() ~= tpz.job.DRG then
            enmityShed = 30
        end
    end

    local taChar = player:getTrickAttackChar(target)

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, 0, params, 0, action, true, taChar)

    if (tpHits + extraHits > 0) then
        if (criticalHit) then
            action:speceffect(target:getID(), 38)
        end
        action:messageID(target:getID(), tpz.msg.basic.USES_JA_TAKE_DAMAGE)
        action:speceffect(target:getID(), 32)
    else
        action:messageID(target:getID(), tpz.msg.basic.JA_MISS_2)
        action:speceffect(target:getID(), 0)
    end

    return damage
end
