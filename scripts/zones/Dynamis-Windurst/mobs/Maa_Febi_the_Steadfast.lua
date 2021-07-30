-----------------------------------
-- Area: Dynamis - Windurst
--  Mob: Maa Febi the Steadfast
-----------------------------------
require("scripts/globals/dynamis")
mixins =
{
    require("scripts/mixins/dynamis_beastmen"),
    require("scripts/mixins/job_special"),
    require("scripts/mixins/remove_doom")
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
    dynamis.setNMStats(mob)
end