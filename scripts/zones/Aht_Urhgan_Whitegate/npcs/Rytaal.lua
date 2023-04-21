-----------------------------------
-- Area: Aht Urhgan Whitegate
-- NPC: Rytaal
-- Type: Standard NPC
-- !pos 112.002 -1.338 -45.038 50
-----------------------------------
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/assault")
-----------------------------------
local assaultOrders =
{
    [1] = {KI = tpz.ki.LEUJAOAM_ASSAULT_ORDERS, points = "LEUJAOAM_ASSAULT_POINT"},
    [2] = {KI = tpz.ki.MAMOOL_JA_ASSAULT_ORDERS, points = "MAMOOL_ASSAULT_POINT"},
    [3] = {KI = tpz.ki.LEBROS_ASSAULT_ORDERS, points = "LEBROS_ASSAULT_POINT"},
    [4] = {KI = tpz.ki.PERIQIA_ASSAULT_ORDERS, points = "PERIQIA_ASSAULT_POINT"},
    [5] = {KI = tpz.ki.ILRUSI_ASSAULT_ORDERS, points = "ILRUSI_ASSAULT_POINT"},
    [6] = {KI = tpz.ki.NYZUL_ISLE_ASSAULT_ORDERS, points = "NYZUL_ISLE_ASSAULT_POINT"},
}

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local currentAssault = player:getCurrentAssault()

    if player:getCurrentMission(TOAU) == tpz.mission.id.toau.PRESIDENT_SALAHEEM and player:getCharVar("AhtUrganStatus") == 0 then
        player:startEvent(269,0,0,0,0,0,0,0,0,0)
    elseif player:getCurrentMission(TOAU) <= tpz.mission.id.toau.IMMORTAL_SENTRIES or player:getMainLvl() <= 49 then
        player:startEvent(270)
    elseif currentAssault ~= 0 and player:getCharVar("assaultEntered") ~= 0 then
        if player:getCharVar("AssaultComplete") == 1 then
            if currentAssault == 51 then
                player:messageText(player, ID.text.RYTAAL_NYZUL_COMPLETE)
            else
                player:messageText(player, ID.text.RYTAAL_MISSION_COMPLETE)
            end
            player:completeAssault(currentAssault)
        elseif currentAssault == 51 then
            player:messageText(player, ID.text.RYTAAL_NYZUL_FAIL)
            player:delAssault(currentAssault)
        else
            local assaultPoint = assaultOrders[player:getCharVar("assaultEntered")].points
            player:addCurrency(assaultPoint, 100)
            player:messageText(player, ID.text.RYTAAL_MISSION_FAILED)
            player:delAssault(currentAssault)
        end
        player:setCharVar("AssaultComplete", 0)
        player:setCharVar("assaultEntered", 0)
        player:setCharVar("Assault_Armband", 0)
        for _, v in pairs(assaultOrders) do
            if player:hasKeyItem(v.KI) then
                player:delKeyItem(v.KI)
            end
        end
    elseif player:getCurrentMission(TOAU) > tpz.mission.id.toau.PRESIDENT_SALAHEEM or (player:getCurrentMission(TOAU) == tpz.mission.id.toau.PRESIDENT_SALAHEEM and player:getCharVar("AhtUrganStatus") >= 1) then
        local currentTime = os.time()
        local refreshTime = player:getCharVar("lastTagTime")
        local tagReUpSeconds = 86400 -- one tag every X seconds
        local tagDiffTime = math.floor((currentTime - refreshTime)/tagReUpSeconds)
        local tagStock = player:getCurrency("id_tags")
        local allTagsTimeCS = (refreshTime - 1009897200) + (tagDiffTime * tagReUpSeconds)
        local haveimperialIDtag = 0
        local tagsAvail = 0

        while currentTime >= refreshTime and tagStock < 7 do
            refreshTime = refreshTime + tagReUpSeconds
            tagStock = tagStock + 1
        end

        -- GMs need tags for testing
        if tagStock == 0 and player:getGMLevel() > 1 then
            tagStock = tagStock + 1
        end

        player:setCurrency("id_tags", tagStock)
        player:setCharVar("lastTagTime", refreshTime)

        if player:hasKeyItem(tpz.ki.IMPERIAL_ARMY_ID_TAG) then
            haveimperialIDtag = 1
        end

        if tagStock > 0 then
            tagsAvail = 1
        end

        player:startEvent(268,2,tagStock,currentAssault,haveimperialIDtag,allTagsTimeCS,tagsAvail)
    else
        -- Something went worng, clear all data
        player:setCharVar("AssaultComplete", 0)
        player:setCharVar("assaultEntered", 0)
        player:setCharVar("Assault_Armband", 0)
        player:delAssault(currentAssault)
        for _, v in pairs(assaultOrders) do
            if player:hasKeyItem(v.KI) then
                player:delKeyItem(v.KI)
            end
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    local tagStock = player:getCurrency("id_tags")

    if csid == 269 then
        player:setCharVar("AhtUrganStatus",1)
    elseif csid == 268 and option == 1 and not player:hasKeyItem(tpz.ki.IMPERIAL_ARMY_ID_TAG) and tagStock > 0 then
        if player:getCurrentAssault() ~= 0 then
            player:messageSpecial(ID.text.CANNOT_ISSUE_TAG, tpz.ki.IMPERIAL_ARMY_ID_TAG)
            return
        end
        npcUtil.giveKeyItem(player, tpz.ki.IMPERIAL_ARMY_ID_TAG)

        if tagStock >= 7 then
            player:setCharVar("lastTagTime", os.time() + 86400)
        end
        player:setCurrency("id_tags", tagStock - 1)
    elseif csid == 268 and option == 2 then
        -- normal case
        if ((hasOrders(player) and not player:hasKeyItem(tpz.ki.IMPERIAL_ARMY_ID_TAG)) 
            -- handles the speficic case where a player crashes entering an assault and is left in an intermediate state
            -- while we should work on resolving assault entry issues this temp case will allow players a self service option to at least get their tag back
            or (not hasOrders(player) and not player:hasKeyItem(tpz.ki.IMPERIAL_ARMY_ID_TAG) and player:getCurrentAssault() ~= 0 and player:getCharVar("assaultEntered") == 0)) then 
            local currentAssault = player:getCurrentAssault()
            for _, v in pairs(assaultOrders) do
                if player:hasKeyItem(v.KI) then
                    player:delKeyItem(v.KI)
                end
            end
            npcUtil.giveKeyItem(player, tpz.ki.IMPERIAL_ARMY_ID_TAG)
            player:delAssault(currentAssault)
        end
    end
end