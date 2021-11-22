-----------------------------------
-- Area: Port Bastok
--  NPC: Moogle
-- Event Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Port_Bastok/IDs")
require("scripts/globals/shop")
require("scripts/globals/events/starlight_festivals")
local Starlight = isStarlightEnabled()

function onTrigger(player, npc)

    if Starlight ~= 0 then
        local stock =
        {
            4216, 400, -- Popstar
            4218, 672, -- Air Rider
            4167, 231, -- Cracker
            4168, 275, -- Twinkle Shower
            4169, 275, -- Little Comet
            15178, 10000, -- Dream Hat
            115, 10000, -- Basokan Holiday Tree
            87, 10000, -- Kadomatsu
        }

    player:showText(npc, ID.text.FESTIVE_MOOGLE_DIALOG)
    tpz.shop.general(player, stock, BASTOK)

    else

    player:showText(npc, ID.text.THANK_YOU)


    end
end
