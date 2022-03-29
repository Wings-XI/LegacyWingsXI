-----------------------------------
-- Area: Dynamis - Sandoria
--  Mob: Vanguard's Avatar
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------

function onMobDeath(mob, isKiller, player)
end

function onMobFight(mob)
end

function onMobSpawn(mob)
    dynamis.setPetStats(mob)
end