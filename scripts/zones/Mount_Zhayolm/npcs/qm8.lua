-----------------------------------
-- Area: Mount Zhayolm
--  NPC: ??? (Puppetmaster Blues Quest)
-- !pos 760.798 -14.972 1.656
-----------------------------------
local ID = require("scripts/zones/Mount_Zhayolm/IDs")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local PuppetmasterBluesProgress = player:getCharVar("PuppetmasterBluesProgress")

    player:messageSpecial(7533) -- always displays

    if (PuppetmasterBluesProgress == 2 and not player:hasKeyItem(tpz.ki.TOGGLE_SWITCH)) then
        player:addKeyItem(tpz.ki.TOGGLE_SWITCH)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.TOGGLE_SWITCH)
    end
end