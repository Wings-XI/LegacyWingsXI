-----------------------------------
-- Area: Dynamis - San d'Oria
--  Mob: Vanguard's Hecteyes
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------

function onMobSpawn(mob)
    dynamis.setPetStats(mob)
end