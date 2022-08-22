-----------------------------------
-- Ability: Desperate Flourish
-- Weighs down a target with a low rate of success. Requires one Finishing Move.
-- Obtained: Dancer Level 30
-- Finishing Moves Used: 1
-- Recast Time: 00:20
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

    local isSneakValid = player:hasStatusEffect(tpz.effect.SNEAK_ATTACK)
    if (isSneakValid and not player:isBehind(target)) then
        isSneakValid = false
    end

    local stepCount = 0
    if (target:hasStatusEffect(tpz.effect.LETHARGIC_DAZE_5)) then
        stepCount = stepCount + 5
    elseif (target:hasStatusEffect(tpz.effect.LETHARGIC_DAZE_4)) then
        stepCount = stepCount + 4
    elseif (target:hasStatusEffect(tpz.effect.LETHARGIC_DAZE_3)) then
        stepCount = stepCount + 3
    elseif (target:hasStatusEffect(tpz.effect.LETHARGIC_DAZE_2)) then
        stepCount = stepCount + 2
    elseif (target:hasStatusEffect(tpz.effect.LETHARGIC_DAZE_1)) then
        stepCount = stepCount + 1
    end
    if (target:hasStatusEffect(tpz.effect.SLUGGISH_DAZE_5)) then
        stepCount = stepCount + 5
    elseif (target:hasStatusEffect(tpz.effect.SLUGGISH_DAZE_4)) then
        stepCount = stepCount + 4
    elseif (target:hasStatusEffect(tpz.effect.SLUGGISH_DAZE_3)) then
        stepCount = stepCount + 3
    elseif (target:hasStatusEffect(tpz.effect.SLUGGISH_DAZE_2)) then
        stepCount = stepCount + 2
    elseif (target:hasStatusEffect(tpz.effect.SLUGGISH_DAZE_1)) then
        stepCount = stepCount + 1
    end
    if (target:hasStatusEffect(tpz.effect.WEAKENED_DAZE_5)) then
        stepCount = stepCount + 5
    elseif (target:hasStatusEffect(tpz.effect.WEAKENED_DAZE_4)) then
        stepCount = stepCount + 4
    elseif (target:hasStatusEffect(tpz.effect.WEAKENED_DAZE_3)) then
        stepCount = stepCount + 3
    elseif (target:hasStatusEffect(tpz.effect.WEAKENED_DAZE_2)) then
        stepCount = stepCount + 2
    elseif (target:hasStatusEffect(tpz.effect.WEAKENED_DAZE_1)) then
        stepCount = stepCount + 1
    end
    if (target:hasStatusEffect(tpz.effect.BEWILDERED_DAZE_5)) then
        stepCount = stepCount + 5
    elseif (target:hasStatusEffect(tpz.effect.BEWILDERED_DAZE_4)) then
        stepCount = stepCount + 4
    elseif (target:hasStatusEffect(tpz.effect.BEWILDERED_DAZE_3)) then
        stepCount = stepCount + 3
    elseif (target:hasStatusEffect(tpz.effect.BEWILDERED_DAZE_2)) then
        stepCount = stepCount + 2
    elseif (target:hasStatusEffect(tpz.effect.BEWILDERED_DAZE_1)) then
        stepCount = stepCount + 1
    end

    -- Give bonus phys and magic acc based on simply the number of steps on the mob
    -- https://ffxiclopedia.fandom.com/wiki/Desperate_Flourish
    stepCount = utils.clamp(stepCount, 0, 4)

    local hitrate = getHitRate(player, target, true, stepCount * 5)
    --GetPlayerByID(1):PrintToPlayer(string.format("phys hit rate: %f",hitrate))
    if (math.random() <= hitrate or isSneakValid) then

        local spell = getSpell(216)
        local params = {}
        params.diff = 0
        params.skillType = player:getWeaponSkillType(tpz.slot.MAIN)
        params.bonus = -10 + stepCount * 10

        local resist = applyResistance(player, target, spell, params)
        local duration = math.ceil(60 * resist * tryBuildResistance(tpz.mod.RESBUILD_GRAVITY, target))
        --GetPlayerByID(1):PrintToPlayer(string.format("magic hit rate: %f",resist))
        if target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.GRAVITYRES) < 100 then
            if resist > 0.25 then
                target:delStatusEffectSilent(tpz.effect.WEIGHT)
                target:addStatusEffect(tpz.effect.WEIGHT, 50, 0, duration)
                ability:setMsg(tpz.msg.basic.JA_ENFEEB_IS)
            else
                ability:setMsg(tpz.msg.basic.JA_MISS)
            end
            action:animation(target:getID(), getFlourishAnimation(player:getWeaponSkillType(tpz.slot.MAIN)))
            action:speceffect(target:getID(), 2)
            return tpz.effect.WEIGHT
        else
            ability:setMsg(tpz.msg.basic.JA_MISS)
            return 0
        end
    else
        ability:setMsg(tpz.msg.basic.JA_MISS)
        return 0
    end
end
