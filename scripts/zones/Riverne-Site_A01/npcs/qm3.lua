-----------------------------------
-- Area: Riverne Site #A01
--  NPC: ???
-- !pos -514.717 -6.684 -407.314
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/quests")
local ID = require("scripts/zones/Riverne-Site_A01/IDs")
-----------------------------------


function onTrigger(player, npc)
    if ((player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.SPICE_GALS) == QUEST_ACCEPTED or player:getCharVar("SpiceGalsRepeat") == 1) and not player:hasKeyItem(tpz.ki.RIVERNEWORT)) then
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.RIVERNEWORT)
        player:addKeyItem(tpz.ki.RIVERNEWORT)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end
