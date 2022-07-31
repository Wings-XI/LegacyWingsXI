-----------------------------------
-- Ability: Violent Flourish
-- Stuns target with a low rate of success. Requires one Finishing Move.
-- Obtained: Dancer Level 45
-- Finishing Moves Used: 1
-- Recast Time: 0:20
-- Duration: ??
-----------------------------------
require("scripts/globals/weaponskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    if (player:getAnimation() ~= 1) then
        return tpz.msg.basic.REQUIRES_COMBAT, 0
    elseif
        player:hasStatusEffect(tpz.effect.FINISHING_MOVE_1) or
        player:hasStatusEffect(tpz.effect.FINISHING_MOVE_2) or
        player:hasStatusEffect(tpz.effect.FINISHING_MOVE_3) or
        player:hasStatusEffect(tpz.effect.FINISHING_MOVE_4) or
        player:hasStatusEffect(tpz.effect.FINISHING_MOVE_5)
    then
        return 0, 0
    else
        return tpz.msg.basic.NO_FINISHINGMOVES, 0
    end
end

function onUseAbility(player, target, ability, action)

    if (player:hasStatusEffect(tpz.effect.FINISHING_MOVE_1)) then
        player:delStatusEffect(tpz.effect.FINISHING_MOVE_1)
    elseif (player:hasStatusEffect(tpz.effect.FINISHING_MOVE_2)) then
        player:delStatusEffectSilent(tpz.effect.FINISHING_MOVE_2)
        player:addStatusEffect(tpz.effect.FINISHING_MOVE_1, 1, 0, 7200)
    elseif (player:hasStatusEffect(tpz.effect.FINISHING_MOVE_3)) then
        player:delStatusEffectSilent(tpz.effect.FINISHING_MOVE_3)
        player:addStatusEffect(tpz.effect.FINISHING_MOVE_2, 1, 0, 7200)
    elseif (player:hasStatusEffect(tpz.effect.FINISHING_MOVE_4)) then
        player:delStatusEffectSilent(tpz.effect.FINISHING_MOVE_4)
        player:addStatusEffect(tpz.effect.FINISHING_MOVE_3, 1, 0, 7200)
    elseif (player:hasStatusEffect(tpz.effect.FINISHING_MOVE_5)) then
        player:delStatusEffectSilent(tpz.effect.FINISHING_MOVE_5)
        player:addStatusEffect(tpz.effect.FINISHING_MOVE_4, 1, 0, 7200)
    end

    local hit = 4

    local params = {}
    params.numHits = 1
    local ftp = 1
    params.ftp100 = ftp params.ftp200 = ftp params.ftp300 = ftp
    params.str_wsc = 0.0 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = true
    params.acc100 = 0.0 params.acc200= 0.0 params.acc300= 0.0
    local atkmulti = 1
    params.atk100 = atkmulti params.atk200 = atkmulti params.atk300 = atkmulti
    params.hitsHigh = false
    params.useOAXTimes = false
    params.preserveBuildingFlourish = true

    local taChar = player:getTrickAttackChar(target)
    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, 0, params, 0, action, true, taChar)

    if (tpHits + extraHits > 0) then
        hit = 3

        local spell = getSpell(252)
        local params = {}
        params.diff = 0
        params.skillType = player:getWeaponSkillType(tpz.slot.MAIN)
        params.bonus = 50 - target:getMod(tpz.mod.STUNRES) + player:getMod(tpz.mod.VFLOURISH_MACC)
        local resist = applyResistance(player, target, spell, params)
        if target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.STUNRES) < 100 then
            if resist > 0.25 then
                target:addStatusEffect(tpz.effect.STUN, 1, 0, 2)
                tryBuildResistance(tpz.mod.RESBUILD_STUN, target)
                action:messageID(target:getID(), tpz.msg.basic.JA_DAMAGE_AND_STUN)
            else
                action:messageID(target:getID(), tpz.msg.basic.JA_DAMAGE)
            end
        else
            action:messageID(target:getID(), tpz.msg.basic.JA_DAMAGE)
        end

        action:animation(target:getID(), getFlourishAnimation(player:getWeaponSkillType(tpz.slot.MAIN)))
        action:speceffect(target:getID(), hit)
        if target:getID() == (17449008) then
            return 0
        else
            return damage
        end
    else
        action:messageID(target:getID(), tpz.msg.basic.JA_MISS_2)
        action:speceffect(target:getID(), 0)
        return 0
    end
end