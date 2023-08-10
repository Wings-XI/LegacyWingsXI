-----------------------------------
-- AMK Mission 10: Roar! A Cat Burglar Bears Her Fangs
-- Chamber of Oracles
-- TODO: can skip cs at the end if seen (as choice), but doesn't skip
-----------------------------------
require("scripts/globals/battlefield")
local ID = require("scripts/zones/Chamber_of_Oracles/IDs")
-----------------------------------

function onBattlefieldInitialise(battlefield)
end

function onBattlefieldTick(battlefield, tick)
    tpz.battlefield.onBattlefieldTick(battlefield, tick)
end

function onBattlefieldRegister(player, battlefield)
end

function onBattlefieldEnter(player, battlefield)
    if player:hasKeyItem(tpz.ki.NAVARATNA_TALISMAN) then
        player:delKeyItem(tpz.ki.NAVARATNA_TALISMAN)
        player:messageSpecial(ID.text.KEYITEM_LOST, tpz.ki.NAVARATNA_TALISMAN)
        player:setCharVar("AMK_BCNM", 1)
        player:setCharVar("[AMK]8_rescueMarkerSet", 0)
        player:setCharVar("[AMK]8_rescueProgress", 0)
        player:delKeyItem(tpz.ki.NAVARATNA_TALISMAN)
    else
        player:setCharVar("AMK_BCNM", 0)
    end
    if player:hasKeyItem(tpz.ki.NAVARATNA_TALISMAN) then
    end
end

function onBattlefieldLeave(player, battlefield, leavecode)
    if leavecode == tpz.battlefield.leaveCode.WON then
        local now = tonumber(os.date("%j"))
        local lastRedCoralKey = player:getCharVar("lastRedCoralKey")
        if
            player:getCharVar("AMK_BCNM") == 1 and
            not player:hasKeyItem(tpz.ki.RED_CORAL_KEY) and
            now ~= lastRedCoralKey
        then
            player:setCharVar("lastRedCoralKey", now)
            npcUtil.giveKeyItem(player, tpz.ki.RED_CORAL_KEY)
        end

        local name, clearTime, partySize = battlefield:getRecord()
        local arg8 = player:hasCompletedMission(AMK, tpz.mission.id.amk.ROAR_A_CAT_BURGLAR_BARES_HER_FANGS) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 168, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == tpz.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 32001 then
        if option == 0 then return end
        if player:getCurrentMission(AMK) == tpz.mission.id.amk.ROAR_A_CAT_BURGLAR_BARES_HER_FANGS then
            player:completeMission(AMK, tpz.mission.id.amk.ROAR_A_CAT_BURGLAR_BARES_HER_FANGS)
            player:addMission(AMK, tpz.mission.id.amk.RELIEF_A_TRIUMPHANT_RETURN)
        end
        player:setCharVar("[AMK]9_CatBurglarBattle_Won", 1)
        player:startEvent(6)
    end
end
