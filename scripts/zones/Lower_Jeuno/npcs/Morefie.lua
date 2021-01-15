-----------------------------------
-- Area: Lower Jeuno
--  NPC: Morefie
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        13327, 1150,    -- Silver Earring
        13456, 1150,    -- Silver Ring
        13328, 4140,    -- Mythril Earring
    }

    player:showText(npc, ID.text.MOREFIE_SHOP_DIALOG)
    tpz.shop.general(player, stock, JEUNO)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
