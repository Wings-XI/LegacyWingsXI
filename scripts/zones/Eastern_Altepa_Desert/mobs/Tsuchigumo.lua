-----------------------------------
-- Area: Eastern Altepa Desert
--  Mob: Tsuchigumo
-- Involved in Quest: 20 in Pirate Years
-----------------------------------

require("scripts/globals/status")

 function onMobInitialize(mob)
     mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300) -- 3 minutes 
 end

function onMobSpawn(mob)
    mob:setLocalVar("despawnTime", os.time() + 300)
    mob:setMobMod(tpz.mobMod.NO_LINK, 1)
end

function onMobRoam(mob)
    -- wont link for 5 seconds after spawn, giving a chance to pull with sneak
    mob:timer(5000, function(mob)
        mob:setMobMod(tpz.mobMod.NO_LINK, 0)
        end)
    -- if not claimed within 5 minutes of spawning, despawn
      local despawnTime = mob:getLocalVar("despawnTime")
      if despawnTime > 0 and os.time() > despawnTime then
          DespawnMob(mob:getID())
      end
end

function onMobDeath(mob, player, isKiller)
    if player:getCharVar("twentyInPirateYearsCS") == 3 then
        player:addCharVar("TsuchigumoKilled", 1)
    end
end
