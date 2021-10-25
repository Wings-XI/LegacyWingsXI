-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Puu Timu the Phantasmal
-----------------------------------
mixins =
{
    require("scripts/mixins/dynamis_beastmen"),
    require("scripts/mixins/job_special"),
    require("scripts/mixins/remove_doom")
}
-----------------------------------

local zone = 134

function onMobDeath(mob, player, isKiller)
    require("scripts/zones/Dynamis-Beaucedine/dynamis_mobs")
    local ID = require("scripts/zones/Dynamis-Beaucedine/IDs")
    dynamis.mobOnDeath(mob, mobList[zone], ID.text.DYNAMIS_TIME_EXTEND)
end

function onMobRoamAction(mob)
    dynamis.mobOnRoamAction(mob)
end

function onMobRoam(mob)
    dynamis.mobOnRoam(mob)
end

function onMobSpawn(mob)
    dynamis.setNMStats(mob)
end