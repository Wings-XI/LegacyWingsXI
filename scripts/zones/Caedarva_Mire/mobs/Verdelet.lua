-----------------------------------
-- Area: Caedarva Mire (79)
--  ZNM: Verdelet
-- !pos 417 -19.3 -70 79
-----------------------------------
mixins = {require("scripts/mixins/families/imp")}
-----------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
end

function onMobSpawn(mob)
    mob:setMod(tpz.mod.FASTCAST, 50)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 12)
end

function onMobDeath(mob, player, isKiller)
end
