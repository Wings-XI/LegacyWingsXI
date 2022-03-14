-----------------------------------
-- Area: The_Shrouded_Maw
-- NPC:  MementoCircle
-----------------------------------

local ID = require ("scripts/zones/The_Shrouded_Maw/IDs")
require("scripts/globals/bcnm")

function onTrade(player, npc, trade)
    TradeBCNM(player, npc, trade)
end

function onTrigger(player, npc)
    EventTriggerBCNM(player, npc)
end

function onEventUpdate(player, csid, option, extras)
    EventUpdateBCNM(player, csid, option, extras)
end

-----------------------------------
-- onEventFinish Action
-----------------------------------

function onEventFinish(player, csid, option)
    if csid == 32000 then

        local area = player:getLocalVar("Area")
        if area >= 1 and area <= 3 then
            -- Set spawn point by area
            local spawnPos = ID.spawn
            player:setPos(spawnPos[area][1], spawnPos[area][2], spawnPos[area][3], 0)
        end
    end
    EventFinishBCNM(player, csid, option)
end
