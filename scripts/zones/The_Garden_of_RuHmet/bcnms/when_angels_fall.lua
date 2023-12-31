-----------------------------------
-- Area: The_Garden_of_RuHmet
-- Name: When Angels Fall
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/missions")
-----------------------------------

function onBattlefieldTick(battlefield, tick)
    tpz.battlefield.onBattlefieldTick(battlefield, tick)
end

function onBattlefieldRegister(player, battlefield)
end

function onBattlefieldEnter(player, battlefield)
end

function onBattlefieldLeave(player, battlefield, leavecode)
    if leavecode == tpz.battlefield.leaveCode.WON then
        local name, clearTime, partySize = battlefield:getRecord()
        local arg8 = (player:getCurrentMission(COP) ~= tpz.mission.id.cop.WHEN_ANGELS_FALL or player:getCharVar("PromathiaStatus") ~= 4) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 0, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == tpz.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid== 32001 then
        local realday = tonumber(os.date("%j")) -- %M for next minute, %j for next day
        if player:getCurrentMission(COP) == tpz.mission.id.cop.WHEN_ANGELS_FALL and player:getCharVar("PromathiaStatus") == 4 then
            player:setCharVar("PromathiaStatus", 5)
        end
        if realday ~= player:getCharVar("WhenAngelsFall_date") then
            player:addExp(1000)
            player:setCharVar("WhenAngelsFall_date", realDay)
        end
        player:setPos(420, 0, 445, 192)
    end
end
