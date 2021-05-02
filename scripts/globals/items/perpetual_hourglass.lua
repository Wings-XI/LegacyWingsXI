-----------------------------------------
-- 
-- Item: Perpetual Hourglass
-- 
-----------------------------------------
require("scripts/globals/msg")

function onItemCheck(target, param, caster, item)
    return target:canReplicateHourglass(item)
end

function onItemUse(target, item)
    target:replicateHourglass(item)
end