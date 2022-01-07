-----------------------------------------
-- ID: 18040
-- Item: Webcutter
-- Additional Effect: Stuns Vermin
-- THANKS FARTHEKILLER!
----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------

function onAdditionalEffect(player,target,damage)
    if target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.STUNRES) < 100 then
        if target:getSystem() == tpz.ecosystem.VERMIN then
            local chance = 15
            if math.random(100) <= chance and applyResistanceAddEffect(player,target,tpz.magic.ele.LIGHTNING,0) > 0.5 then
                target:addStatusEffect(tpz.effect.STUN, 2, 0, 3)
                return tpz.subEffect.STUN, tpz.msg.basic.ADD_EFFECT_STATUS, tpz.effect.STUN
            end
        end
        return 0, 0, 0
    end
end