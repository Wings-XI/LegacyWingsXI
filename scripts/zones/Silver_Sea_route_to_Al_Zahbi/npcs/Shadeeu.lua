-----------------------------------
-- Area: Silver_Sea_route_to_Al_Zahbi
--  NPC: Shadeeu
-- Notes: Tells ship ETA time
-- !pos 0.340 -12.232 -4.120 58
-----------------------------------
local ID = require("scripts/zones/Silver_Sea_route_to_Al_Zahbi/IDs")
require("scripts/globals/transport")
-----------------------------------

local messages =
{
    [tpz.transport.message.NEARING] = ID.text.NEARING_AL_ZAHBI,
    [tpz.transport.message.DOCKING] = ID.text.DOCKING_IN_AL_ZAHBI
}

function onSpawn(npc)
    npc:addPeriodicTrigger(tpz.transport.message.NEARING, tpz.transport.messageTime.SILVER_SEA, tpz.transport.epochOffset.NEARING)
    npc:addPeriodicTrigger(tpz.transport.message.DOCKING, tpz.transport.messageTime.SILVER_SEA, tpz.transport.epochOffset.DOCKING)
end

function onTimeTrigger(npc, triggerID)
    tpz.transport.captainMessage(npc, triggerID, messages)
end

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local vHour = VanadielHour()
    local vMin  = VanadielMinute()
    local rMin  = 0
    local onwayto = ID.text.ON_WAY_TO_AL_ZAHBI
    local arrivingsoon = ID.text.ARRIVING_SOON_AL_ZAHBI

    while vHour >= 6 do
        vHour = vHour - 5
    end

    if (vHour ==  0) then
        vHour = 6
        if vMin < 30 then
            rMin = 13
        else
            rMin = 12
        end
    elseif (vHour ==  1) then
        vHour = 5
        if vMin < 30 then
            rMin = 11
        else
            rMin = 10
        end
    elseif (vHour ==  2) then
        vHour = 4
        if vMin < 30 then
            rMin = 9
        else
            rMin = 8
        end
    elseif (vHour ==  3) then
        vHour = 3
        if vMin < 30 then
            rMin = 7
        else
            rMin = 6
        end
    elseif (vHour ==  4) then
        vHour = 2
        if vMin < 30 then
            rMin = 5
        else
            rMin = 4
        end
    elseif (vHour ==  5) then
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
        vHour = 1
        rMin = 1
    end

    player:messageSpecial( message, rMin, vHour)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
