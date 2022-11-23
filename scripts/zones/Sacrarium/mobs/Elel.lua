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
    SetServerVariable("ElelRespawn", os.time() + math.random(6600, 13200))
end

function onMobDespawn(mob)
    -- DisallowRespawn(mob:getID(), true) -- prevents accidental 'pop' during no darkness weather and immediate despawn
end