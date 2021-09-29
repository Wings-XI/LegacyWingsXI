-----------------------------------
-- Area: Dynamis-Beaucedine
--  NPC: ??? (qm0)
-- Note: Spawns Angra Mainyu / Arch Angra Mainyu
-----------------------------------
require("scripts/globals/dynamis")
require("scripts/globals/keyitems")
-----------------------------------

function onTrigger(player, npc)
    if player:hasKeyItem(tpz.ki.HYDRA_CORPS_INSIGNIA) == false then
        player:addKeyItem(tpz.ki.HYDRA_CORPS_INSIGNIA)
        local ID = require("scripts/zones/Dynamis-Beaucedine/IDs")
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.HYDRA_CORPS_INSIGNIA)
    end
end
