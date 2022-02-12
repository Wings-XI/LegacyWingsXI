-----------------------------------
-- Area: Dynamis - Valkrum
--  Mob: Fairy Ring
-----------------------------------
mixins = {require("scripts/mixins/dynamis_dreamland")}
require("scripts/globals/dynamis")
-----------------------------------

function onMobSpawn(mob)
    dynamis.setNMStats(mob)
end

function onMobRoamAction(mob)
    dynamis.mobOnRoamAction(mob)
end

function onMobRoam(mob)
    dynamis.mobOnRoam(mob)
end