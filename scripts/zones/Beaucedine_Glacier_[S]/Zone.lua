-----------------------------------
--
-- Zone: Beaucedine_Glacier_[S] (136)
--
-----------------------------------
local ID = require("scripts/zones/Beaucedine_Glacier_[S]/IDs")
require("scripts/globals/conquest")
-----------------------------------

function onInitialize(zone)
    local ScyllaRespawn = GetServerVariable("ScyllaRespawn")
    if os.time() < ScyllaRespawn then
        GetMobByID(ID.mob.SCYLLA):setRespawnTime(ScyllaRespawn - os.time())
    else
        SpawnMob(ID.mob.SCYLLA)
    end
end

function onZoneIn(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(-180, -81.85, 280, 44)
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
