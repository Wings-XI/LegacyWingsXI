-----------------------------------------
-- ID: 15754
-- Item: Sprinter's Shoes
-- Item Effect: Quickening for 60 minutes
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/msg")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
   if(target:addStatusEffect(tpz.effect.QUICKENING, 12, 0, 3600)) then
        target:messageBasic(tpz.msg.basic.GAINS_EFFECT_OF_STATUS, tpz.effect.QUICKENING)
    else
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    end
end
