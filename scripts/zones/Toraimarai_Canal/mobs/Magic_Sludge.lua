-----------------------------------
-- Area: Toraimarai Canal
--   NM: Magic Sludge
-----------------------------------

function onMobSpawn(mob)
    mob:setMod(tpz.mod.UDMGMAGIC, -75)
end

function onMobDeath(mob, player, isKiller)
    player:setCharVar("rootProblem", 3)
end
