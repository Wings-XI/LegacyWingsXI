-----------------------------------
-- Purple the New Black
-- Wings of the Goddess Mission BCNM
-----------------------------------
require("scripts/globals/battlefield")
-----------------------------------

function onBattlefieldInitialise(battlefield)
end

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
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), 0)
    elseif leavecode == tpz.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 32001 then
        if player:getCharVar("PurpleTheNewBlackProgress") == 1 then
            player:setCharVar("PurpleTheNewBlackProgress", 2)
        end
        player:setPos(-260, 0, -156, 192, 85)
    end
end
