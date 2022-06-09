-----------------------------------
-- Area: Ru'Lude Gardens
-- NPC: Venessa
-- Promyvion ENM NPC
-----------------------------------
require("scripts/globals/settings")
local ID = require("scripts/zones/RuLude_Gardens/IDs")
-----------------------------------

local rewards = {
    { 1794,  1766}, -- Beatific Image
    { 1793,  1765}, -- Grave Image
    { 1795,  1768}, -- Valorous Image
    { 1796,  1770}, -- Ancient Image
    { 1797,  1772}, -- Virgin Image
    { 1790, 14674}, -- Impetuous Vision
    { 1792, 15463}, -- Snide Vision
    { 1791, 15431}, -- Tenuous Vision
}

function onTrade(player, npc, trade)
    local count = trade:getItemCount()
    local reward = 0

    -- Get what reward should be given according to traded item
    for i,prize in pairs(rewards) do
        if trade:hasItemQty(prize[1], 1) and count == 1 then
            reward = prize[2]
            player:setCharVar("venereward", reward)
            player:startEvent(10066, reward)
        end
    end
end

function onTrigger(player, npc)
    -- Player has finished the ENM at least once
    if player:getCurrentMission(COP) > tpz.mission.id.cop.THE_RITES_OF_LIFE and player:getCharVar("[ENM]VenessaComplete") == 1 then
        player:startEvent(10065)
    -- Player can do ENM but hasn't done it
    elseif player:getCurrentMission(COP) > tpz.mission.id.cop.THE_RITES_OF_LIFE then
        player:startEvent(10064)
    -- Player has not progressed far enough in CoP
    else
        player:startEvent(10064, 99)
    end
end

function onEventUpdate(player, csid, option)
    local abandonmentTimer = player:getCharVar("[ENM]abandonmentTimer")
    local antipathyTimer = player:getCharVar("[ENM]antipathyTimer")
    local animusTimer = player:getCharVar("[ENM]animusTimer")
    local acrimonyTimer = player:getCharVar("[ENM]acrimonyTimer")

    if csid == 10064 or csid == 10065 then
        -- Spit out time remaining on KI
        if option == 1 and VanadielTime() < abandonmentTimer and player:hasKeyItem(tpz.ki.CENSER_OF_ABANDONMENT) == false then
            player:updateEvent(1, 0, 0, 0, abandonmentTimer, 1, 0, 0)
        elseif option == 2 and VanadielTime() < antipathyTimer and player:hasKeyItem(tpz.ki.CENSER_OF_ANTIPATHY) == false  then
            player:updateEvent(2, 0, 0, 0, antipathyTimer, 1, 0, 0)
        elseif option == 3 and VanadielTime() < animusTimer and player:hasKeyItem(tpz.ki.CENSER_OF_ANIMUS) == false then
            player:updateEvent(3, 0, 0, 0, animusTimer, 1, 0, 0)
        elseif option == 4 and VanadielTime() < acrimonyTimer and player:hasKeyItem(tpz.ki.CENSER_OF_ACRIMONY) == false then
            player:updateEvent(4, 0, 0, 0, acrimonyTimer, 1, 0, 0)
        end

        -- Give player KI
        if option == 1 and VanadielTime() >= abandonmentTimer then
            player:updateEvent(1, 0, 0, 1)
        elseif option == 2 and VanadielTime() >= antipathyTimer then
            player:updateEvent(2, 0, 0, 1)
        elseif option == 3 and VanadielTime() >= animusTimer then
            player:updateEvent(3, 0, 0, 1)
        elseif option == 4 and VanadielTime() >= acrimonyTimer then
            player:updateEvent(4, 0, 0, 1)
        end
    end
end

function onEventFinish(player, csid, option)
    -- Give player reward
    local objecttrade = player:getCharVar("venereward")
    if csid == 10066 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, objecttrade)
        else
            player:tradeComplete()
            player:addItem(objecttrade)
            player:messageSpecial(ID.text.ITEM_OBTAINED, objecttrade)
            player:setCharVar("venereward", 0)
        end
    end

    local abandonmentTimer = player:getCharVar("[ENM]abandonmentTimer")
    local antipathyTimer = player:getCharVar("[ENM]antipathyTimer")
    local animusTimer = player:getCharVar("[ENM]animusTimer")
    local acrimonyTimer = player:getCharVar("[ENM]acrimonyTimer")

    -- Give player KI
    if csid == 10065 or csid == 10064 then
        if option == 1 and VanadielTime() >= abandonmentTimer and player:hasKeyItem(tpz.ki.CENSER_OF_ABANDONMENT) == false then
            player:addKeyItem(tpz.ki.CENSER_OF_ABANDONMENT)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.CENSER_OF_ABANDONMENT)
            player:setCharVar("[ENM]abandonmentTimer", VanadielTime()+(ENM_COOLDOWN*3600)) -- Current time + (ENM_COOLDOWN*1hr in seconds)
        elseif option == 2 and VanadielTime() >= antipathyTimer and player:hasKeyItem(tpz.ki.CENSER_OF_ANTIPATHY) == false then
            player:addKeyItem(tpz.ki.CENSER_OF_ANTIPATHY)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.CENSER_OF_ANTIPATHY)
            player:setCharVar("[ENM]antipathyTimer", VanadielTime()+(ENM_COOLDOWN*3600)) -- Current time + (ENM_COOLDOWN*1hr in seconds)
        elseif option == 3 and VanadielTime() >= animusTimer and player:hasKeyItem(tpz.ki.CENSER_OF_ANIMUS) == false then
            player:addKeyItem(tpz.ki.CENSER_OF_ANIMUS)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.CENSER_OF_ANIMUS)
            player:setCharVar("[ENM]animusTimer", VanadielTime()+(ENM_COOLDOWN*3600)) -- Current time + (ENM_COOLDOWN*1hr in seconds)
        elseif option == 4 and VanadielTime() >= acrimonyTimer and player:hasKeyItem(tpz.ki.CENSER_OF_ACRIMONY) == false then
            player:addKeyItem(tpz.ki.CENSER_OF_ACRIMONY)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.CENSER_OF_ACRIMONY)
            player:setCharVar("[ENM]acrimonyTimer", VanadielTime()+(ENM_COOLDOWN*3600)) -- Current time + (ENM_COOLDOWN*1hr in seconds)
        end
    end
end
