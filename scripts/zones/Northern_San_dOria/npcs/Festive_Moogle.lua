-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Moogle
-- Event Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/shop")
require("scripts/globals/events/harvest_festivals")
require("scripts/globals/events/starlight_festivals")
local Halloween = isHalloweenEnabled()
local Starlight = isStarlightEnabled()

function onTrigger(player, npc)

    if Halloween ~= 0 then
        local stock =
        {
            4488, 1000,     -- Jack-o'-Lantern
            204, 5000,      -- Pumpkin Lantern
            203, 5000,      -- Bomb Lantern
            205, 5000,      -- Mandragora Lantern
            3622, 10000,    -- Jack-o-Pricket
        }

    elseif Starlight ~= 0 then
        local stock =
        {
            4217, 400, -- Sparkling Hand
            4218, 672, -- Air Rider
            4167, 231, -- Cracker
            4168, 275, -- Twinkle Shower
            4169, 275, -- Little Comet
            15178, 10000, -- Dream Hat
            86, 10000, -- San d'Orian Holiday Tree
            87, 10000, -- Kadomatsu
        }

    player:showText(npc, ID.text.FESTIVE_MOOGLE_DIALOG)
    tpz.shop.general(player, stock, SANDORIA)

    else

    player:showText(npc, ID.text.THANK_YOU)


    end
end
