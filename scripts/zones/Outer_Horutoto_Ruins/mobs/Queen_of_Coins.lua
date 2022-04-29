-----------------------------------
-- Area: Outer Horutoto Ruins
--   NM: Queen of Coins
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/missions")
-----------------------------------

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
    mob:setLocalVar("despawn", os.time() + 180) -- TODO: Add IDLE_DESPAWN function to RoamTick as it only happens on disengage
end

function onMobRoam(mob)
    local now = os.time()
    local despawntime = mob:getLocalVar("despawn")
    if now > despawntime then
        DespawnMob(mob:getID())
    end
end

function onMobEngaged(mob)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
end

function onMobDeath(mob, player, isKiller)
    if player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.THE_JESTER_WHO_D_BE_KING and player:getCharVar("MissionStatus") == 4 and GetMobByID(mob:getID() - 1):isDead() then
        player:setCharVar("MissionStatus", 5)
    end
end

function onMobDespawn(mob)
end
