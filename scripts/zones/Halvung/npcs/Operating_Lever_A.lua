-----------------------------------
--  Area: Halvung
--  NPC: Operating Lever A
--  TODO: more than 5/6 people still need verification as no sites show this requirment?
-----------------------------------
local ID = require("scripts/zones/Halvung/IDs")
local doorOffset = 2
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:hasKeyItem(tpz.ki.BRACELET_OF_VERVE) == false then
        player:startEvent(100)
        if npc:getLocalVar("PlayerCount") > 0 then
            npc:setLocalVar("PlayerCount", npc:getLocalVar("PlayerCount") + 1)
        else
            npc:setLocalVar("PlayerCount", 1)
        end
        player:setLocalVar("leverID", npc:getID())
        return 1
    else
        GetNPCByID(npc:getID() - doorOffset):openDoor(30)
        player:messageSpecial(ID.text.LIFT_LEVER)
        return 1
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    local npcID = player:getLocalVar("leverID")
    local npc
    if npcID > 0 then
        npc = GetNPCByID(npcID)
    end
    if npc ~= nil then
        if npc:getLocalVar("PlayerCount") >= 5 then
            GetNPCByID(npc:getID() - doorOffset):openDoor(30)
            player:messageSpecial(ID.text.LIFT_LEVER)
            npc:setLocalVar("PlayerCount", 0)
        else
            npc:setLocalVar("PlayerCount", npc:getLocalVar("PlayerCount") - 1)
        end
    end
end
