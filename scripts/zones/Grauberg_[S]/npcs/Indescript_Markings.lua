----------------------------------
-- Area: Grauberg [S]
--  NPC: Indescript Markings
-- Type: Quest
-----------------------------------
local ID = require("scripts/zones/Grauberg_[S]/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local gownQuestProgress = player:getCharVar("AF_SCH_BODY")
    -- SCH AF Quest - Body
    if npc:getID() == 17142581 then
        if gownQuestProgress > 0 and gownQuestProgress < 3 and not player:hasKeyItem(tpz.ki.SAMPLE_OF_GRAUBERG_CHERT) then
            npcUtil.giveKeyItem(player, tpz.ki.SAMPLE_OF_GRAUBERG_CHERT)
            player:setCharVar("AF_SCH_BODY", gownQuestProgress + 1)
        else
            player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
        end
    -- SCH AF3 Quest - Head
    elseif npc:getID() == 17142586 then
        if player:getCharVar("SeeingBloodRed") == 3 and player:hasKeyItem(tpz.ki.PORTING_MAGIC_TRANSCRIPT) then
            player:startEvent(102, 0, 0, 34) -- cs 15 is after you win?
            -- player:setPos(-323.6241, -23.8410, -19.5224, 93)
        else
            player:messageSpecial(ID.text.THERE_IS_NO_RESPONSE)
        end
    end
end

function onEventUpdate(player, csid, option, target)
    if csid == 102 and option == 546 then
        if player:hasKeyItem(tpz.ki.PORTING_MAGIC_TRANSCRIPT) then
            local instanceid = bit.rshift(option, 19) + 89
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
        
            player:createInstance(instanceid, 93)
        end
    end
end

function onEventFinish(player, csid, option, target)
    if csid == 102 and option == 4 then
        player:setPos(0, 0, 0, 0, 93)
    end
end

function onInstanceCreated(player, target, instance)
    if (instance) then
        player:setInstance(instance)
        player:instanceEntry(target, 4)
        player:delKeyItem(tpz.ki.PORTING_MAGIC_TRANSCRIPT)
        player:setCharVar("SeeingBloodRed_Instance", 1)

        local party = player:getParty()
        if party ~= nil then
            for i, v in ipairs(party) do
                if v:getID() ~= player:getID() and v:getZoneID() == player:getZoneID() then
                    v:setInstance(instance)
                    v:setPos(0, 0, 0, 0, 93)
                    v:delKeyItem(tpz.ki.PORTING_MAGIC_TRANSCRIPT)
                    v:setCharVar("SeeingBloodRed_Instance", 1)
                end
            end
        end
    else
        player:messageText(target, ID.text.CANNOT_ENTER, false)
        player:instanceEntry(target, 3)
    end
end
