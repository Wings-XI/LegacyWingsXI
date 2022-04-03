-----------------------------------
-- Area: Full Moon Fountain
-- Name: ASA10 Battaru Royale
-----------------------------------
local ID = require("scripts/zones/Full_moon_Fountain/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------

function onBattlefieldTick(battlefield, tick)
    tpz.battlefield.onBattlefieldTick(battlefield, tick)
end

function onBattlefieldRegister(player, battlefield)
    local sapsCollected =
    (player:hasKeyItem(tpz.ki.WATER_SAP_CRYSTAL)     and 1 or 0) +
    (player:hasKeyItem(tpz.ki.EARTH_SAP_CRYSTAL)     and 1 or 0) +
    (player:hasKeyItem(tpz.ki.ICE_SAP_CRYSTAL)       and 1 or 0) +
    (player:hasKeyItem(tpz.ki.WIND_SAP_CRYSTAL)      and 1 or 0) +
    (player:hasKeyItem(tpz.ki.LIGHTNING_SAP_CRYSTAL) and 1 or 0) +
    (player:hasKeyItem(tpz.ki.FIRE_SAP_CRYSTAL)      and 1 or 0) +
    (player:hasKeyItem(tpz.ki.LIGHT_SAP_CRYSTAL)     and 1 or 0) +
    (player:hasKeyItem(tpz.ki.DARK_SAP_CRYSTAL)      and 1 or 0)

    if sapsCollected > 0 then
        player:setCharVar("ASA_BCNM", 1)
    end
end

function onBattlefieldEnter(player, battlefield)
    local bfID = battlefield:getArea()
    if player:hasKeyItem(tpz.ki.WATER_SAP_CRYSTAL) then
        GetMobByID(ID.battaru_royale.CLONE_OF_TORRENTS[bfID]):setLocalVar("Immunity", 1)
        player:delKeyItem(tpz.ki.WATER_SAP_CRYSTAL)
    end
    if player:hasKeyItem(tpz.ki.EARTH_SAP_CRYSTAL) then
        GetMobByID(ID.battaru_royale.CLONE_OF_BOULDERS[bfID]):setLocalVar("Immunity", 1)
        player:delKeyItem(tpz.ki.EARTH_SAP_CRYSTAL)
    end
    if player:hasKeyItem(tpz.ki.ICE_SAP_CRYSTAL) then
        GetMobByID(ID.battaru_royale.CLONE_OF_GLACIERS[bfID]):setLocalVar("Immunity", 1)
        player:delKeyItem(tpz.ki.ICE_SAP_CRYSTAL)
    end
    if player:hasKeyItem(tpz.ki.WIND_SAP_CRYSTAL) then
        GetMobByID(ID.battaru_royale.CLONE_OF_GUSTS[bfID]):setLocalVar("Immunity", 1)
        player:delKeyItem(tpz.ki.WIND_SAP_CRYSTAL)
    end
    if player:hasKeyItem(tpz.ki.LIGHTNING_SAP_CRYSTAL) then
        GetMobByID(ID.battaru_royale.CLONE_OF_SPARKS[bfID]):setLocalVar("Immunity", 1)
        player:delKeyItem(tpz.ki.LIGHTNING_SAP_CRYSTAL)
    end
    if player:hasKeyItem(tpz.ki.FIRE_SAP_CRYSTAL) then
        GetMobByID(ID.battaru_royale.CLONE_OF_FLAMES[bfID]):setLocalVar("Immunity", 1)
        player:delKeyItem(tpz.ki.FIRE_SAP_CRYSTAL)
    end
    if player:hasKeyItem(tpz.ki.LIGHT_SAP_CRYSTAL) then
        GetMobByID(ID.battaru_royale.CLONE_OF_LIGHTS[bfID]):setLocalVar("Immunity", 1)
        player:delKeyItem(tpz.ki.LIGHT_SAP_CRYSTAL)
    end
    if player:hasKeyItem(tpz.ki.DARK_SAP_CRYSTAL) then
        GetMobByID(ID.battaru_royale.CLONE_OF_SHADOWS[bfID]):setLocalVar("Immunity", 1)
        player:delKeyItem(tpz.ki.DARK_SAP_CRYSTAL)
    end
end

function onBattlefieldLeave(player, battlefield, leavecode)
    if leavecode == tpz.battlefield.leaveCode.WON then -- play end CS. Need time and battle id for record keeping + storage
        local now = tonumber(os.date("%j"))
        local lastChocobo = player:getCharVar("LastChocoboKey")

        player:addExp(700)

        if player:getCharVar("ASA_BCNM") == 1 then
            player:setCharVar("ASA_BCNM", 0)
            if not player:hasKeyItem(tpz.ki.CHOCOBO_KEY) and now ~= lastChocobo and player:getCurrentMission(ASA) >= tpz.mission.id.asa.BATTARU_ROYALE then
                player:setCharVar("LastChocoboKey", os.date("%j"))
                player:addKeyItem(tpz.ki.CHOCOBO_KEY)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.CHOCOBO_KEY)
            end
        end

        local name, clearTime, partySize = battlefield:getRecord()
        local arg8 = player:hasCompletedMission(ASA, tpz.mission.id.asa.BATTARU_ROYALE) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == tpz.battlefield.leaveCode.LOST then
        player:setCharVar("ASA_BCNM", 0)
        player:startEvent(32002)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 32001 then
        -- Play last CS if not skipped.
        if option ~= 0 then
            player:startEvent(64)
        end
    elseif csid == 64 then
        if player:getCurrentMission(ASA) == tpz.mission.id.asa.BATTARU_ROYALE then
            player:completeMission(ASA, tpz.mission.id.asa.BATTARU_ROYALE)
            player:addMission(ASA, tpz.mission.id.asa.ROMANCING_THE_CLONE)
        end
    end
end