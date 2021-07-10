-----------------------------------
--
-- Zone: VeLugannon_Palace (177)
--
-----------------------------------
local ID = require("scripts/zones/VeLugannon_Palace/IDs")
require("scripts/globals/conquest")
require("scripts/globals/treasure")
-----------------------------------

function onInitialize(zone)
    tpz.treasure.initZone(zone)

    local zipacna_respawn = GetServerVariable("Zipacna_Respawn")
	if os.time() < zipacna_respawn then
		GetMobByID(ID.mob.ZIPACNA):setRespawnTime(zipacna_respawn - os.time())
	else
		SpawnMob(ID.mob.ZIPACNA)
	end
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if ((player:getXPos() == 0) and (player:getYPos() == 0) and (player:getZPos() == 0)) then
        player:setPos(-100.01, -25.752, -399.468, 59)
    end
    return cs
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
