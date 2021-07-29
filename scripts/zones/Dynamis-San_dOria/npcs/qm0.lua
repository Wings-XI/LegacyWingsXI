-----------------------------------
-- Area: Dynamis-San_dOria
--  NPC: ??? (qm0) (17535223)
-- Note: grants win KI
-----------------------------------
require("scripts/globals/dynamis")
require("scripts/globals/keyitems")
-----------------------------------

function onTrigger(player, npc)
    if player:hasKeyItem(tpz.ki.HYDRA_CORPS_COMMAND_SCEPTER) == false then
        player:addKeyItem(tpz.ki.HYDRA_CORPS_COMMAND_SCEPTER)
        local ID = require("scripts/zones/Dynamis-San_dOria/IDs")
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.HYDRA_CORPS_COMMAND_SCEPTER)
    end
end
