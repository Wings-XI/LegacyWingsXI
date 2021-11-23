-----------------------------------
-- Area: The Ashu Talif
-- Ancient Lockbox
-----------------------------------
local ID = require("scripts/zones/The_Ashu_Talif/IDs")
require("scripts/globals/appraisal")
-----------------------------------

function onTrigger(player, npc)
    local loot =
    {
        {itemid =  748, droprate = 100}, -- Gold Beastcoin
        {itemid =  749, droprate = 100}, -- Mythril Beastcoin
        {itemid =  751, droprate = 100}, -- Platinum Beastcoin
        {itemid =  784, droprate = 100}, -- Jadeite
        {itemid =  785, droprate = 100}, -- Emerald
        {itemid =  786, droprate = 100}, -- Ruby
        {itemid =  787, droprate = 100}, -- Diamond
        {itemid =  788, droprate = 100}, -- Peridot
        {itemid =  789, droprate = 100}, -- Topaz
        {itemid =  790, droprate = 100}, -- Garnet
        {itemid =  791, droprate = 100}, -- Aquamarine
        {itemid =  792, droprate = 100}, -- Pearl
        {itemid =  793, droprate = 100}, -- Black Pearl
        {itemid =  794, droprate = 100}, -- Sapphire
        {itemid =  797, droprate = 100}, -- Painite
        {itemid =  798, droprate = 100}, -- Turquoise
        {itemid =  801, droprate = 100}, -- Chrysoberyl
        {itemid =  802, droprate = 100}, -- Moonstone
        {itemid =  803, droprate = 100}, -- Sunstone
        {itemid =  804, droprate = 100}, -- Spinel
        {itemid =  805, droprate = 100}, -- Zircon
        {itemid =  808, droprate = 100}, -- Goshenite
        {itemid =  810, droprate = 100}, -- Fluorite
        {itemid =  811, droprate = 100}, -- Ametrine
        {itemid =  813, droprate = 100}, -- Angelstone
        {itemid =  815, droprate = 100}, -- Sphene
    }
    local qItem =
    {
        [55] =
        {
            {itemid = 2286, droprate = 600}, -- ??? box
            {itemid = 2191, droprate = 400}, -- ??? dagger
        },
    }
    local regItem =
    {
        [55] = {itemid = 2359, droprate = 100} -- Star Sapphire
        
    }

    local instance = player:getInstance()
    local instanceID = instance:getID()
    local chars = instance:getChars()
    local chestID = npc:getID()
    local qChest = false

    if chestID == 17023010 then
        qChest = true
    end

    if instance:completed() and npc:getLocalVar("open") == 0 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED + 1)
        else
            npc:entityAnimationPacket("open")
            npc:setLocalVar("open", 1)
            npc:timer(15000, function(npc) npc:entityAnimationPacket("kesu") end)
            npc:timer(16000, function(npc) npc:setStatus(tpz.status.DISAPPEAR) end)

            if qChest then
                local lootGroup = qItem[instanceID]
                if lootGroup then
                    local max = 0
                    for _, entry in pairs(lootGroup) do
                        max = max + entry.droprate
                    end
                    local roll = math.random(max)
                    for _, entry in pairs(lootGroup) do
                        max = max - entry.droprate
                        if roll > max then
                            if entry.itemid > 0 then
                                player:addItem({id = entry.itemid, appraisal = instanceID})
                                for _, v in pairs(chars) do
                                    v:messageName(ID.text.PLAYER_OBTAINS_ITEM, player, entry.itemid)
                                end
                                break
                            end
                        end
                    end
                end
            else
                player:addTreasure(18712, npc) -- Koga Shuriken 100%

                table.insert(loot, regItem[instanceID]) -- Add quest specific item
                for i = 1, 3 do -- 3 more items
                    local max = 0
                    for _, entry in pairs(loot) do
                        max = max + entry.droprate
                    end
                    local roll = math.random(max)
                    for _, entry in pairs(loot) do
                        max = max - entry.droprate
                        if roll > max then
                            if entry.itemid ~= 0 then
                                player:addTreasure(entry.itemid, npc)
                            end
                            break
                        end
                    end
                end
            end
        end
    end


end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
