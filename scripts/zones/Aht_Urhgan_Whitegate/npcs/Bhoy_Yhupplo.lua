-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Bhoy Yhupplo
-- Type: Assault Mission Giver
-- !pos 127.474 0.161 -30.418 50
-----------------------------------
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/besieged")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local rank = tpz.besieged.getMercenaryRank(player)
    local haveimperialIDtag
    local assaultPoints = player:getAssaultPoint(ILRUSI_ASSAULT_POINT)

    if (player:hasKeyItem(tpz.ki.IMPERIAL_ARMY_ID_TAG)) then
        haveimperialIDtag = 1
    else
        haveimperialIDtag = 0
    end

    if (rank > 0 and IS_ASSAULT_ACTIVATED == 1) then
        if (rank > MAX_ASSAULT_PROMOTION_ALLOWED) then
            rank = MAX_ASSAULT_PROMOTION_ALLOWED
        end
        player:startEvent(277, rank, haveimperialIDtag, assaultPoints, player:getCurrentAssault())
    else
        player:startEvent(283) -- no rank
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 277) then
        local selectiontype = bit.band(option, 0xF)
        if (selectiontype == 1) then
            -- taken assault mission
            player:addAssault(bit.rshift(option, 4))
            player:delKeyItem(tpz.ki.IMPERIAL_ARMY_ID_TAG)
            player:addKeyItem(tpz.ki.ILRUSI_ASSAULT_ORDERS)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.ILRUSI_ASSAULT_ORDERS)
        elseif (selectiontype == 2) then
            -- purchased an item
            local item = bit.rshift(option, 14)
            local itemID = 0
            local price = 0
            local items =
            {
                [1]  = {itemid = 15974, price = 3000},
                [2]  = {itemid = 15779, price = 5000},
                [3]  = {itemid = 15525, price = 8000},
                [4]  = {itemid = 15888, price = 10000},
                [5]  = {itemid = 15494, price = 10000},
                [6]  = {itemid = 18685, price = 15000},
                [7]  = {itemid = 18065, price = 15000},
                [8]  = {itemid = 17851, price = 15000},
                [9]  = {itemid = 16064, price = 20000},
                [10] = {itemid = 15604, price = 20000},
                [11] = {itemid = 14530, price = 20000},
            }

            local choice = items[item]
            if choice and npcUtil.giveItem(player, choice.itemid) then
                player:delAssaultPoint(choice.price, 4) -- Remove from ILRUSI_ASSAULT_POINT
            end
        end
    end
end