-----------------------------------
-- Area: Toraimarai Canal
--  NPC: ???
-- Involved In AM10 Battaru Royale
-----------------------------------
require("scripts/globals/status")
local ID = require("scripts/zones/Toraimarai_Canal/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCurrentMission(ASA) >= tpz.mission.id.asa.FOUNTAIN_OF_TROUBLE and player:hasKeyItem(tpz.ki.DARK_SAP_CRYSTAL) == false then
        player:addKeyItem(tpz.ki.DARK_SAP_CRYSTAL)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.DARK_SAP_CRYSTAL)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
