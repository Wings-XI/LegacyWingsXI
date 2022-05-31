-----------------------------------
-- Copycat
-- Waughroon Shrine KSNM30, Clotho Orb
-- !additem 1175
-----------------------------------
require("scripts/globals/battlefield")
-----------------------------------

function onBattlefieldInitialise(battlefield)
    -- cache party setup upon entry to avoid alteration of the charm cycle
    local player = battlefield:getPlayers()[1]

    -- set default target in case there are no party
    battlefield:setLocalVar("charmTarget_1", player:getID())

    -- cycle is always based off party leader's party
    local leader = player:getPartyLeader()
    if (leader ~= nil) then
        local party = leader:getParty()
        if (party ~= nil) then
            for i, member in ipairs(party) do
                battlefield:setLocalVar("charmTarget_" .. i, member:getID())
            end
        end
    end

    battlefield:setLocalVar("loot", 1)
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
end