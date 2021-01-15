-----------------------------------
-- Area: Bastok Markets
--  NPC: Zhikkom
-- Standard Merchant NPC
-- !pos -288.669 -10.319 -135.064 235
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/shop")

function onTrigger(player, npc)
    local stock =
    {
        16473,  5589, 1, -- kukri
        16537, 30960, 1, -- Mythril Sword
        16545, 21067, 1, -- Broadsword
        16513, 11588, 1, -- Tuck
        16558, 61200, 1, -- Falchion
        16466,  2182, 2, -- knife
        16536,  7286, 2, -- Iron Sword
        16552,  4163, 2, -- Scimitar
        16535,   246, 3, -- Bronze Sword
        16517,  9201, 3, -- Degen
        16551,   689, 3, -- Sapara
        --16530,   618, 3, -- Xiphos
        --16565,  1711, 3, -- Spatha
        16512,  3215, 3, -- Bilbo
        16465,   147, 3, -- bronze knife
        16405,   104, 3, -- cat baghnakhs
    }

    player:showText(npc, ID.text.ZHIKKOM_SHOP_DIALOG)
    tpz.shop.nation(player, stock, tpz.nation.BASTOK)
end
