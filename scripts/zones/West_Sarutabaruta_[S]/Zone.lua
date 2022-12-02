-----------------------------------
--
-- Zone: West_Sarutabaruta_[S] (95)
--
-----------------------------------
local ID = require("scripts/zones/West_Sarutabaruta_[S]/IDs")
require("scripts/globals/conquest")
require("scripts/globals/helm")
require("scripts/globals/events/dark_ixion")
-----------------------------------

function onInitialize(zone)
    tpz.helm.initZone(zone, tpz.helm.type.HARVESTING)
    darkixion.onZoneInit(zone)
end

function onGameHour(zone)
	darkixion.onZoneGameHour(zone)
end

function onGameHour(zone)
	local ixion = GetMobByID(ID.mob.DARK_IXION)
	if ixion:getStatus() == STATUS_DISAPPEAR
		and GetServerVariable("DarkIxion_ZoneID") == zone:getID()
		and GetServerVariable("DarkIxion_PopTime") < os.time() then
			SpawnMob(ixion:getID())
	end

end

function onZoneIn(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(320.018, -6.684, -45.166, 189)
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
