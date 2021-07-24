-----------------------------------
-- Area: Dynamis - Bastok
--  Mob: Adamantking Image
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------

local zone = 186

function onMobDeath(mob, player, isKiller)
    require("scripts/zones/Dynamis-Bastok/dynamis_mobs")
    local ID = require("scripts/zones/Dynamis-Bastok/IDs")
    dynamis.mobOnDeath(mob, mobList[zone], ID.text.DYNAMIS_TIME_EXTEND)
end

function onMobRoamAction(mob)
    dynamis.mobOnRoamAction(mob)
end

function onMobRoam(mob)
    dynamis.mobOnRoam(mob)
end

function onMobSpawn(mob)
    mob:setMobLevel(math.random(83,85))
end