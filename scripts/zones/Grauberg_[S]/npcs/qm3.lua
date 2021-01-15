-----------------------------------
-- Area: Grauberg (S)
--  NPC: qm3 (???)
-- !pos 439.398 -40.184 79.386 89
-- Involved in Quest: Message on the Winds
-----------------------------------
local ID = require("scripts/zones/Grauberg_[S]/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local questVar = player:getCharVar("Quest[7][1]Prog")

    if questVar == 3 then
        player:startEvent(3) -- CS after first Childerich CS
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 3 then
		player:setCharVar("Quest[7][1]Prog", 4)
    end
end
