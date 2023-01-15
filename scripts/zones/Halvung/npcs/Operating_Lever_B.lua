-----------------------------------
--  Area: Halvung
--  NPC: Operating Lever B
--  TODO: more than 5/6 people still need verification as no sites show this requirment?
-----------------------------------
local ID = require("scripts/zones/Halvung/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:hasKeyItem(tpz.ki.BRACELET_OF_VERVE) == false then
        player:startEvent(100)
        return 1
    else
        GetNPCByID(npc:getID() - 3):openDoor(30)
        player:messageSpecial(ID.text.LIFT_LEVER)
        return 1
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
