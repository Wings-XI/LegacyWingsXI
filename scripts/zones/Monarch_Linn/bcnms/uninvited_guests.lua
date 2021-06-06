-----------------------------------
-- Area: Monarch Linn
-- Name: Uninvited Guests
-----------------------------------
local ID = require("scripts/zones/Monarch_Linn/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
-----------------------------------

function onBattlefieldTick(battlefield, tick)
    tpz.battlefield.onBattlefieldTick(battlefield, tick)
end

function onBattlefieldInitialise(battlefield)

end

function onBattlefieldRegister(player, battlefield)

end

function onBattlefieldEnter(player, battlefield)
    player:messageSpecial(ID.text.KI_TORN_FROM_YOUR_HANDS, tpz.ki.MONARCH_LINN_PATROL_PERMIT)
    player:delKeyItem(tpz.ki.MONARCH_LINN_PATROL_PERMIT)
end

function onBattlefieldLeave(player, battlefield, leavecode)
     if leavecode == tpz.battlefield.leaveCode.WON then -- play end CS. Need time and battle id for record keeping + storage
        local name, clearTime, partySize = battlefield:getRecord()
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), 0)
    elseif leavecode == tpz.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    elseif leavecode == tpz.battlefield.leaveCode.EXIT or leavecode == tpz.battlefield.leaveCode.WARPDC then
        -- However the player got out of the BCNM - they didnt win
        if player:getCharVar("UninvitedGuestsStatus") == 1 then
            player:setCharVar("UninvitedGuestsStatus", 3) -- update to failure state
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 32001 then
        -- Victory
        if player:getCharVar("UninvitedGuestsStatus") == 1 then
            player:setCharVar("UninvitedGuestsStatus", 2) -- update to victory state
        end
    elseif csid == 32002 then
        -- Failure
        if player:getCharVar("UninvitedGuestsStatus") == 1 then
            player:setCharVar("UninvitedGuestsStatus", 3) -- update to failure state
        end
    end
end
