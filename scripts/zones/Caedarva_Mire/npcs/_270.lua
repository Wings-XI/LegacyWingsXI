-----------------------------------
-- Area: Caedarva Mire
-- Door: Heavy Iron Gate
-- !pos 540 -18 -441 79
-----------------------------------
local ID = require("scripts/zones/Caedarva_Mire/IDs")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getZPos() <= -438 and player:getZPos() >= -440 then -- Leave safe zone
        if player:hasKeyItem(tpz.ki.LEUJAOAM_ASSAULT_ORDERS) then
            player:messageSpecial(ID.text.CANNOT_LEAVE, tpz.ki.LEUJAOAM_ASSAULT_ORDERS)
        else
            player:messageSpecial(ID.text.STAGING_POINT_AZOUPH)
            player:messageSpecial(ID.text.IMPERIAL_CONTROL)
            player:startEvent(121)
        end
    elseif player:getZPos() >= -436.6 and player:getZPos() <= -434 then -- Enter safe zone
        player:messageSpecial(ID.text.STAGING_POINT_AZOUPH)
        player:messageSpecial(ID.text.IMPERIAL_CONTROL)
        player:startEvent(120)
    else
        player:messageSpecial(ID.text.MOVE_CLOSER)
    end
end

function onEventUpdate(player, csid, option)
	if csid == 120 and option == 0 then
		for _, entry in pairs(player:getNotorietyList()) do
			entry:disengage() -- resetEnmity(player) is not consistently working on all mobs.
		end
	end
end

function onEventFinish(player, csid, option)
end
