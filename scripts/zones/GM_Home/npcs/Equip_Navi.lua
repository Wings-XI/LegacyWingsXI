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
        12332, 1,    --Judge's Shield
        12523, 1,    --Judge's Helm
        12551, 1,    --Judge's Curiass
        12679, 1,    --Judge's Gauntlets
        12807, 1,    --Judge's Cuisses
        12935, 1,    --Judge's Greaves
        13074, 1,    --Judge's Gorget
        13215, 1,    --Judge's Belt
        13358, 1,    --Judge's Earring
        13505, 1,    --Judge's Ring
        13606, 1,    --Jugge's Cape
        16622, 1,    --Judge's Sword (2h)
        17004, 1,    --Judge Minnow
        17012, 1,    --Judge's Rod
        17174, 1,    --Judge's Bow
        17326, 1,    --Judge's Arrow
        17406, 1,    --Judge's Lure
        17644, 1,    --Judge's Sword
        19325, 1,    --Judge Fly
        16132, 1,    --Dandy Spectacles
    }

    tpz.shop.general(player, stock)
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
end