-----------------------------------
-- Area: Dragons Aery
--  NPC: qm0 (???)
-- Spawns Fafnir or Nidhogg
-- !pos -81 32 2 178
-----------------------------------
local ID = require("scripts/zones/Dragons_Aery/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onSpawn(npc)
    if LandKingSystem_NQ < 1 and LandKingSystem_HQ < 1 then
        npc:setStatus(tpz.status.DISAPPEAR)
    end
end

function onTrade(player, npc, trade)
    if not GetMobByID(ID.mob.FAFNIR):isSpawned() and not GetMobByID(ID.mob.NIDHOGG):isSpawned() then
        if LandKingSystem_NQ ~= 0 and npcUtil.tradeHas(trade, 3339) and npcUtil.popFromQM(player, npc, ID.mob.FAFNIR) then
            player:confirmTrade()
        elseif LandKingSystem_HQ ~= 0 and npcUtil.tradeHas(trade, 3340) and npcUtil.popFromQM(player, npc, ID.mob.NIDHOGG) then
            player:confirmTrade()
        end
    end
end

function onTrigger(player, npc)
    if player:getCharVar("AnnyEvent2020") == 11 and player:getCharVar("AnnyEvent2020_aery") == 0 and Anniversary_Event_2021 == 1 then
        if player:getFreeSlotsCount() > 0 then
            player:setCharVar("AnnyEvent2020_aery", 1)
            player:addItem(6404)
            player:PrintToPlayer("You hear the roar of a great wyrm off in the distance..", 0xD)
            player:messageSpecial((ID.text.ITEM_OBTAINED), 6404)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 6404)
        end
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
