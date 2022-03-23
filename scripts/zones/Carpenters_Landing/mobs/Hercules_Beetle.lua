------------------------------
-- Area: Carpenters Landing
--   NM: Hercules Beetle
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobSpawn(mob)
    -- High resistance to physical damage.
    mob:addMod(tpz.mod.DMGPHYS,-70)
    mob:addMod(tpz.mod.DMGRANGE,-70)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 165)
end
