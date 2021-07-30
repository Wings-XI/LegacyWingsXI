-----------------------------------
-- Area: Dynamis-Jeuno
--  NPC: ??? (qm0) (17547509)
-- Note: grants win KI
-----------------------------------
require("scripts/globals/dynamis")
require("scripts/globals/keyitems")
-----------------------------------

function onTrigger(player, npc)
    if player:hasKeyItem(tpz.ki.HYDRA_CORPS_TACTICAL_MAP) == false then
        player:addKeyItem(tpz.ki.HYDRA_CORPS_TACTICAL_MAP)
        local ID = require("scripts/zones/Dynamis-Jeuno/IDs")
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.HYDRA_CORPS_TACTICAL_MAP)
    end
end
