-----------------------------------
--
-- Zone: Rolanberry_Fields_[S] (91)
--
-----------------------------------
local ID = require("scripts/zones/Rolanberry_Fields_[S]/IDs")
require("scripts/globals/conquest")
require("scripts/globals/events/dark_ixion")
-----------------------------------

function onInitialize(zone)
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
        player:setPos(-376.179, -30.387, -776.159, 220)
    end
	if player:getCharVar("WOTG_PlayCrashLandCS") == 1 then
		cs = 700
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
	if csid == 700 then
		player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.PURE_WHITE_FEATHER)
		player:setCharVar("WOTG_PlayCrashLandCS",0)
	end
end
