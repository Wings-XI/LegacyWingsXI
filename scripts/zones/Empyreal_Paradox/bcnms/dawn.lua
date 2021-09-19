-----------------------------------
-- Area: Empyreal_Paradox
-- Name: Dawn
-- instance 1 Promathia !pos -520 -119 524
-- instance 2 Promathia !pos 521 -0.500 517
-- instance 3 Promathia !pos -519 120 -520
-----------------------------------
local ID = require("scripts/zones/Empyreal_Paradox/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/titles")
-----------------------------------

function onBattlefieldInitialise(battlefield)
    battlefield:setLocalVar("phaseChange", 1)
    local baseID = ID.mob.PROMATHIA_OFFSET + (battlefield:getArea() - 1) * 2
    local pos = GetMobByID(baseID):getSpawnPos()

    local prishe = battlefield:insertEntity(14166, true, true)
    prishe:setSpawn(pos.x - 6, pos.y, pos.z - 21.5, 192)
    prishe:spawn()

    local selhteus = battlefield:insertEntity(14167, true, true)
    selhteus:setSpawn(pos.x + 10, pos.y, pos.z - 17.5, 172)
    selhteus:spawn()

    local bfTick = battlefield:getLocalVar("bfTick")
end

function onBattlefieldTick(battlefield, tick)
    tpz.battlefield.onBattlefieldTick(battlefield, tick)


    if battlefield:getLocalVar("bfTick") == 3 then

        local playerCount = 0
        local counter = 0

        for _, player in ipairs(battlefield:getPlayers()) do
            playerCount = playerCount + 1
        end

        for _, player in ipairs(battlefield:getPlayers()) do

            if player:getHPP() == 0 then
                counter = counter + 1
            end
            if counter == playerCount then
                battlefield:lose()
            end
        end

        battlefield:setLocalVar("bfTick", 0)

    end

    battlefield:setLocalVar("bfTick", battlefield:getLocalVar("bfTick") + 1)
end

function onBattlefieldRegister(player, battlefield)
end

function onBattlefieldEnter(player, battlefield)
end

function onBattlefieldDestroy(battlefield)
end

function onBattlefieldLeave(player, battlefield, leavecode)
    if leavecode == tpz.battlefield.leaveCode.WON then
        local name, clearTime, partySize = battlefield:getRecord()
        player:startEvent(6)
    elseif leavecode == tpz.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 6 then
        player:setPos(539, 0, -593, 192)
        player:addTitle(tpz.title.AVERTER_OF_THE_APOCALYPSE)
        player:startEvent(3)
        if player:getCurrentMission(COP) == tpz.mission.id.cop.DAWN and player:getCharVar("PromathiaStatus") == 2 then
            player:addKeyItem(tpz.ki.TEAR_OF_ALTANA)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.TEAR_OF_ALTANA)
            player:setCharVar("Promathia_kill_day", tonumber(os.date("%j")))
            player:setCharVar("PromathiaStatus", 3)
        end
    end
end
