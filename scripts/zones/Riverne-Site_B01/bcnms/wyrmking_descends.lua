-----------------------------------
-- The Wyrmking Descends
-- Riverne Site B, Monarchs Orb
-- !pos -610 4 690 29
-----------------------------------
local ID = require("scripts/zones/Riverne-Site_B01/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------

function onBattlefieldTick(battlefield, tick)
    tpz.battlefield.onBattlefieldTick(battlefield, tick)
end

function onBattlefieldRegister(player, battlefield)
end

function onBattlefieldEnter(player, battlefield)
    player:delStatusEffect(tpz.effect.LEVEL_RESTRICTION) -- can't be capped at 50 for this fight !
    player:timer (1000 , function(player) player:setHP(player:getMaxHP()) player:setMP(player:getMaxMP()) end)
end

function onBattlefieldLeave(player, battlefield, leavecode)
    if leavecode == tpz.battlefield.leaveCode.WON then
        local name, clearTime, partySize = battlefield:getRecord()
        local arg8 = (not player:hasKeyItem(tpz.ki.WHISPER_OF_THE_WYRMKING)) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == tpz.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 32001 then
        player:addTitle(tpz.title.WYRM_ASTONISHER)
        if ENABLE_COP_ZONE_CAP == 1 then
            player:addStatusEffect(tpz.effect.LEVEL_RESTRICTION, 50, 0, 0)
        end
    elseif csid == 32002 then
        if ENABLE_COP_ZONE_CAP == 1 then
            player:addStatusEffect(tpz.effect.LEVEL_RESTRICTION, 50, 0, 0)
        end
    end
end
