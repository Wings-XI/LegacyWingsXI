-----------------------------------
-- Area: Bastok Mines
--  NPC: Moogle
-- Event Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Bastok_Mines/IDs")
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
            3623, 10000,    -- Djinn Pricket
        }

    player:showText(npc, ID.text.FESTIVE_MOOGLE_DIALOG)
    tpz.shop.general(player, stock, BASTOK_MINES)
    
    else
   
    player:showText(npc, ID.text.THANK_YOU)

    end
end
