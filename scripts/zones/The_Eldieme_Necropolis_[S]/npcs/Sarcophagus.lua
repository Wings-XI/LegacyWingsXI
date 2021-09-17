-----------------------------------
-- Area: The Eldieme Necropolis (S)
--  NPC: Sarcophagus
-- Type: Quest NPC
-- !pos  346.867 -32.407 -125.985 175
-----------------------------------
local ID = require("scripts/zones/The_Eldieme_Necropolis_[S]/IDs")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCharVar("BurdenOfSuspicion") == 2 then
        player:startEvent(17)
    else
        player:messageSpecial(ID.text.SARCOPHAGUS_SEALED)
    end
end

function onEventFinish(player, csid, option)
    if csid == 17 then
       player:setCharVar("BurdenOfSuspicion", 3) 
    end
end