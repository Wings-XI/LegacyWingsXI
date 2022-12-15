-----------------------------------
-- Area: Cloister of Tremors
--  NPC: qm2 (???)
-- Involved in Quest: Open Sesame
-- Notes: Used to obtain a Tremor Stone
-- !pos -545.184, 1.855, -495.693 209
-----------------------------------
require("scripts/globals/settings")
local ID = require("scripts/zones/Cloister_of_Tremors/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local TREMORSTONE = 2796

    -- Give Player a Tremorstone if they don't have one
    if (player:hasItem(TREMORSTONE) == false) then
        npcUtil.giveItem(player, TREMORSTONE)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player, csid, option)
    -- printf("CSID2: %u", csid)
    -- printf("RESULT2: %u", option)
end

function onEventFinish(player, csid, option)
end
