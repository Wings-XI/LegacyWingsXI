-----------------------------------
--
-- Zone: Monastic Cavern (150)
--
-----------------------------------
local ID = require("scripts/zones/Monastic_Cavern/IDs")
require("scripts/globals/conquest")
require("scripts/globals/treasure")
-----------------------------------

function onInitialize(zone)

    local OB = GetServerVariable("Overlord_Bakgodek_UP")
    local obre = GetServerVariable("Overlord_Bakgodek_Respawn")
    local oore = GetServerVariable("Orcish_Overlord_Respawn")

    if OB == 1 then
        UpdateNMSpawnPoint(ID.mob.OVERLORD_BAKGODEK)
        if os.time() < obre then
        GetMobByID(ID.mob.OVERLORD_BAKGODEK):setRespawnTime(obre - os.time())
        else
            GetMobByID(ID.mob.OVERLORD_BAKGODEK):setRespawnTime(300)
        end
    else
        UpdateNMSpawnPoint(ID.mob.ORCISH_OVERLORD)
        if os.time() < oore then
            GetMobByID(ID.mob.ORCISH_OVERLORD):setRespawnTime(oore - os.time())
        else
            GetMobByID(ID.mob.ORCISH_OVERLORD):setRespawnTime(300)
        end
    end

    tpz.treasure.initZone(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(261.354, -8.792, 23.124, 175)
    end
    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
