-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Geltpix
-- !pos 154 -2 103 80
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria_[S]/IDs")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        4116, 4500,  -- Hi-Potion
        4132, 28000, -- Hi-Ether
        1020, 300,   -- Sickle
        1021, 300,   -- Hatchet
    }

    player:showText(npc, ID.text.GELTPIX_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
