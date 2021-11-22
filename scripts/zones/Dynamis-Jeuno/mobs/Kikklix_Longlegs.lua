-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Kikklix Longlegs
-----------------------------------
require("scripts/globals/dynamis")
mixins =
{
    require("scripts/mixins/dynamis_beastmen"),
    require("scripts/mixins/job_special")
}
-----------------------------------

local zone = 188

function onMobFight(mob, target)
    if mob:hasStatusEffect(tpz.effect.HUNDRED_FISTS) then
        mob:SetMobAbilityEnabled(false)
    else
        mob:SetMobAbilityEnabled(true)
    end
end

function onMobDeath(mob, player, isKiller)
    require("scripts/zones/Dynamis-Jeuno/dynamis_mobs")
    local ID = require("scripts/zones/Dynamis-Jeuno/IDs")
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