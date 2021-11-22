-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Kindred Black Mage
-----------------------------------
mixins =
{
    require("scripts/mixins/dynamis_beastmen"),
    require("scripts/mixins/job_special")
}
local ID = require("scripts/zones/Dynamis-Xarcabard/IDs")
require("scripts/globals/dynamis")
-- require("scripts/globals/mobs")
-----------------------------------

local zone = 135

function onMobDeath(mob, player, isKiller)
    require("scripts/zones/Dynamis-Xarcabard/dynamis_mobs")
    local ID = require("scripts/zones/Dynamis-Xarcabard/IDs")
    dynamis.statueOnDeath(mob, player, isKiller)
    dynamis.mobOnDeath(mob, mobList[zone], ID.text.DYNAMIS_TIME_EXTEND)
end

function onMobRoamAction(mob)
    dynamis.mobOnRoamAction(mob)
end

function onMobRoam(mob)
    dynamis.mobOnRoam(mob)
end

-- function onMobDespawn(mob)
--     tpz.mob.phOnDespawn(mob, ID.mob.MARQUIS_ORIAS_PH, 10, 1200) -- 20 minutes
-- end

function onMobSpawn(mob)
    dynamis.setMobStats(mob)
end
