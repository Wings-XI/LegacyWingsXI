-----------------------------------------
-- ID: 18149
-- Item: Sleep Bolt
-- Additional Effect: Sleep
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onAdditionalEffect(player, target, damage)
    local chance = 70
    local resist = applyResistanceAddEffect(player,target,tpz.magic.ele.LIGHT,0)
    if (target:getMainLvl() > player:getMainLvl()) then
        chance = chance - 2 * (target:getMainLvl() - player:getMainLvl())
        chance = utils.clamp(chance, 5, 95)
    end
    if ((math.random(0, 100) > chance) or (resist < 0.5)) then
        return 0, 0, 0
    elseif target:getMod(tpz.mod.STATUSRES) >= 100 or target:getMod(tpz.mod.SLEEPRES) >= 100 then
        return 0, 0, 0
    else
        local duration = math.random(15, 30) * tryBuildResistance(tpz.mod.RESBUILD_SLEEP, target)
        if not (target:hasStatusEffect(tpz.effect.SLEEP_I) or target:hasStatusEffect(tpz.effect.SLEEP_II) or target:hasStatusEffect(tpz.effect.LULLABY)) then
            if (target:getMainLvl() > player:getMainLvl()) then
                duration = duration - (target:getMainLvl() - player:getMainLvl())
            end
            duration = utils.clamp(duration, 2, 22)
            duration = math.ceil(duration * resist)
            target:addStatusEffect(tpz.effect.SLEEP_I, 1, 0, duration)
        end
        return tpz.subEffect.SLEEP, tpz.msg.basic.ADD_EFFECT_STATUS, tpz.effect.SLEEP_I
    end
end
