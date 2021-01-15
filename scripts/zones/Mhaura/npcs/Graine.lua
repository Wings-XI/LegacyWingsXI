-----------------------------------
-- Area: Mhaura
--  NPC: Graine
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Mhaura/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        12440,  404,    -- Leather Bandana
        12448,  154,    -- Bronze Cap
        12449, 1504,    -- Brass Cap
        12568,  618,    -- Leather Vest
        12576,  235,    -- Bronze Harness
        12577, 2286,    -- Brass Harness
        12696,  331,    -- Leather Gloves
        12704,  128,    -- Bronze Mittens
        12705, 1255,    -- Brass Mittens
        12824,  493,    -- Leather Trousesrs
        12832,  191,    -- Bronze Subligar
        12833, 1840,    -- Brass Subligar
        12952,  309,    -- Leather Highboots
        12960,  117,    -- Bronze Leggings
        12961, 1140,    -- Brass Leggings
    }

    player:showText(npc, ID.text.GRAINE_SHOP_DIALOG)
    tpz.shop.general(player, stock, MHAURA)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
