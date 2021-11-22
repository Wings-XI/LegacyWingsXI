-----------------------------------
-- Area: Arrapago Reef
-- Door: Heavy Iron Gate
-- !pos 5 -9 579 54
-----------------------------------
local ID = require("scripts/zones/Arrapago_Reef/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getXPos() <= 11.5 and player:getXPos() >= 8.500 then -- Leave safe zone
        if player:hasKeyItem(tpz.ki.ILRUSI_ASSAULT_ORDERS) then
            player:messageSpecial(ID.text.CANNOT_LEAVE, tpz.ki.ILRUSI_ASSAULT_ORDERS)
        else
            player:messageSpecial(ID.text.STAGING_POINT_ILRUSI)
            player:messageSpecial(ID.text.IMPERIAL_CONTROL)
            player:startEvent(107)
        end
    elseif player:getXPos() <= 8 and player:getXPos() >= 5 then -- Enter safe zone
        player:messageSpecial(ID.text.STAGING_POINT_ILRUSI)
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
