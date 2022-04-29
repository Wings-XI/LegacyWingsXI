-----------------------------------
-- Area: GM Home
--  NPC: Key Item
-- Gives GMs necessary KIs
-- License: GPLv3
-----------------------------------

local ID = require("scripts/zones/GM_Home/IDs")

function onTrade(player, npc, trade)
end;

function onTrigger(player, npc)
    player:startEvent(24);
end;

function onEventUpdate(player, csid, option)
end;

function onEventFinish(player, csid, option)
    local allowedItems =
    {
        549, 495, 494, 4377, 554, 555, 534, 531, 776, 557, 556, 558, 559,
        560, 561, 562, 917, 634, 12507, 4508, 548, 16522, 16631, 1126
    }
    if not listContains(allowedItems, option) then
        return
    end
    player:addItem( option )
    player:messageSpecial( ID.text.ITEM_OBTAINED, option )
end;

function listContains(list, x)
    for _, v in pairs(list) do
        if v == x then return true end
    end
    return false
end