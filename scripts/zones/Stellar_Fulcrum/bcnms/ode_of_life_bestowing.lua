-----------------------------------
-- Area: Stellar Fulcrum
-- Name: ACP11 Ode of Life Bestowing
-- !pos -520 -4 17 179
-----------------------------------
local ID = require("scripts/zones/Stellar_Fulcrum/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------

function onBattlefieldTick(battlefield, tick)
    tpz.battlefield.onBattlefieldTick(battlefield, tick)
end

function onBattlefieldRegister(player, battlefield)
    if player:hasKeyItem(tpz.ki.OMNIS_STONE) then
        player:setCharVar("ACP_BCNM", 1)
        player:delKeyItem(tpz.ki.OMNIS_STONE)
    else
        player:setCharVar("ACP_BCNM", 0)
    end
end

function onBattlefieldEnter(player, battlefield)
end

function onBattlefieldLeave(player, battlefield, leavecode)
    if leavecode == tpz.battlefield.leaveCode.WON then -- play end CS. Need time and battle id for record keeping + storage
        local now = tonumber(os.date("%j"))
        local lastEbon = player:getCharVar("LastEbonKey")

        player:addExp(750)

        if player:getCharVar("ACP_BCNM") == 1 then
            player:setCharVar("ACP_BCNM", 0)
            if player:getCurrentMission(ACP) >= tpz.mission.id.acp.ODE_OF_LIFE_BESTOWING then
                if not player:hasKeyItem(tpz.ki.EBON_KEY) and now ~= lastEbon then
                    player:setCharVar("LastEbonKey", os.date("%j"))
                    player:addKeyItem(tpz.ki.EBON_KEY)
                    player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.EBON_KEY)
                end


                -- WINGSCUSTOM allow multiple scenario rewards to be obtained
                if not player:hasKeyItem(tpz.ki.PRISMATIC_KEY) then
                    player:addKeyItem(tpz.ki.PRISMATIC_KEY)
                    player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.PRISMATIC_KEY)
                end
            end
        end

        local name, clearTime, partySize = battlefield:getRecord()
        local arg8 = player:hasCompletedMission(ACP, tpz.mission.id.acp.ODE_OF_LIFE_BESTOWING) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == tpz.battlefield.leaveCode.LOST then
        player:setCharVar("ACP_BCNM", 0)
        player:startEvent(32002)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 32001 then
        -- Play last CS if not skipped.
        if option ~= 0 then
            player:startEvent(13)
        end
    elseif csid == 13 then
        if player:getCurrentMission(ACP) == tpz.mission.id.acp.ODE_OF_LIFE_BESTOWING then
            player:completeMission(ACP, tpz.mission.id.acp.ODE_OF_LIFE_BESTOWING)
            player:addMission(ACP, tpz.mission.id.acp.A_CRYSTALLINE_PROPHECY_FIN)
            player:startEvent(14)
        end
    end
end