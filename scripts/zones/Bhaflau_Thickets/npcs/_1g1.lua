-----------------------------------
-- Area: Bhaflau Thickets
-- Door: Heavy Iron Gate
-- !pos -180 -10 -758 52
-----------------------------------
local ID = require("scripts/zones/Bhaflau_Thickets/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:hasKeyItem(tpz.ki.MAMOOL_JA_ASSAULT_ORDERS) then
        player:messageSpecial(ID.text.CANNOT_LEAVE, tpz.ki.MAMOOL_JA_ASSAULT_ORDERS)
    elseif player:getZPos() <= -762 and player:getZPos() >= -765 then
        player:messageSpecial(ID.text.STAGING_POINT_MAMOOL)
        player:messageSpecial(ID.text.IMPERIAL_CONTROL)
        player:startEvent(107)
    elseif player:getZPos() <= -757 and player:getZPos() >= -761 then
        player:messageSpecial(ID.text.STAGING_POINT_MAMOOL)
        player:messageSpecial(ID.text.IMPERIAL_CONTROL)
        player:startEvent(106)
    else
        player:messageSpecial(ID.text.MOVE_CLOSER)
    end
end

function onEventUpdate(player, csid, option)
	if csid == 106 and option == 0 then
		for _, entry in pairs(player:getNotorietyList()) do
			entry:disengage() -- resetEnmity(player) is not consistently working on all mobs.
		end
	end
end

function onEventFinish(player, csid, option)
end
