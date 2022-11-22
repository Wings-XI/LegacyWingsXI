-----------------------------------
-- Area: Sacrarium
--   NM: Elel
--  POS: -100.618 -0.600 -2.194 28
--   ID: 16891948
-----------------------------------
require("scripts/globals/world")
require("scripts/zones/Sacrarium/Zone")
-----------------------------------

function onMobSpawn(mob)
    mob:setLocalVar("wasKilled", 0)
end

function onMobRoam(mob)
    if not elelCanSpawn() then
       DespawnMob(mob:getID())
    end
end

function onMobFight(mob, target)
end

function onMobDisengage(mob)
    if not elelCanSpawn() then
        DespawnMob(mob:getID())
    end
end

function onMobDeath(mob, player, isKiller)
    if isKiller == true then
        mob:setLocalVar("wasKilled", 1)
    end
end

function onMobDespawn(mob)
    if mob:getLocalVar("wasKilled") == 1 then
        mob:setRespawnTime(math.random(7200, 14400)
        mob:setLocalVar("cooldown", os.time() + mob:getRespawnTime()/1000)
    end
    DisallowRespawn(mob:getID(), true) -- prevents accidental 'pop' during no darkness weather and immediate despawn
end