-----------------------------------
-- Area: Mount Zhayolm
-- Door: Heavy Iron Gate
-- !pos 660 -27 328 61
-----------------------------------
local ID = require("scripts/zones/Mount_Zhayolm/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:hasKeyItem(tpz.ki.LEBROS_ASSAULT_ORDERS) then
        player:messageSpecial(ID.text.CANNOT_LEAVE, tpz.ki.LEBROS_ASSAULT_ORDERS)
    elseif player:getZPos() <= 335 and player:getZPos() >= 332 then
        player:messageSpecial(ID.text.STAGING_POINT_HALVUNG)
        player:messageSpecial(ID.text.IMPERIAL_CONTROL)
        player:startEvent(107)
    elseif player:getZPos() <= 331.500 and player:getZPos() >= 328.500 then
        player:messageSpecial(ID.text.STAGING_POINT_HALVUNG)
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
