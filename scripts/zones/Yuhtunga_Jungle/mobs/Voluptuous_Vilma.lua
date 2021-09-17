-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Voluptuous Vilma
-----------------------------------
local ID = require("scripts/zones/Yuhtunga_Jungle/IDs")
require("scripts/globals/status")
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    DisallowRespawn(ID.mob.VOLUPTUOUS_VILMA, true)
    DisallowRespawn(ID.mob.ROSE_GARDEN_PH, false)
    GetMobByID(ID.mob.ROSE_GARDEN_PH):setRespawnTime(GetMobRespawnTime(ID.mob.ROSE_GARDEN_PH))
end

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)

    local roll = math.random(1, 4)

    if roll == 1 then
        return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.BLIND, {chance = 30})
    elseif roll == 2 then
        return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.PARALYZE, {chance = 30})
    elseif roll == 3 then
        return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.WEIGHT, {chance = 30})
    else
        return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.POISON, {chance = 30})
    end
end