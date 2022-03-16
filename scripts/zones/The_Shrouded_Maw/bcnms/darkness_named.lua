-----------------------------------
-- Darkness Named
-- The Shrouded Maw mission battlefield
-----------------------------------
local ID = require("scripts/zones/The_Shrouded_Maw/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/missions")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------

function onBattlefieldTick(battlefield, tick)
    tpz.battlefield.onBattlefieldTick(battlefield, tick)
end

function onBattlefieldRegister(player, battlefield)
    local area = battlefield:getArea()
    player:setLocalVar("Area", area)

    -- Reset the tiles in that area to be closed, and tell them that they're closed
    local tile = ID.npc.DARKNESS_NAMED_TILE_OFFSET + (area - 1) * 8
    for i = tile, tile + 7 do
        GetNPCByID(i):setAnimation(tpz.anim.CLOSE_DOOR)
        GetNPCByID(i):setLocalVar("Dropped", 0)
    end
end

function onBattlefieldEnter(player, battlefield)
end

function onBattlefieldLeave(player, battlefield, leavecode)
    if leavecode == tpz.battlefield.leaveCode.WON then
        local name, clearTime, partySize = battlefield:getRecord()
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), 0)
    elseif leavecode == tpz.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 32001 then
        if player:getCurrentMission(COP) == tpz.mission.id.cop.DARKNESS_NAMED and player:getCharVar("PromathiaStatus") == 2 then
            player:addTitle(tpz.title.TRANSIENT_DREAMER)
            player:setCharVar("PromathiaStatus", 3)
        end
        player:addExp(1000)
    end
end
