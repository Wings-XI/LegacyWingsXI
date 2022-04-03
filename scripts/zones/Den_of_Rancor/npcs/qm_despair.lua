-----------------------------------
-- Area: Den of Rancor
--  NPC: ??? - Tablet of Hexes: Despair
-- ASA12 KI
-- !pos
-----------------------------------
local ID = require("scripts/zones/Den_of_Rancor/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCurrentMission(ASA) >= tpz.mission.id.asa.SISTERS_IN_ARMS and player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_DESPAIR) == false then
        player:addKeyItem(tpz.ki.TABLET_OF_HEXES_DESPAIR)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.TABLET_OF_HEXES_DESPAIR)
    end
end
