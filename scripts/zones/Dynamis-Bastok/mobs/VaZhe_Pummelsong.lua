-----------------------------------
-- Area: Dynamis - Bastok
--  Mob: Va'Zhe Pummelsong
-----------------------------------
require("scripts/globals/dynamis")
mixins =
{
    require("scripts/mixins/dynamis_beastmen"),
    require("scripts/mixins/job_special")
}
-----------------------------------

local zone = 186

function onMobFight(mob, target)
    if mob:hasStatusEffect(tpz.effect.HUNDRED_FISTS) then
        mob:SetMobAbilityEnabled(false)
        mob:SetMagicCastingEnabled(false)
    else
        mob:SetMobAbilityEnabled(true)
        mob:SetMagicCastingEnabled(true)
    end
end

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
    dynamis.setNMStats(mob)
end