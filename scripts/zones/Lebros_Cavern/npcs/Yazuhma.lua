-----------------------------------
-- Area: Lebros Cavern
-- NPC: Yakuhma
-----------------------------------
local ID = require("scripts/zones/Lebros_Cavern/IDs")
--require("scripts/globals/items")
require("scripts/globals/status")
-----------------------------------

local assaultFood =
{
    [1] = 5142, -- Serving of Bison Steak
    [2] = 5166, -- Coeurl Sub
    [3] = 5207, -- Strip of Bison Jerky
    [4] = 4416, -- Bowl of Pea Soup
    [5] = 4356, -- Loaf of White Bread
}

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local instance = npc:getInstance()
    local entity = instance:getEntity(bit.band(npc:getID(), 0xFFF), tpz.objType.NPC)
    local progress = instance:getProgress()
    local message_offset = ID.text.FED_STORMERS_1
    printf("3")
    if player:getLocalVar("foodGiven") == 0 then
        player:setLocalVar("foodGiven", math.random(1,6))
    end
    printf("4")
    local food = assaultFood[player:getLocalVar("foodGiven")]


    if not player:hasItem(food, tpz.inventoryLocation.TEMPITEMS) then
        player:addTempItem(food)
        player:messageText(npc, ID.text.DEPENDING_ON)
        player:timer(3000, function(player) player:messageSpecial(ID.text.TEMP_ITEM, food) end)
        printf("5")
        if progress > 5 and progress < 9 then
            message_offset = message_offset + 1
        elseif progress > 8 and progress < 10 then
            message_offset = message_offset + 2
        elseif progress == 11 then
            message_offset = message_offset + 3
        end
        player:timer(6000, function(player) player:showText(entity, message_offset) end)
    else
        printf("6")
        player:messageText(npc, ID.text.HAVE_RATIONS)
        player:timer(3000, function(player) player:showText(entity, message_offset) end)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end