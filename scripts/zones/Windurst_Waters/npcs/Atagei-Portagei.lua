-----------------------------------
-- Area: Windurst Waters
--  NPC: Atagei-Portagei
-- Type: Special Event Coordinator
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/npc_util")
require("scripts/globals/teleports")
require("scripts/globals/events/starlight_festivals")
-----------------------------------------------------

function onTrigger(player, npc)
    if isStarlightEnabled ~= 0 then
        local zone = player:getZoneName()
        local ID = zones[player:getZoneID()]
        local contentEnabled = isStarlightEnabled()
        local smilebringersconvo = player:getCharVar("smilebringersconvo")
        local previousDay = player:getCharVar("previousDay")
        local currentDay = VanadielDayOfTheWeek()
        local fame = player:getFameLevel(HOLIDAY)
        local head = player:getEquipID(tpz.slot.HEAD)

        if previousDay ~= currentDay then
            player:setCharVar("smilebringersconvo", 0)
        end

        if smilebringersconvo == 0 then
            player:startEvent(252)
            player:setFame(HOLIDAY, 1)
        elseif smilebringersconvo == 1 and (head == 15179 or head == 15178) then
            if fame < 1 then
                player:showText(npc, ID.text.STARLIGHT_FAME_DIALOG, 0, 0)
            elseif fame == 1 then
                player:showText(npc, ID.text.STARLIGHT_FAME_DIALOG, 0, 1)
            elseif fame == 2 then
                player:showText(npc, ID.text.STARLIGHT_FAME_DIALOG, 0, 1)
            elseif fame == 3 then
                player:showText(npc, ID.text.STARLIGHT_FAME_DIALOG, 0, 2)
            elseif fame == 4 then
                player:setLocalVar("famebefore", player:getFame(HOLIDAY))
                player:startEvent(32741, 0260, 0003, 0600, 0000, 7800, 0000, 0000, 0000)
            elseif fame == 5 then
                player:setLocalVar("famebefore", player:getFame(HOLIDAY))
                player:startEvent(32741, 0260, 0004, 0600, 0000, 7800, 0000, 0000, 0000)
            elseif fame == 6 then
                player:setLocalVar("famebefore", player:getFame(HOLIDAY))
                player:startEvent(32741, 0260, 0004, 0600, 0000, 7800, 0000, 0000, 0000)
            elseif fame == 7 then
                player:setLocalVar("famebefore", player:getFame(HOLIDAY))
                player:startEvent(32741, 0260, 0005, 0600, 0000, 7800, 0000, 0000, 0000)
            elseif fame == 8 then
                player:setLocalVar("famebefore", player:getFame(HOLIDAY))
                player:startEvent(32741, 0260, 0005, 0600, 0000, 7800, 0000, 0000, 0000)
            elseif fame == 9 then
                player:setLocalVar("famebefore", player:getFame(HOLIDAY))
                player:startEvent(32741, 0260, 0006, 0600, 0000, 7800, 0000, 0000, 0000)
            end
        else
            player:startEvent(32742)
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player,csid, option)
    local fame = player:getFameLevel(HOLIDAY)
    local cost = 90
    local famebefore = player:getLocalVar("famebefore")
    local fameafter = (famebefore - cost)
    if csid == 32741 and fame > 3 then
        if option == 1 then
            player:setFame(HOLIDAY, fameafter)
            player:addStatusEffectEx(tpz.effect.TELEPORT, 0, tpz.teleport.id.SAN_DORIA_STARLIGHT, 0, 1)
        elseif option == 2 then 
            player:setFame(HOLIDAY, fameafter)
            player:addStatusEffectEx(tpz.effect.TELEPORT, 0, tpz.teleport.id.BASTOK_STARLIGHT, 0, 1)
        elseif option == 3 then
            player:setFame(HOLIDAY, fameafter)
            player:addStatusEffectEx(tpz.effect.TELEPORT, 0, tpz.teleport.id.WINDURST_STARLIGHT, 0, 1)
        end
    elseif csid == 252 then
        if player:getFreeSlotsCount() >= 1 then
            player:addItem(1742, 1)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1742)
            player:setCharVar("smilebringersconvo", 1)
            player:setCharVar("previousDay", VanadielDayOfTheWeek())
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED)
        end
    end
end