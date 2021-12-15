-----------------------------------
-- Those Who Lurk in Shadows (III)
-- Qu'Bia Arena mission battlefield
-----------------------------------
local ID = require("scripts/zones/QuBia_Arena/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------

function onBattlefieldTick(battlefield, tick)
    tpz.battlefield.onBattlefieldTick(battlefield, tick)
end

function onBattlefieldRegister(player, battlefield)
    if player:hasKeyItem(tpz.ki.MARK_OF_SEED) then
        player:setCharVar("ACP_BCNM", 1)
        player:delKeyItem(tpz.ki.MARK_OF_SEED)
    else
        player:setCharVar("ACP_BCNM", 0)
    end
end

function onBattlefieldEnter(player, battlefield)
end

function onBattlefieldLeave(player, battlefield, leavecode)
    if leavecode == tpz.battlefield.leaveCode.WON then
        local now = tonumber(os.date("%j"))
        local lastIvory = player:getCharVar("LastIvoryKey")

        player:addExp(700)
        if player:getCharVar("ACP_BCNM") == 1 then
            player:setCharVar("ACP_BCNM", 0)
            if player:getCurrentMission(ACP) == tpz.mission.id.acp.THOSE_WHO_LURK_IN_SHADOWS_III then
                player:completeMission(ACP, tpz.mission.id.acp.THOSE_WHO_LURK_IN_SHADOWS_III)
                player:addMission(ACP, tpz.mission.id.acp.REMEMBER_ME_IN_YOUR_DREAMS)
            end
            if not player:hasKeyItem(tpz.ki.IVORY_KEY) and now ~= lastIvory and player:getCurrentMission(ACP) >= tpz.mission.id.acp.THOSE_WHO_LURK_IN_SHADOWS_III then
                player:setCharVar("LastIvoryKey", os.date("%j"))
                player:addKeyItem(tpz.ki.IVORY_KEY)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.IVORY_KEY)
            end
        end
        local name, clearTime, partySize = battlefield:getRecord()
        local arg8 = player:hasCompletedMission(ACP, tpz.mission.id.acp.REMEMBER_ME_IN_YOUR_DREAMS) and 1 or 0 -- check the next mission
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == tpz.battlefield.leaveCode.LOST then
        player:setCharVar("ACP_BCNM", 0)
        player:startEvent(32002)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

end