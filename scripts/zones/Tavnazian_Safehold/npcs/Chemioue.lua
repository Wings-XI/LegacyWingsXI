-----------------------------------
-- Area: Tavnazian Safehold
--   NPC: Chemioue
-- Type: NPC Quest
-- !pos 82.041 -34.964 67.636 26
--
-- Auto-Script: Requires Verification (Verified by Brawndo)
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/utils")
local ID = require("scripts/zones/Tavnazian_Safehold/IDs")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCharVar("InSearchOfTheTruthStatus") == 2 and player:getCharVar("InSearchOfTheTruthNPC_5") ~= 1 then
        player:startEvent(561)
    else
        player:startEvent(280)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 561 then
        player:setCharVar("InSearchOfTheTruthNPC_5", 1)
    end
end
