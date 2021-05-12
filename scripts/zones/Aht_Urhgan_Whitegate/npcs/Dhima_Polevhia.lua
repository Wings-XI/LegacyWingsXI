-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Dhima Polevhia
--  Puppetmaster AF NPC
-- !pos 67.802 -6.000 26.315
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/npc_util")
-----------------------------------

local craftingItems = {
    [1] = -- puppetry tobe
    {
        materials = {786, 1636, 1699, 2289, {2187, 1}},
        result = 14523
    } , 
    [2] = -- puppetry dastanas
    {
        materials = {821, 2289, 2152, 754, {2186, 1}},
        result = 14930
    },
    [3] = -- puppetry babouches
    {
        materials = {786, 2289, 2152, 754, {2186, 2}},
        result = 15686
    }
}

function onTrade(player, npc, trade)
    local PuppetmasterBlues = player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.PUPPETMASTER_BLUES)

    if PuppetmasterBlues >= QUEST_ACCEPTED then
        if (player:getCharVar("[PUPAF]Current") > 0 and player:getCharVar("[PUPAF]TradeDone") == 0) then
            if (npcUtil.tradeHasExactly(trade, craftingItems[player:getCharVar("[PUPAF]Current")].materials)) then
                player:startEvent(795)
            end
        end
    end
end
       
function onTrigger(player, npc)
    local PuppetmasterBlues = player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.PUPPETMASTER_BLUES)

    if PuppetmasterBlues >= QUEST_ACCEPTED then
        local remainingPUPAF = player:getCharVar("[PUPAF]Remaining") -- Bitmask of AF the player has NOT crafted
        local totalCraftedPieces = 3 - player:countMaskBits(remainingPUPAF)
        local currentTask = player:getCharVar("[PUPAF]Current")
        local tradeDone = player:getCharVar("[PUPAF]TradeDone")
        local pickupReady = vanaDay() > player:getCharVar("[PUPAF]TradeDay")

        if currentTask == 0 and totalCraftedPieces ~= 3 then
            if totalCraftedPieces == 0 then
                player:startEvent(789) -- first interaction
            else
                player:startEvent(791, 0, 14 - (remainingPUPAF * 2)) -- followup interaction, hides already crafted items
            end
        elseif currentTask > 0 then
            if tradeDone == 0 then
                player:startEvent(790, 0,0,0, currentTask)
            elseif not pickupReady then
                player:startEvent(796) -- patience is a virtue
            else
                player:startEvent(792) -- give item
            end
        elseif totalCraftedPieces == 3 then
            player:startEvent(793) -- Dialogue after crafting all PUP AF
        end
    else
        player:startEvent(788) -- Default dialogue
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 789 or csid == 791 then -- choosing CSs
        if option == 1 or option == 2 or option == 3 then -- player canceling the selection dialog will give an odd value here so be explicit
            player:setCharVar("[PUPAF]Current", option)
        end
    end
    local remainingPUPAF = player:getCharVar("[PUPAF]Remaining") -- Bitmask of AF the player has NOT crafted
    local currentTask = player:getCharVar("[PUPAF]Current")

    if csid == 795 then -- Trade Accepted
        player:confirmTrade()
        player:setCharVar("[PUPAF]TradeDay", vanaDay())
        player:setCharVar("[PUPAF]TradeDone", 1)
    elseif csid == 792 then --Item Complete
        if npcUtil.giveItem(player, craftingItems[currentTask].result) then
            remainingPUPAF = remainingPUPAF - math.pow(2, (currentTask - 1))
            player:setCharVar("[PUPAF]Remaining", remainingPUPAF)
            player:setCharVar("[PUPAF]Current", 0)
            player:setCharVar("[PUPAF]TradeDone", 0)
            player:setCharVar("[PUPAF]TradeDay", 0)
        end
    end
end