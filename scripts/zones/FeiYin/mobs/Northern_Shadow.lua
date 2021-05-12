-----------------------------------
-- Area: Fei'Yin
--   NM: Northern Shadow
-----------------------------------

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.CLAIM_SHIELD, 1)
end

function onMobDeath(mob, player, isKiller)
end
