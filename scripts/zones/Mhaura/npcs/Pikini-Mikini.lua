-----------------------------------
-- Area: Mhaura
--  NPC: Pikini-Mikini
-- Standard Merchant NPC
-- !pos -48 -4 30 249
-----------------------------------
local ID = require("scripts/zones/Mhaura/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        4150, 2335,    -- Eye Drops
        4148,  284,    -- Antidote
        4151,  720,    -- Echo Drops
        4112,  819,    -- Potion
        4509,   10,    -- Distilled Water
        --917,  1821,    -- Parchment
        17395,   9,    -- Lugworm
        1021,  450,    -- Hatchet
        4376,  108,    -- Meat Jerky
        5299,  133,    -- Salsa
        4716, 3888,    -- scroll of regen
        4718, 7047,    -- scroll of regen ii
        4881,10080,    -- scroll of sleepga
        --2867, 9000,    -- Mhaura Waystone
    }

    player:showText(npc, ID.text.PIKINIMIKINI_SHOP_DIALOG)
    tpz.shop.general(player, stock, MHAURA)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
