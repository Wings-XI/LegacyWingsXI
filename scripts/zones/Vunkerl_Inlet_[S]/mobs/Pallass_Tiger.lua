-----------------------------------
-- Area: Vunkerl Inlet [S]
--   NM: Pallas's Tiger
-----------------------------------
local ID = require("scripts/zones/Vunkerl_Inlet_[S]/IDs")
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMod(tpz.mod.RESBUILD_SLEEP, 10)
    mob:setMod(tpz.mod.RESBUILD_LULLABY, 10)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(tpz.mobMod.CHARMABLE, 0)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.PARALYZE, {chance = 50})
end

function onMobFight(mob, target)
end

function onMobDeath(mob, player, isKiller)
end

function onMobEngaged(mob, target)
    mobID = ID.mob.PALLAS
    local pallas = GetMobByID(mobID)
    if pallas and pallas:isAlive() then
        printf("Get mad pallas")
        pallas:updateEnmity(target)
    end
    
end