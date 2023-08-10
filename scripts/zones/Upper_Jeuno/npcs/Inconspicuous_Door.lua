-----------------------------------
-- Area: Upper Jeuno (244)
--  NPC: Inconspicuous Door
-- A Moogle Kupo d'Etat Mission NPC
-- !pos: -15 1.300 68
-- ID: 17776877
-----------------------------------
local ID = require("scripts/zones/Upper_Jeuno/IDs")
require("scripts/globals/missions")
require("scripts/globals/keyitems")
require("scripts/globals/events/amkhelpers")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local currentMission_AMK = player:getCurrentMission(AMK)
    local MMDProgress = player:getCharVar("[AMK]3_MMDProgress")
    local diggingZone = amkHelpers.getDiggingZone(player)
    local amkDiggingEvents = {
        [tpz.zone.VALKURM_DUNES] = 1,
        [tpz.zone.JUGNER_FOREST] = 2,
        [tpz.zone.KONSCHTAT_HIGHLANDS] = 3,
        [tpz.zone.PASHHOW_MARSHLANDS] = 4,
        [tpz.zone.TAHRONGI_CANYON] = 5,
        [tpz.zone.BUBURIMU_PENINSULA] = 6,
        [tpz.zone.MERIPHATAUD_MOUNTAINS] = 7,
        [tpz.zone.THE_SANCTUARY_OF_ZITAH] = 8,
        [tpz.zone.YUHTUNGA_JUNGLE] = 9,
        [tpz.zone.YHOATOR_JUNGLE] = 10,
        [tpz.zone.WESTERN_ALTEPA_DESERT] = 11,
        [tpz.zone.EASTERN_ALTEPA_DESERT] = 12,
    }
    local hasMetalStrip = player:hasKeyItem(tpz.ki.STURDY_METAL_STRIP)
    local hasTreeBark = player:hasKeyItem(tpz.ki.PIECE_OF_RUGGED_TREE_BARK)
    local hasLambRoast = player:hasKeyItem(tpz.ki.SAVORY_LAMB_ROAST)

    if currentMission_AMK == tpz.mission.id.amk.HASTEN_IN_A_JAM_IN_JEUNO then
        player:startEvent(10178)
    elseif currentMission_AMK == tpz.mission.id.amk.WELCOME_TO_MY_DECREPIT_DOMICILE then
        if MMDProgress == 1 then
            if hasMetalStrip then
                player:startEvent(10179) -- Metal Strip handed in
            else
                player:startEvent(10186) -- Metal Strip reminder
            end
        elseif MMDProgress == 2 then
            if hasTreeBark then
                player:startEvent(10180) -- Tree Bark handed in
            else
                player:startEvent(10187) -- Tree Bark reminder
            end
        elseif MMDProgress == 3 then
            if hasLambRoast then
                player:startEvent(10181) -- Lamb Roast handed in
            else
                player:startEvent(10188) -- Lamb Roast reminder
            end
        end
    elseif
        currentMission_AMK == tpz.mission.id.amk.AN_ERRAND_THE_PROFESSORS_PRICE and
        player:getCharVar("[AMK]5_errandProgress") == 1
    then
        player:setCharVar("[AMK]5_errandProgress", 0)
        player:startEvent(10182, amkDiggingEvents[diggingZone])
    elseif currentMission_AMK == tpz.mission.id.amk.SHOCK_ARRANT_ABUSE_OF_AUTHORITY then
        if player:hasKeyItem(tpz.ki.MOLDY_WORMEATEN_CHEST) then
            player:startEvent(10183)
        else
            player:startEvent(10189, amkDiggingEvents[diggingZone]) -- Digging location reminder
        end
    elseif
        currentMission_AMK == tpz.mission.id.amk.LENDER_BEWARE_READ_THE_FINE_PRINT and
        player:getCharVar("[AMK]7_LenderProgress") == 2
    then
        player:startEvent(10184)
    elseif
        currentMission_AMK == tpz.mission.id.amk.RELIEF_A_TRIUMPHANT_RETURN
    then
        player:startEvent(10185)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 10178 then
        player:setCharVar("[AMK]3_MMDProgress", 1)
        player:completeMission(AMK, tpz.mission.id.amk.HASTEN_IN_A_JAM_IN_JEUNO)
        player:addMission(AMK, tpz.mission.id.amk.WELCOME_TO_MY_DECREPIT_DOMICILE)
    elseif csid == 10179 then
        player:setCharVar("[AMK]3_MMDProgress", 2)
        player:delKeyItem(tpz.ki.STURDY_METAL_STRIP)
    elseif csid == 10180 then
        player:setCharVar("[AMK]3_MMDProgress", 3)
        player:delKeyItem(tpz.ki.PIECE_OF_RUGGED_TREE_BARK)
    elseif csid == 10181 then
        player:setCharVar("[AMK]3_MMDProgress", 0)
        player:delKeyItem(tpz.ki.SAVORY_LAMB_ROAST)
        npcUtil.giveKeyItem(player, tpz.ki.BLUE_CORAL_KEY)
        player:completeMission(AMK, tpz.mission.id.amk.WELCOME_TO_MY_DECREPIT_DOMICILE)
        player:addMission(AMK, tpz.mission.id.amk.CURSES_A_HORRIFICALLY_HARROWING_HEX)
    elseif csid == 10182 then
        player:completeMission(AMK, tpz.mission.id.amk.AN_ERRAND_THE_PROFESSORS_PRICE)
        player:addMission(AMK, tpz.mission.id.amk.SHOCK_ARRANT_ABUSE_OF_AUTHORITY)
    elseif csid == 10183 then
        player:delKeyItem(tpz.ki.MOLDY_WORMEATEN_CHEST)
        player:messageSpecial(ID.text.KEYITEM_LOST, tpz.ki.MOLDY_WORMEATEN_CHEST)
        npcUtil.giveKeyItem(end_member, tpz.ki.BLACK_CORAL_KEY)
        player:completeMission(AMK, tpz.mission.id.amk.SHOCK_ARRANT_ABUSE_OF_AUTHORITY)
        player:addMission(AMK, tpz.mission.id.amk.LENDER_BEWARE_READ_THE_FINE_PRINT)
    elseif csid == 10184 then
        player:setCharVar("[AMK]7_LenderProgress", 0)
        player:completeMission(AMK, tpz.mission.id.amk.LENDER_BEWARE_READ_THE_FINE_PRINT)
        player:addMission(AMK, tpz.mission.id.amk.RESCUE_A_MOOGLES_LABOR_OF_LOVE)
    elseif csid == 10185 then
        player:setCharVar("[AMK]9_CatBurglarBattle_Won", 0)
        player:completeMission(AMK, tpz.mission.id.amk.RELIEF_A_TRIUMPHANT_RETURN)
        player:addMission(AMK, tpz.mission.id.amk.JOY_SUMMONED_TO_A_FABULOUS_FETE)
    end
end
