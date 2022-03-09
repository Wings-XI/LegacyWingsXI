-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Pit Antlion
-----------------------------------
mixins = {require("scripts/mixins/families/antlion_ambush")}
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ROAM_TURNS, 0)
    mob:setMobMod(tpz.mobMod.ROAM_RATE, 0)
    mob:setMobMod(tpz.mobMod.ROAM_DISTANCE, 0)
end

function onMobDeath(mob, player, isKiller)
end
