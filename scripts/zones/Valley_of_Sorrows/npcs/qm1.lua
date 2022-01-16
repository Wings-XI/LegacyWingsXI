-----------------------------------
-- Area: Valley of Sorrows
--  NPC: qm1 (???)
-- Spawns Adamantoise or Aspidochelone
-- !pos 1.128 0 -37.856
-----------------------------------
local ID = require("scripts/zones/Valley_of_Sorrows/IDs")
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
    if not GetMobByID(ID.mob.ADAMANTOISE):isSpawned() and not GetMobByID(ID.mob.ASPIDOCHELONE):isSpawned() then
        if LandKingSystem_NQ ~= 0 and npcUtil.tradeHas(trade, 3343) and npcUtil.popFromQM(player, npc, ID.mob.ADAMANTOISE, {claim=true, hide=300, look=true, radius=1}) then
            player:confirmTrade()
        elseif LandKingSystem_HQ ~= 0 and npcUtil.tradeHas(trade, 3344) and npcUtil.popFromQM(player, npc, ID.mob.ASPIDOCHELONE, {claim=true, hide=300, look=true, radius=1}) then
            player:confirmTrade()
        end
    end
end

function onTrigger(player, npc)
    if player:getCharVar("AnnyEvent2020") == 11 and player:getCharVar("AnnyEvent2020_addy") == 0 and Anniversary_Event_2021 == 1 then
        if player:getFreeSlotsCount() > 0 then
            player:setCharVar("AnnyEvent2020_addy", 1)
            player:addItem(6403)
            player:PrintToPlayer("You feel the ground shake as a great creature stomps off in the distance...", 0xD)
            player:messageSpecial((ID.text.ITEM_OBTAINED), 6403)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 6403)
        end
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
