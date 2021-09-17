----------------------------------
-- Area: Pashhow Marshlands [S]
--  NPC: Corroded Door
-- Type: WOTG Mission-Quest - Light In The Darkness
-- !pos -385.602 21.970 456.359 90
-----------------------------------
local ID = require("scripts/zones/Pashhow_Marshlands_[S]/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/status")
require("scripts/globals/instance")
-----------------------------------

local LIGHT_IN_THE_DARKNESS_INSTANCE_ID = 90

function onTrigger(player, npc)
    if VerfyInstanceForPlayer(player, LIGHT_IN_THE_DARKNESS_INSTANCE_ID, true) then
        player:startEvent(3, 0, 0, 19)
    else
        player:messageText(target, ID.text.THERE_IS_NO_REPONSE, false)
    end
end

function onEventUpdate(player, csid, option, target)
    --printf("onUpdate CSID: %u", csid)
    --printf("onUpdate RESULT: %u", option)
    if csid == 3 and option == 531 then
        local instanceid = LIGHT_IN_THE_DARKNESS_INSTANCE_ID
        local party = player:getParty()
        
        if party ~= nil then
            for i, v in ipairs(party) do
                if v:getID() ~= player:getID() and ((v:getZoneID() == player:getZoneID() and v:checkDistance(player) > 50) or not VerfyInstanceForPlayer(v, LIGHT_IN_THE_DARKNESS_INSTANCE_ID, false)) then
                    player:messageText(target, ID.text.PARTY_REQUIREMENTS_FAILED, false)
                    player:instanceEntry(target, 1)
                    return
                end
            end
        end
        player:createInstance(instanceid, 93)
    end
end

function onEventFinish(player, csid, option, target)
    --printf("Door onfinish CSID: %u", csid)
    --printf("Door onFinish RESULT: %u", option)
    if csid == 3 and option == 4 then
        player:setPos(0, 0, 0, 0, 93)
    end
end

function onInstanceCreated(player, target, instance)
    if (instance) then
        player:setInstance(instance)
        player:instanceEntry(target, 4)
        player:delKeyItem(tpz.ki.MINE_SHAFT_KEY)

        local party = player:getParty()
        if party ~= nil then
            for i, v in ipairs(party) do
                if v:getID() ~= player:getID() and v:getZoneID() == player:getZoneID() then
                    v:setInstance(instance)
                    v:setPos(0, 0, 0, 0, 93)
                    v:delKeyItem(tpz.ki.MINE_SHAFT_KEY)
                end
            end
        end
    else
        player:messageText(target, ID.text.CANNOT_ENTER, false)
        player:instanceEntry(target, 3)
    end
end

