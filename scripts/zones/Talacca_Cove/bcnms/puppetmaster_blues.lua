-----------------------------------
-- Area: Talacca Cove
-- BCNM: Puppetmaster Blues
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
----------------------------------------

function onBattlefieldTick(battlefield, tick)
    tpz.battlefield.onBattlefieldTick(battlefield, tick)
end

function onBattlefieldRegister(player, battlefield)
end

function onBattlefieldEnter(player, battlefield)
end

function onBattlefieldLeave(player, battlefield, leavecode)
    if leavecode == tpz.battlefield.leaveCode.WON then -- play end CS. Need time and battle id for record keeping + storage
        local name, clearTime, partySize = battlefield:getRecord()
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), 0)
    elseif leavecode == tpz.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    local PuppetmasterBluesProgress = player:getCharVar("PuppetmasterBluesProgress")
    if csid == 32001 and PuppetmasterBluesProgress == 2 then
        player:setCharVar("PuppetmasterBluesProgress", 3)
        player:delKeyItem(tpz.ki.TOGGLE_SWITCH) -- BCNM entry trigger
        player:delKeyItem(tpz.ki.VALKENGS_MEMORY_CHIP) -- Dont need this anymore
    end
end
