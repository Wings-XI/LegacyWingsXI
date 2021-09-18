-----------------------------------
-- Area: Bastok Mines
--  NPC: Moogle
-- Event Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/shop")
require("scripts/globals/events/harvest_festivals")
local Halloween = isHalloweenEnabled()

function onTrigger(player, npc)
    if Halloween ~= 0 then
        local stock =
        {
            4488, 1000,     -- Jack-o'-Lantern
            204, 5000,      -- Pumpkin Lantern
            203, 5000,      -- Bomb Lantern
            205, 5000,      -- Mandragora Lantern
            3624, 10000,    -- Korrigan Pricket
        }

    player:showText(npc, ID.text.FESTIVE_MOOGLE_DIALOG)
    tpz.shop.general(player, stock, WINDURST_WATERS)
    
    else
   
    player:showText(npc, ID.text.THANK_YOU)

    end
end
