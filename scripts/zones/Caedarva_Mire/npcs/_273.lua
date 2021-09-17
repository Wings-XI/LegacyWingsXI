-----------------------------------
-- Area: Caedarva Mire
-- Door: Runic Seal (Periqia)
-- !pos -353 -3 -20 79
-----------------------------------
local ID = require("scripts/zones/Caedarva_Mire/IDs")
require("scripts/globals/assault")
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:hasKeyItem(tpz.ki.PERIQIA_ASSAULT_AREA_ENTRY_PERMIT) then
        player:setCharVar("ShadesOfVengeance", 1)
        player:startEvent(143, 79, -6, 0, 99, 3, 0)
    else
        onAssaultTrigger(player, npc, 143, tpz.ki.PERIQIA_ASSAULT_ORDERS, 3)
    end
end

function onEventUpdate(player, csid, option, target)
    if player:getCharVar("ShadesOfVengeance") == 1 then
        local party = player:getParty()
        if (party ~= nil) then
            for i, v in ipairs(party) do
                if v:getCurrentMission(TOAU) < tpz.mission.id.toau.SHADES_OF_VENGEANCE then
                    player:messageText(target, ID.text.MEMBER_NO_REQS, false)
                    player:instanceEntry(target, 1)
                elseif v:getZoneID() == player:getZoneID() and v:checkDistance(player) > 50 then
                    player:messageText(target, ID.text.MEMBER_TOO_FAR, false)
                    player:instanceEntry(target, 1)
                    return
                end
            end
        end

        player:createInstance(79, 56)
    else
        onAssaultUpdate(player, csid, option, target, tpz.ki.PERIQIA_ASSAULT_ORDERS, 56)
    end
end

function onEventFinish(player, csid, option, target)

    if csid == 133 or (csid == 143 and option == 4) then
        player:setPos(0, 0, 0, 0, 56)
    end
end

function onInstanceCreated(player, target, instance)
    if instance and player:getCharVar("ShadesOfVengeance") == 1 then
        player:setInstance(instance)
        player:instanceEntry(target, 4)

        player:setCharVar("ShadesOfVengeance", 0)
        player:delKeyItem(tpz.ki.PERIQIA_ASSAULT_AREA_ENTRY_PERMIT)

        local party = player:getParty()
        if party ~= nil then
            for i, v in ipairs(party) do
                if (v:getID() ~= player:getID() and v:getZoneID() == player:getZoneID()) then
                    v:setInstance(instance)
                    v:startEvent(133)
                    v:delKeyItem(tpz.ki.PERIQIA_ASSAULT_AREA_ENTRY_PERMIT)
                end
            end
        end
    else
        onAssaultCreated(player, target, instance, 133, tpz.ki.PERIQIA_ASSAULT_ORDERS)
    end
end
