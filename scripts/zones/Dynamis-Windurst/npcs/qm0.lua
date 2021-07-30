-----------------------------------
-- Area: Dynamis-Windurst
--  NPC: ??? (qm0) (17543479)
-- Note: grants win KI
-----------------------------------
require("scripts/globals/dynamis")
require("scripts/globals/keyitems")
-----------------------------------

function onTrigger(player, npc)
    if player:hasKeyItem(tpz.ki.HYDRA_CORPS_LANTERN) == false then
        player:addKeyItem(tpz.ki.HYDRA_CORPS_LANTERN)
        local ID = require("scripts/zones/Dynamis-Windurst/IDs")
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.HYDRA_CORPS_LANTERN)
    end
end
