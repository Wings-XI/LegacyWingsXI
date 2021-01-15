-----------------------------------
-- Area: GM_Home
--  NPC: Equip Navi
-- New GM and swag vendor
-----------------------------------
require("scripts/globals/events/harvest_festivals")
local ID = require("scripts/zones/GM_Home/IDs")
require("scripts/globals/shop")

function onTrigger(player, npc)
    local stock =
    {
        17644, 1,    --Judge's Sword
        12523, 1,    --Judge's Helm
        12551, 1,    --Judge's Curiass
        12679, 1,    --Judge's Gauntlets
        12807, 1,    --Judge's Cuisses
        12935, 1,    --Judge's Greaves
        16622, 1,     --Judge's Sword (2h)
        16132, 1,     --Dandy Spectacles
    }

    tpz.shop.general(player, stock)
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
end