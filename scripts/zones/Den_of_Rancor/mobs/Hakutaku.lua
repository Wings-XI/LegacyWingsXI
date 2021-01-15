-----------------------------------
-- Area: Den of Rancor
--   NM: Hakutaku
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 18000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 22000)
    mob:setMod(tpz.mod.SDT_FIRE, 20)
    mob:setMod(tpz.mod.TRIPLE_ATTACK,38)
end

function onMobDeath(mob, player, isKiller)
end
