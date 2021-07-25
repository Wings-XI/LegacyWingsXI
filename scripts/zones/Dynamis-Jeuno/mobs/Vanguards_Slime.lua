-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Vanguard's Slime
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------

function onMobSpawn(mob)
    dynamis.setPetStats(mob)
end