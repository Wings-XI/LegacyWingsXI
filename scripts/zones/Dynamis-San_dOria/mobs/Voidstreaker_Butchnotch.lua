-----------------------------------
-- Area: Dynamis - San d'Oria
--  Mob: Voidstreaker Butchnotch
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
    dynamis.setNMStats(mob)
    local params = { }
    params.specials = { }
    params.specials.gakure = { }
    params.specials.gakure.id = tpz.jsa.MIJIN_GAKURE;
    params.specials.gakure.hpp = math.random(20,30)
    tpz.mix.jobSpecial.config(mob, params)
end