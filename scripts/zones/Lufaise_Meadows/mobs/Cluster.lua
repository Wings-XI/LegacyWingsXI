-----------------------------------
-- Area: Lufaise_Meadows
--  Mob: Cluster
-- Note: PH for Yal-un Eke
-----------------------------------
local ID = require("scripts/zones/Lufaise_Meadows/IDs")
require("scripts/globals/mobs")
require("scripts/globals/world")
-----------------------------------

function onMobDisengage(mob)
    -- Spawns during 02:00 to 07:00
    local hour = VanadielHour()
    if hour >= 7 or hour < 2 then
        DespawnMob(mob:getID())
    end
end

function onMobRoam(mob)
    -- Spawns during 02:00 to 07:00
    local hour = VanadielHour()
    if hour >= 7 or hour < 2 then
        DespawnMob(mob:getID())
    end

    -- Yal-un Eke spawns in place of one of the two Clusters
    local YalunPH = GetServerVariable("YalunPH")
    local YalunRe = GetServerVariable("YalunRespawn")
    if mob:getID() == YalunPH and os.time() > YalunRe and mob:getWeather() == tpz.weather.FOG then
        DisallowRespawn(YalunPH, true)
        DespawnMob(YalunPH)
        DisallowRespawn(ID.mob.YALUN_EKE, false)
        pos = mob:getPos()
        SpawnMob(ID.mob.YALUN_EKE):setPos(pos.x, pos.y, pos.z, pos.rot)
    end
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
end