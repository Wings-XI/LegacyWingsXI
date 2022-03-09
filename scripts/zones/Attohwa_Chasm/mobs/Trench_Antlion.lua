-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Trench Antlion
-- Note: PH for Ambusher Antlion
-----------------------------------
mixins = {require("scripts/mixins/families/antlion_ambush")}
local ID = require("scripts/zones/Attohwa_Chasm/IDs")
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ROAM_TURNS, 0)
    mob:setMobMod(tpz.mobMod.ROAM_RATE, 0)
    mob:setMobMod(tpz.mobMod.ROAM_DISTANCE, 0)
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.AMBUSHER_ANTLION_PH, 10, 3600) -- 1 hour
end
