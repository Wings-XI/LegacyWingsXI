------------------------------
-- Area: Lufaise Meadows
--   NM: Yal-un Eke
------------------------------
require("scripts/globals/hunts")
require("scripts/globals/world")
require("scripts/globals/mobs")
local ID = require("scripts/zones/Lufaise_Meadows/IDs")
------------------------------

function onMobSpawn(mob)
    mob:addMod(tpz.mod.REGAIN, 300)
end

function onMobRoam(mob)
    if mob:getWeather() ~= tpz.weather.FOG then
        DespawnMob(mob:getID())
    end
end
  
function onMobDisengage(mob)
    if mob:getWeather() ~= tpz.weather.FOG then
        DespawnMob(mob:getID())
    end
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 440)
end

function onMobDespawn(mob)
    local Yalun  = GetMobByID(ID.mob.YALUN_EKE)
    local YalunPH = GetServerVariable("YalunPH")

    -- Allow PH to respawn and resets which PH will be the next Yal-un Eke
    DisallowRespawn(YalunPH, false)
    SetServerVariable("YalunPH", ID.mob.YALUN_EKE_PH[math.random(1,2)])

    SetServerVariable("YalunRespawn", os.time() + 3000) -- 50 min respawn
    DisallowRespawn(Yalun:getID(), true)
end