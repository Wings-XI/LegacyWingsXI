-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Vanguard's Wyvern
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------

function onMobSpawn(mob)
    dynamis.setPetStats(mob)
end