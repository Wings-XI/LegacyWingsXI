-----------------------------------
-- Area: Dynamis - Bastok
--  Mob: Effigy Shield
-----------------------------------
require("scripts/globals/dynamis")
require("scripts/globals/status")
mixins =
{
    require("scripts/mixins/dynamis_beastmen"),
    require("scripts/mixins/job_special")
}
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
    -- these have the same mob pools as the normal mobs, but need to be stronger and have the skillset for Wrath of Ghu'Dha
    mob:setSkillList(705)
    mob:setLevel(math.random(81,82)) -- this is last because it also recalculates stats
end