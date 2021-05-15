-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Citipati
-----------------------------------
require("scripts/globals/hunts")

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.CLAIM_SHIELD, 1)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 278)
end
