-----------------------------------
-- Area: Ordelles Caves
--  Mob: Aroma Leech (RSE Satchets)
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
end

function onMobDeath(mob, player, isKiller)
end
