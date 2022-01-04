-----------------------------------------
-- ID: 18152
-- Item: Venom Bolt
-- Additional Effect: Poison
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------

function onAdditionalEffect(player, target, damage)
    local chance = 70
    if (target:getMainLvl() > player:getMainLvl()) then
        chance = chance - 2 * (target:getMainLvl() - player:getMainLvl())
        chance = utils.clamp(chance, 5, 95)
    end
    if (target:hasImmunity(256)) then
        return 0, 0, 0
    elseif (math.random(0, 100) > chance or applyResistanceAddEffect(player, target, tpz.magic.ele.WATER, 0) < 0.5) then
        return 0, 0, 0
    else
        if target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.POISONRES) < 100 then
            if (not target:hasStatusEffect(tpz.effect.POISON)) then
                target:addStatusEffect(tpz.effect.POISON, 4, 3, 30)
            end
            return tpz.subEffect.POISON, tpz.msg.basic.ADD_EFFECT_STATUS, tpz.effect.POISON
        end
    end
end
