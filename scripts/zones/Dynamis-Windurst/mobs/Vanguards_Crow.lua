-----------------------------------
-- Area: Dynamis - Windurst
--  Mob: Vanguard's Crow
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------

function onMobSpawn(mob)
    dynamis.setPetStats(mob)
end