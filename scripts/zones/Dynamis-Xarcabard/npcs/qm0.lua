-----------------------------------
-- Area: Dynamis-Xarcabard
--  NPC: ??? (qm0)
-- Note: Grants Win KI after killing Dynamis Lord
-----------------------------------
require("scripts/globals/dynamis")
require("scripts/globals/keyitems")
-----------------------------------

function onTrigger(player, npc)
    if player:hasKeyItem(tpz.ki.HYDRA_CORPS_BATTLE_STANDARD) == false then
        player:addKeyItem(tpz.ki.HYDRA_CORPS_BATTLE_STANDARD)
        local ID = require("scripts/zones/Dynamis-Xarcabard/IDs")
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.HYDRA_CORPS_BATTLE_STANDARD)
    end
end
