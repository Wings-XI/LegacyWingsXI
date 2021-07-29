-----------------------------------
-- Area: Dynamis - Bastok
--  Mob: Vanguard's Wyvern
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------

function onMobSpawn(mob)
    dynamis.setPetStats(mob)
end