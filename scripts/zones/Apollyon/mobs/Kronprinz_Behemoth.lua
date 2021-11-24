-----------------------------------
-- Area: Apollyon NW
--  Mob: Kronprinz Behemoth
-----------------------------------

function onMobDeath(mob, player, isKiller)

end

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.ALLI_HATE, 30)
end