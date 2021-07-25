-----------------------------------
-- Area: Dynamis - Windurst
--  Mob: Vanguard Sentinel
-----------------------------------
require("scripts/globals/dynamis")
mixins =
{
    require("scripts/mixins/dynamis_beastmen"),
    require("scripts/mixins/job_special")
}
-----------------------------------

local zone = 187

function onMobDeath(mob, player, isKiller)
    require("scripts/zones/Dynamis-Windurst/dynamis_mobs")
    local ID = require("scripts/zones/Dynamis-Windurst/IDs")
    dynamis.mobOnDeath(mob, mobList[zone], ID.text.DYNAMIS_TIME_EXTEND)
end

function onMobRoamAction(mob)
    dynamis.mobOnRoamAction(mob)
end

function onMobRoam(mob)
    dynamis.mobOnRoam(mob)
end

function onMobSpawn(mob)
    dynamis.setMobStats(mob)
end