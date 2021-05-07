-----------------------------------
-- Area: Riverne Site #B01
--  NPC: ??? 
-- !pos -517.137 0.094 689.199
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/quests")
local ID = require("scripts/zones/Riverne-Site_B01/IDs")
-----------------------------------


function onTrigger(player, npc)
    if ((player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.SPICE_GALS) == QUEST_ACCEPTED or player:getCharVar("SpiceGalsRepeat") == 1) and not player:hasKeyItem(tpz.ki.RIVERNEWORT)) then
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.RIVERNEWORT)
        player:addKeyItem(tpz.ki.RIVERNEWORT)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end
