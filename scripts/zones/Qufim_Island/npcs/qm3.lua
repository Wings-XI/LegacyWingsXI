-----------------------------------
-- Area: Qufim Island
--  NPC: ??? (qm3)
-- Mission: ACP - The Echo Awakens
-- !pos -120.342 -19.471 306.661 126
-----------------------------------
local ID = require("scripts/zones/Qufim_Island/IDs")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
    -- Trade Seedspall's Lux, Luna, Astrum
    if player:getCurrentMission(ACP) == tpz.mission.id.acp.THE_ECHO_AWAKENS and npcUtil.tradeHas(trade, {2740, 2741, 2742}) then
        player:startEvent(31)
    end
end

function onTrigger(player, npc)
    local missionACP = player:getCurrentMission(ACP)
    local now = tonumber(os.date("%j"))
    local SR = player:hasKeyItem(tpz.ki.SEEDSPALL_ROSEUM)
    local SC = player:hasKeyItem(tpz.ki.SEEDSPALL_CAERULUM)
    local SV = player:hasKeyItem(tpz.ki.SEEDSPALL_VIRIDIS)
    local amberKey = player:hasKeyItem(tpz.ki.AMBER_KEY)
    local lastAmber = player:getCharVar("LastAmberKey") -- When last Amber key was obtained
    local lastViridian = player:getCharVar("LastViridianKey") -- When last Viridian key was obtained
printf("A")
    if missionACP == tpz.mission.id.acp.GATHERER_OF_LIGHT_I and SR and SC and SV and now ~= lastViridian then
        player:startEvent(32)
        player:setCharVar("SEED_MANDY", 99)
    elseif missionACP >= tpz.mission.id.acp.GATHERER_OF_LIGHT_II and SR and SC and SV and now ~= lastViridian and now ~= lastAmber and not amberKey and (player:getCharVar("SEED_MANDY") == 99 or player:getCharVar("SEED_MANDY") < 30) and not player:hasStatusEffect(tpz.effect.CONFRONTATION) then
        -- Make sure nobody else is doing this confrontation
        local mandragoraSpawned = false
        for i, id in ipairs(ID.mob.SEED_MANDRAGORA) do
            local mandragora = GetMobByID(id)
            if mandragora:isSpawned() then    
                mandragoraSpawned = true
            end
        end

        if mandragoraSpawned then
            --Error
            player:messageSpecial(ID.text.NOTHER_OUT_OF_THE_ORDINARY)
        else
            -- player:startEvent(43)
            for _, partyMember in pairs(player:getAlliance()) do
                partyMember:setCharVar("SEED_MANDY", 0)
                partyMember:addStatusEffect(tpz.effect.CONFRONTATION, 10, 0, 1800)
                partyMember:delKeyItem(tpz.ki.SEEDSPALL_ROSEUM)
                partyMember:delKeyItem(tpz.ki.SEEDSPALL_CAERULUM)
                partyMember:delKeyItem(tpz.ki.SEEDSPALL_VIRIDIS)
            end

            for i, id in ipairs(ID.mob.SEED_MANDRAGORA) do
                local mandragora = GetMobByID(id)
                if not mandragora:isSpawned() then    
                    mandragora:spawn()
                    mandragora:updateEnmity(player)
                end
            end
        end
    elseif missionACP == tpz.mission.id.acp.GATHERER_OF_LIGHT_II and player:getCharVar("SEED_MANDY") >= 30 then
        player:setCharVar("SEED_MANDY", 99)
        player:startEvent(34)
    else
        player:messageSpecial(ID.text.NOTHER_OUT_OF_THE_ORDINARY)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 31 then
        player:completeMission(ACP, tpz.mission.id.acp.THE_ECHO_AWAKENS)
        player:addMission(ACP, tpz.mission.id.acp.GATHERER_OF_LIGHT_I)
        player:confirmTrade()
    elseif csid == 32 then
        player:completeMission(ACP, tpz.mission.id.acp.GATHERER_OF_LIGHT_I)
        player:addMission(ACP, tpz.mission.id.acp.GATHERER_OF_LIGHT_II)
    elseif csid == 34 then
        player:completeMission(ACP, tpz.mission.id.acp.GATHERER_OF_LIGHT_II)
        player:addMission(ACP, tpz.mission.id.acp.THOSE_WHO_LURK_IN_SHADOWS_I)
    end
end
