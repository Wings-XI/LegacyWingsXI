-----------------------------------
-- Area: Bastok Markets
--  NPC: Peritrage
-- Standard Merchant NPC
-- !pos -286.985 -10.319 -142.586 235
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/shop")

function onTrigger(player, npc)
    local stock =
    {
        --16643, 11285, 1,    -- Battleaxe
        --16473,  5713, 1,    -- Kukri
        17218, 14158, 1,    -- zamburak
        17298,   294, 1,    -- tathlum
        17217,  2166, 2,    -- crossbow
        17337,    22, 2,    -- mythril bolt
        --16640,   290, 3,    -- Bronze Axe
        --16641,  1435, 3,    -- Brass Axe
        --16704,   618, 3,    -- Butterfly Axe
        --16705,  4186, 3,    -- Greataxe
        --16465,   150, 3,    -- Bronze Knife
        --16466,  2231, 3,    -- Knife
        --16448,   143, 3,    -- Bronze Dagger
        --16449,   855, 3,    -- Brass Dagger
        --16450,  1867, 3,    -- Dagger
        17216,   165, 3,    -- light crossbow
        17336,     5, 3,    -- crossbow bolt
    }

    player:showText(npc, ID.text.PERITRAGE_SHOP_DIALOG)
    tpz.shop.nation(player, stock, tpz.nation.BASTOK)
end
