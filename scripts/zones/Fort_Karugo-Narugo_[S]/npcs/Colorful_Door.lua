----------------------------------
-- Area: Fort Karugo Narugo [S]
--  NPC: Colorful Door
-- Type: WOTG Mission-Quest - A Manfiest Problem
-- !pos -134.89 -68.25 101.99 96
-----------------------------------
local ID = require("scripts/zones/Fort_Karugo-Narugo_[S]/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/status")
-----------------------------------


function onTrigger(player, npc)
    if(player:hasKeyItem(tpz.ki.FORT_KEY) and false) then -- "and false"  hard block to prevent this from being live before testing
        player:startEvent(235, 0, 0, 28)
    end
end

function onEventUpdate(player, csid, option, target)
    --printf("onUpdate CSID: %u", csid)
    --printf("onUpdate RESULT: %u", option)
    if csid == 235 and option == 540 then
        if player:hasKeyItem(tpz.ki.FORT_KEY) then
            local instanceid = bit.rshift(option, 19) + 96 --Bitshifting 540 to the right 19 times??? so 0 + 96, need to verify this
            local party = player:getParty()
        
            if party ~= nil then
                for i, v in ipairs(party) do
                    if v:getZoneID() == player:getZoneID() and v:checkDistance(player) > 50 then
                        player:messageText(target, ID.text.PARTY_REQUIREMENTS_FAILED, false)
                        player:instanceEntry(target, 1)
                        return
                    end
                end
            end
            player:createInstance(instanceid, 129)
        end
    end
end

function onEventFinish(player, csid, option, target)
    --printf("onfinish CSID: %u", csid)
    --printf("onFinish RESULT: %u", option)
    if csid == 235 and option == 4 then
        player:setPos(0, 0, 0, 0, 129)
    end
end

function onInstanceCreated(player, target, instance)
    if (instance) then
        player:setInstance(instance)
        player:instanceEntry(target, 4)
        player:delKeyItem(tpz.ki.FORT_KEY)

        local party = player:getParty()
        if party ~= nil then
            for i, v in ipairs(party) do
                if v:getID() ~= player:getID() and v:getZoneID() == player:getZoneID() then
                    v:setInstance(instance)
                    v:setPos(0, 0, 0, 0, 129)
                    v:delKeyItem(tpz.ki.FORT_KEY)
                end
            end
        end
    else
        player:messageText(target, ID.text.CANNOT_ENTER, false)
        player:instanceEntry(target, 3)
    end
end