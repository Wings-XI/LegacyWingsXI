------------------------------------
-- Harvest Festivals
------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/utils")
------------------------------------

function isHalloweenEnabled()
    local option = 0
    local month = tonumber(os.date("%m"))
    local day = tonumber(os.date("%d"))
    if (month == 10 and day >= 20 or month == 11 and day == 1 or HALLOWEEN_YEAR_ROUND ~= 0) then -- According to wiki Harvest Fest is Oct 20 - Nov 1.
        if (HALLOWEEN_2005 == 1) then
            option = 1
        -- Commented out additional years until they are developed
        -- elseif (HALLOWEEN_2008 == 1) then
        --     option = 2
        -- elseif (HALLOWEEN_2009 == 1) then
        --     option = 3
        -- elseif (HALLOWEEN_2010 == 1) then
        --     option = 4
        end
    end

    return option
end


function halloweenItemsCheck(player)
    local headSlot = player:getEquipID(tpz.slot.HEAD)
    local mainHand = player:getEquipID(tpz.slot.MAIN)
    local reward = 0

    -- Normal Quality Rewards
    local pumpkinHead = 13916
    local pumpkinHead2 = 15176
    local trickStaff = 17565
    local trickStaff2 = 17587
    local pitchfork = 18102

    reward_list = {pumpkinHead, pumpkinHead2, trickStaff, trickStaff2, pitchfork}
    -- To Do: Move Pitchforks into seperate questline involving the bomb decorations in future events. --
    -- Checks for HQ Upgrade
    for ri = 1, #reward_list do
        if (headSlot == reward_list[ri] or mainHand == reward_list[ri]) then
            if (headSlot == pumpkinHead and player:hasItem(13917) == false) then
                reward = 13917 -- Horror Head
            elseif (headSlot == pumpkinHead2 and player:hasItem(15177) == false) then
                reward = 15177 -- Horror Head II
            elseif (mainHand == trickStaff and player:hasItem(17566) == false) then
                reward =  17566 -- Treat Staff
            elseif (mainHand == trickStaff2 and player:hasItem(17588) == false) then
                reward = 17588 -- Treat Staff II
            elseif (mainHand == pitchfork and player:hasItem(18103) == false) then
                reward = 18103 -- Pitchfork +1
            end
            return reward
        end
    end

    -- Checks the possible item rewards to ensure player doesnt already have the item we are about to give them
    local cnt = #reward_list

    while cnt ~= 0 do
        local picked = reward_list[math.random(1, #reward_list)]
        if (player:hasItem(picked) == false) then
            reward = picked
            cnt = 0
        else
            table.remove(reward_list, picked)
            cnt = cnt - 1
        end
    return reward
    end
end

function onHalloweenTrade(player, trade, npc)
    local zone = player:getZoneName()
    local ID = zones[player:getZoneID()]

    local contentEnabled = isHalloweenEnabled()
    local item = trade:getItemId()
    -------------------
    -- 2005 edition ---
    -------------------
    if (contentEnabled == 1) then
        -----------------------------------
        -- Treats allowed
        -----------------------------------
        local treats_table =
        {
            4510, -- Acorn Cookie
            5646, -- Bloody Chocolate
            4496, -- Bubble Chocolate
            4397, -- Cinna-cookie
            4394, -- Ginger Cookie
            4495, -- Goblin Chocolate
            4413, -- Apple Pie
            4488, -- Jack-o'-Pie
            4421, -- Melon Pie
            4563, -- Pamama Tart
            4446, -- Pumpkin Pie
            4414, -- Rolanberry Pie
            4406, -- Baked Apple
            5729, -- Bavarois
            5745, -- Cherry Bavarois
            5653, -- Cherry Muffin
            5655, -- Coffee Muffin
            5718, -- Cream Puff
            5144, -- Crimson Jelly
            5681, -- Cupid Chocolate
            5672, -- Dried Berry
            5567, -- Dried Date
            4556, -- Icecap Rolanberry
            5614, -- Konigskuchen
            5230, -- Love Chocolate
            4502, -- Marron Glace
            4393, -- Orange Kuchen
            5147, -- Snoll Gelato
            4270, -- Sweet Rice Cake
            5645, -- Witch Nougat
            5552, -- Black Pudding  --safe
            5550, -- Buche au Chocolat -- safe @ 43 items
            5616, -- Lebkuchen House --breaks
            5633, -- Chocolate Cake
            5542, -- Gateau aux Fraises
            5572, -- Irmik Helvasi
            5625, -- Maple Cake
            5559, -- Mille Feuille
            5557, -- Mont Blanc
            5629, -- Orange Cake
            5631, -- Pumpkin Cake
            5577, -- Sutlac
            5627, -- Yogurt Cake
        }

        for itemInList = 1, #treats_table  do

            if (item == treats_table[itemInList]) then
                local itemReward = halloweenItemsCheck(player)
                local varName = "harvestFestTreats"
                local harvestFestTreats
                if (itemInList < 32) then -- The size of the list is too big for int 32 used that stores the bit mask, as such there are two lists

                    harvestFestTreats = player:getCharVar(varName)
                else

                    varName = "harvestFestTreats2"
                    harvestFestTreats = player:getCharVar(varName) --  this is the second list
                    itemInList = itemInList - 32
                end

                if (itemReward ~= 0 and player:getFreeSlotsCount() >= 1 and math.random(1, 3) < 2) then -- Math.random added so you have 33% chance on getting item

                    player:messageSpecial(ID.text.THANK_YOU_TREAT)
                    player:addItem(itemReward)
                    player:messageSpecial(ID.text.ITEM_OBTAINED, itemReward)

                elseif player:canUseMisc(tpz.zoneMisc.COSTUME) then

                    -- Possible costume values:
                    local Yagudo = math.random(580, 607)
                    local Quadav = math.random(644, 671)
                    local Shade = math.random(535, 538)
                    local Orc = math.random(612, 639)
                    local Ghost = 368
                    local Hound = 365
                    local Skeleton = 564
                    local Gob = math.random(484, 511)
                    local Gigas = math.random(707, 711)
                    local Demon = math.random(740, 756)
                    local Dark_Stalker = math.random(531, 534)

                    local halloween_costume_list = {Quadav, Orc, Yagudo, Shade, Ghost, Hound, Skeleton, Dark_Stalker, Gob, Gigas, Demon}

                    local costumePicked = halloween_costume_list[math.random(1, #halloween_costume_list)] -- will randomly pick one of the costumes in the list
                    player:addStatusEffect(tpz.effect.COSTUME, costumePicked, 0, 3600)
                    player:messageSpecial(ID.text.TRICK_OR_TREAT)
                else
                    player:messageSpecial(ID.text.THANK_YOU)
                end

                player:tradeComplete()

            end
        end
    end
end

-- Apply Zone Decorations and Vendors--
function applyHalloweenDecorations(zoneid)
    if isHalloweenEnabled() ~= 0 then
        local decoration = zones[zoneid].npc.HALLOWEEN_DECORATIONS
        if decoration then
            for id, decoration in pairs(decoration) do
                local npc = GetNPCByID(id)
                if npc then
                    npc:setStatus(tpz.status.NORMAL)
                    local npcstatus = npc:getStatus()
                end
            end
        end
    end
end

-- Apply Roaming Monsters--
function applyHalloweenRoaming(zoneid)
    if isHalloweenEnabled() ~= 0 then
        local roam = zones[zoneid].npc.HALLOWEEN_ROAMING
        if roam then
            for id, roam in pairs(roam) do
                local npc = GetNPCByID(id)
                if npc then
                    npc:setStatus(tpz.status.NORMAL)
                    local npcstatus = npc:getStatus()
                end
            end
        end
    end
end

-- Apply NPC Costumes --
function applyHalloweenNpcCostumes(zoneid)
    if isHalloweenEnabled() ~= 0 then
        local skin = zones[zoneid].npc.HALLOWEEN_SKINS
        if skin then
            for id, skin in pairs(skin) do
                local npc = GetNPCByID(id)
                if npc then
                    npc:setModelId(skin)
                end
            end
        end
    end
end
