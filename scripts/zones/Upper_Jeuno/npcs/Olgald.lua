-----------------------------------
-- Area: Upper Jeuno
--   NPC: Olgald
-- Type: Standard NPC
-- !pos -53.072 -1 103.380 244
--
-- Auto-Script: Requires Verification (Verified by Brawndo)
-----------------------------------
local ID = require("scripts/zones/Upper_Jeuno/IDs")
-----------------------------------

local itemXRefs =
{
    -- Male to Female, NQ
    [14578] = 14579,    -- dancers_casaque
    [15002] = 15003,    -- dancers_bangles
    [15659] = 15660,    -- dancers_tights
    [15746] = 15747,    -- dancers_toe_shoes
    [16138] = 16139,    -- dancers_tiara
    -- Female to Male, NQ
    [14579] = 14578,
    [15003] = 15002,
    [15660] = 15659,
    [15747] = 15746,
    [16139] = 16138,
    -- Male to Female, HQ
    [11302] = 11303,    -- dancers_casaque_+1
    [11393] = 11394,    -- dancers_toe_shoes_+1
    [11475] = 11476,    -- dancers_tiara_+1
    [15035] = 15036,    -- dancers_bangles_+1
    [16357] = 16358,    -- dancers_tights_+1
    -- Female to Male, HQ
    [11303] = 11302,
    [11394] = 11393,
    [11476] = 11475,
    [15036] = 15035,
    [16358] = 16357,
}

function onTrade(player, npc, trade)
    -- make sure there is only one item in the trade
    if trade:getItemCount() == 1 then
        -- look for traded item
        for k, v in pairs(itemXRefs) do
            if trade:hasItemQty(k, 1) then
                if player:getFreeSlotsCount() > 0 then
                    player:tradeComplete()
                    player:PrintToPlayer("Olgald : Ah, well we are all fine with accepting the new you.. Here you go.", 0xD)
                    player:addItem(v)
                    player:messageSpecial(ID.text.ITEM_OBTAINED, v)
                else
                    player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, v)
                end

                -- item matched, no need to continue looping
                return
            end
        end
    end
end

function onTrigger(player, npc)

    if (player:getCharVar("dancerTailorCS") == 1) then
        player:startEvent(10167)
    elseif (player:getCharVar("comebackQueenCS") == 1) then
        player:startEvent(10146)
    elseif (player:getCharVar("comebackQueenCS") == 3) then
        player:startEvent(10150)
    elseif (player:getCharVar("comebackQueenCS") == 5) then --player cleared Laila's story
        player:startEvent(10156)
    else
        --player:startEvent(10122)
        player:PrintToPlayer("Olgald : Feel free to trade me your old Dancer equipment for another kind...", 0xD)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 10167) then
        player:setCharVar("dancerTailorCS", 2)
    end
end
