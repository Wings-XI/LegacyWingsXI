-----------------------------------
--
-- Zone: Batallia_Downs_[S] (84)
--
-----------------------------------
local ID = require("scripts/zones/Batallia_Downs_[S]/IDs")
require("scripts/globals/conquest")
-----------------------------------

function onInitialize(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(-500.451, -39.71, 504.894, 39)
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
