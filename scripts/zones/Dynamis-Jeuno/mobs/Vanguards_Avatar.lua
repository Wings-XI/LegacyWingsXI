-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Vanguard's Avatar
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------

function onMobSpawn(mob)
    dynamis.setPetStats(mob)
end