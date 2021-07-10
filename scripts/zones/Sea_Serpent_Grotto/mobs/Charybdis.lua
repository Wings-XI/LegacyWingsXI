-----------------------------------
-- Area: Sea Serpent Grotto (176)
--   NM: Charybdis
-- !pos -152 48 -328 176
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.MULTI_HIT, 5)
end

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.CLAIM_SHIELD, 1)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 18000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 28000)
end

function onMobDeath(mob, player, isKiller)
end
