-----------------------------------
-- Area: Throne Room
-- Name: AMK Mission 14 - Smash! A Malevolent Menace
-- !pos -111 -6 0.1 165
-----------------------------------
local ID = require("scripts/zones/Throne_Room/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------

function onBattlefieldTick(battlefield, tick)
    tpz.battlefield.onBattlefieldTick(battlefield, tick)
end

function onBattlefieldInitialise(battlefield)
end

function onBattlefieldRegister(player, battlefield)
end

function onBattlefieldEnter(player, battlefield)
    if player:hasKeyItem(tpz.ki.MEGA_BONANZA_KUPON) then
        player:setCharVar("AMK_BCNM", 1)
        player:delKeyItem(tpz.ki.MEGA_BONANZA_KUPON)
        player:messageSpecial(ID.text.KEYITEM_LOST, tpz.ki.MEGA_BONANZA_KUPON)
    else
        player:setCharVar("AMK_BCNM", 0)
    end
end

function onBattlefieldLeave(player, battlefield, leavecode)
    if leavecode == tpz.battlefield.leaveCode.WON then
        local now = tonumber(os.date("%j"))
        local lastKey = player:getCharVar("LastAngelSkinKey")

        player:addExp(750)

        if player:getCharVar("AMK_BCNM") == 1 then
            player:setCharVar("AMK_BCNM", 0)
            if player:getCurrentMission(AMK) >= tpz.mission.id.amk.SMASH_A_MALEVOLENT_MENACE then
                if not player:hasKeyItem(tpz.ki.ANGEL_SKIN_KEY) and now ~= lastKey then
                    player:setCharVar("LastAngelSkinKey", os.date("%j"))
                    npcUtil.giveKeyItem(player,tpz.ki.ANGEL_SKIN_KEY)
                end

                local hasArmor = false
                for i = 11487, 11489 do
                    if player:hasItem(i) then
                        hasArmor = true
                    end
                end

                if not hasArmor then
                    npcUtil.giveKeyItem(player, tpz.ki.OXBLOOD_KEY)
                end
            end
        end

        local name, clearTime, partySize = battlefield:getRecord()
        local arg8 = player:hasCompletedMission(AMK, tpz.mission.id.amk.SMASH_A_MALEVOLENT_MENACE) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == tpz.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 32001 then
        -- Play final CS if not skipped.
        if option ~= 0 then
            player:startEvent(5)
        end
    elseif csid == 5 then
        if player:getCurrentMission(AMK) == tpz.mission.id.amk.SMASH_A_MALEVOLENT_MENACE then
            player:completeMission(AMK, tpz.mission.id.amk.SMASH_A_MALEVOLENT_MENACE)
            player:addMission(AMK, tpz.mission.id.amk.A_MOOGLE_KUPO_DETAT_FIN)
        end
    end
end