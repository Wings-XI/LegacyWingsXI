-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Prince Seere
-----------------------------------
require("scripts/globals/dynamis")
require("scripts/globals/status")
mixins =
{
    require("scripts/mixins/dynamis_beastmen"),
    require("scripts/mixins/job_special")
}
-----------------------------------

local zone = 135

function onMobDeath(mob, player, isKiller)
    require("scripts/zones/Dynamis-Xarcabard/dynamis_mobs")
    local ID = require("scripts/zones/Dynamis-Xarcabard/IDs")
    dynamis.mobOnDeath(mob, mobList[zone], ID.text.DYNAMIS_TIME_EXTEND)
end

function onMobSpawn(mob)
    dynamis.setNMStats(mob)
end
