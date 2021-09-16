-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Kindreds's Vouivre
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------

function onMobDeath(mob, isKiller, player)
end

function onMobSpawn(mob)
    dynamis.setPetStats(mob)
end
