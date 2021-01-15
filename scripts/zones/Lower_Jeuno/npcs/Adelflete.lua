-----------------------------------
-- Area: Lower Jeuno
--  NPC: Adelflete
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        806,   1552,    -- Tourmaline
        807,   1552,    -- Sardonyx
        800,   1552,    -- Amethyst
        814,   1552,    -- Amber
        795,   1552,    -- Lapis Lazuli
        809,   1552,    -- Clear Topaz
        799,   1552,    -- Onyx
        796,   1552,    -- Light Opal
        13327, 1250,    -- Silver Earring
        13456, 1250,    -- Silver Ring
    }

    player:showText(npc, ID.text.ADELFLETE_SHOP_DIALOG)
    tpz.shop.general(player, stock, JEUNO)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
