-----------------------------------
-- Area: Ship bound for Mhaura Pirates
--  NPC: Sahn
-- Notes: Tells ship ETA time
-- !pos 0.28 -14.0 -1.411 221
-----------------------------------
local ID = require("scripts/zones/Ship_bound_for_Mhaura_Pirates/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local vHour = VanadielHour()
    local vMin  = VanadielMinute()
    local rMin  = 0
    local onwayto = ID.text.ON_WAY_TO_MHAURA
    local arrivingsoon = ID.text.ARRIVING_SOON_MHAURA

    while vHour >= 6 do
        vHour = vHour - 8
    end

    if (vHour == -4) then
        vHour = 8
        if vMin < 30 then
            rMin = 17
        else
            rMin = 16
        end
    elseif (vHour == -3) then
        vHour = 7
        if vMin < 30 then
            rMin = 15
        else
            rMin = 14
        end
    elseif (vHour == -2) then
        vHour = 6
        if vMin < 30 then
            rMin = 13
        else
            rMin = 12
        end
    elseif (vHour == -1) then
        vHour = 5
        if vMin < 30 then
            rMin = 11
        else
            rMin = 10
        end
    elseif (vHour ==  0) then
        vHour = 4
        if vMin < 30 then
            rMin = 9
        else
            rMin = 8
        end
    elseif (vHour ==  1) then
        vHour = 3
        if vMin < 30 then
            rMin = 7
        else
            rMin = 6
        end
    elseif (vHour ==  2) then
        vHour = 2
        if vMin < 30 then
            rMin = 5
        else
            rMin = 4
        end
    elseif (vHour ==  3) then
        vHour = 1
        if vMin < 30 then
            rMin = 3
        else
            rMin = 2
        end
    end

    local vMinutes = (vHour * 60) + 40 - vMin

    local message = onwayto

    if (vMinutes <= 30) then
        message = arrivingsoon
    elseif (vMinutes < 60) then
        vHour = 0
        rMin = 1
    end

    player:messageSpecial( message, rMin, vHour)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
