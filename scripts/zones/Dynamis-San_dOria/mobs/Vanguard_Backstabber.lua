-----------------------------------
-- Area: Dynamis - San d'Oria
--  Mob: Vanguard Backstabber
-----------------------------------
require("scripts/globals/dynamis")
mixins =
{
    require("scripts/mixins/dynamis_beastmen"),
    require("scripts/mixins/job_special")
}
-----------------------------------

local zone = 185

function onMobDeath(mob, player, isKiller)
    require("scripts/zones/Dynamis-San_dOria/dynamis_mobs")
    local ID = require("scripts/zones/Dynamis-San_dOria/IDs")
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