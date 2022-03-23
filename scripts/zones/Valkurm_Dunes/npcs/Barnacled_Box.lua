-----------------------------------
-- Area: Valkurm Dunes
--  NPC: Barnacled Box
-- Involved In Quest: Pirate's Chart
-----------------------------------
require("scripts/globals/treasure")
local ID = require("scripts/zones/Valkurm_Dunes/IDs")
-----------------------------------

local sharedLoot = {
    -- All items are assigned a "weight" here
    item1 =
    {
        [887]   = 50, -- Coral Fragment
        [17006] = 200, -- Drill Calamary 
        [17007] = 100, -- Dwarf Pugil 
        [1587]  = 50, -- HQ Pugil Scales 
        [624]   = 250, -- Pamtam Kelp 
        [1893]  = 100, -- Salinator 
        [4484]  = 150, -- Shall Shell 
        [4288]  = 100, -- Zebra Eel 
    },
    item2 =
    {
        [688]   = 200, -- Arrowwood Log
        [4580]  = 150, -- Butterfly Coral
        [887]   = 50, -- Coral Fragment
        [17006] = 150, -- Drill Calamary
        [17007] = 150, -- Dwarf Pugil
        [4361]  = 100, -- Nebimonite
        [4484]  = 200, -- Shall Shell
    },
    item3 =
    {
        [18104] = 880, -- Fuscina
        [18020] = 28, -- Mercurial Kris
        [1311 ] = 92, -- Oxblood
    },
    item4 =
    {
        [15555] = 1000 -- Albatross Ring
    }
}

local function convertToWeighted(loot)
    -- Takes a loot table formatted like the members of `sharedloot` and returns a weighted version that can be indexed
    local weightedLoot = {}

    for item, weight in pairs(loot) do
        for i = 1, weight do
            table.insert(weightedLoot, item)
        end
    end

    return weightedLoot
end

local function addLoot(t1, t2)
    -- Used for non-destructively combining a table containing a single weighted item (`t2`)
    -- and an existing loot table containing one or more weighted items (`t1`).
    newTable = {}
    newItem = table.maxn(t2)

    -- Copy the contents of the first table so that we don't modify the global version
    for item, weight in pairs(t1) do
        newTable[item] = weight
    end
    -- Add in our new item
    newTable[newItem] = t2[newItem]

    return newTable
end

-- Generate weighted loot tables now (on server init) so it doesn't have to be done at runtime
local w_item1   = convertToWeighted(sharedLoot.item1)
local w_item2   = convertToWeighted(sharedLoot.item2)
local w_item3   = convertToWeighted(sharedLoot.item3)
local w_item4   = convertToWeighted(sharedLoot.item4)

local function weightedRandomSelect(w_loot)
    -- Takes a weighted loot table and returns a single random result
    return w_loot[math.random(#w_loot)]
end
    function onTrade(player, npc, trade)        
    end
    
    function onTrigger(player, npc)
        local chestOwner = npc:getLocalVar("leaderID")

         -- First reward is 1 item from the item1 pool
        local boxitem1 = weightedRandomSelect(w_item1)
        -- Second reward is 1 item from the item2 pool
        local boxitem2 = weightedRandomSelect(w_item2)
        -- Third reward is a 1 item from the item3 pool
        local boxitem3 = weightedRandomSelect(w_item3)
        -- Final reward is the Albatross Ring
        local boxitem4 = weightedRandomSelect(w_item4)
        --Distribute rewards
        if npc:getLocalVar("open") == 0 and player:getLeaderID() == chestOwner then
            npc:entityAnimationPacket("open")
            npc:setLocalVar("open", 1)
            npc:timer(15000, function(npc) npc:entityAnimationPacket("kesu") end)
            npc:timer(16000, function(npc) npc:setStatus(tpz.status.DISAPPEAR) end)
            player:addTreasure(boxitem1, npc)
            player:addTreasure(boxitem2, npc)
            player:addTreasure(boxitem3, npc)
            player:addTreasure(boxitem4, npc) 
        end

        local shimmering = GetNPCByID(ID.npc.SHIMMERING_POINT)
        player:delPartyEffect(143) --Remove Level Restriction
        player:delPartyEffect(276) -- Remove Confrontation
        shimmering:setStatus(tpz.status.DISAPPEAR)
        local party = player:getParty()   
        for _,member in pairs(party) do
            member:ChangeMusic(0, 0)
            member:ChangeMusic(1, 0)
            member:ChangeMusic(2, 101)
            member:ChangeMusic(3, 102)
            member:setLocalVar("Chart", 0)
        end 

    end
    function onEventUpdate(player, csid, option)
    end
    
    function onEventFinish(player, csid, option)
    end