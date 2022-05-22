-----------------------------------------
-- ID: 
-- Item: 
-- Additional Effect: 
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/chargedammo")
-----------------------------------

function onAdditionalEffect(player, target, damage)
    return doChargedAmmoAddEffect(player, target, tpz.chargedAmmoType.WIND)
end