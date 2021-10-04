-----------------------------------
-- Area: Dynamis - Xarcabard
--   Mob: Vanguard Dragon
-----------------------------------
local ID = require("scripts/zones/Dynamis-Xarcabard/IDs")
require("scripts/globals/dynamis")
require("scripts/globals/status")
-----------------------------------

function onMobRoamAction(mob)
    dynamis.mobOnRoamAction(mob)
end

function onMobRoam(mob)
    dynamis.mobOnRoam(mob)
end

function onMobDeath(mob, isKiller, player)
end