-----------------------------------
-- Area: Lower Delkfutt's Tower
-- NPC: Seed Fragment
-- Notes: Level Restricts player to 30 for A Crystaline Prophecy (ACP10)
-- !pos 456 0 -69 184
-----------------------------------
local ID = require("scripts/zones/Lower_Delkfutts_Tower/IDs")
require("scripts/globals/missions")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/bcnm")
-----------------------------------

function onSpawn(npc)
    if ENABLE_ACP == 0 then
        npc:setStatus(tpz.status.DISAPPEAR)
    end
end

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.STONE_GLITTERS)
    
    if player:getCurrentMission(ACP) >= tpz.mission.id.acp.BANISHING_THE_ECHO then
        if player:hasStatusEffect(tpz.effect.LEVEL_SYNC) then
            local sync_error = BCNMGetLevelSyncError(player)
            if sync_error ~= nil then
                player:messageSpecial(sync_error, 0, 0)
            end
            return
        end
        player:messageSpecial(ID.text.CRYSTAL_PULSATES)
        if player:hasStatusEffect(tpz.effect.LEVEL_RESTRICTION) then
            player:messageSpecial(ID.text.CRYSTAL_BECKONS)
            player:startEvent(33, 100)
        else
            player:messageSpecial(ID.text.CRYSTAL_VACUUM)
            player:startEvent(33, 200)
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option, npc)
    if csid == 33 then
        if option == 100 then
            player:delStatusEffect(tpz.effect.LEVEL_RESTRICTION)
            player:messageSpecial(ID.text.LIGHT_DISSIPATE)
        elseif option == 200 then
            player:addStatusEffect(tpz.effect.LEVEL_RESTRICTION, 30, 0, 0)
            player:messageSpecial(ID.text.LIGHT_ENVELOP)
        end
    end
end
