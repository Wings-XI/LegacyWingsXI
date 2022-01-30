-----------------------------------
-- Area: Alzadaal Undersea Ruins
-- Door: Gilded Doors (North)
-- !pos 180 0 79 72
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/besieged")
local ID = require("scripts/zones/Alzadaal_Undersea_Ruins/IDs")
-----------------------------------

function onTrigger(player, npc)
    if player:hasKeyItem(tpz.ki.NYZUL_ISLE_ASSAULT_ORDERS) and player:getZPos() >= 75 and player:getZPos() <= 80 then
        player:messageSpecial(ID.text.CANNOT_LEAVE, tpz.ki.NYZUL_ISLE_ASSAULT_ORDERS)
    elseif player:getZPos() >= 77 and player:getZPos() <= 79 then
        player:messageSpecial(ID.text.STAGING_POINT_NYZUL)
        player:messageSpecial(ID.text.IMPERIAL_CONTROL)
        player:startEvent(107)
    elseif player:getZPos() >= 80 and player:getZPos() <= 82 then
        player:messageSpecial(ID.text.STAGING_POINT_NYZUL)
        player:messageSpecial(ID.text.IMPERIAL_CONTROL)
        player:startEvent(106)
    else
        player:messageSpecial(ID.text.MOVE_CLOSER)
    end
end

function onEventUpdate(player, csid, option)
	if csid == 106 and option == 0 then
		for _, entry in pairs(player:getNotorietyList()) do
			entry:deaggroPlayer(player:getName()) -- reset hate on player entering staging point
		end
	end
end

function onEventFinish(player, csid, option)

end
