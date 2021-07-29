-----------------------------------
-- Area: Dynamis - Bastok
--  Mob: Vanguard's Scorpion
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------

function onMobSpawn(mob)
    dynamis.setPetStats(mob)
end