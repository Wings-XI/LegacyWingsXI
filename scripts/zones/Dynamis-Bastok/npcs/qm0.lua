-----------------------------------
-- Area: Dynamis-Bastok
--  NPC: ??? (qm0) (17539322)
-- Note: grants win KI
-----------------------------------
require("scripts/globals/dynamis")
require("scripts/globals/keyitems")
-----------------------------------

function onTrigger(player, npc)
    if player:hasKeyItem(tpz.ki.HYDRA_CORPS_EYEGLASS) == false then
        player:addKeyItem(tpz.ki.HYDRA_CORPS_EYEGLASS)
        local ID = require("scripts/zones/Dynamis-Bastok/IDs")
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.HYDRA_CORPS_EYEGLASS)
    end
end
