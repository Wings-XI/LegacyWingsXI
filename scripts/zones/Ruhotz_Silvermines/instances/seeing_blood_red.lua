-----------------------------------
--
-- SCH AF3: Seeing Blood-Red
--
-----------------------------------
require("scripts/globals/instance")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Ruhotz_Silvermines/IDs")
-----------------------------------

function afterInstanceRegister(player)
    local instance = player:getInstance()
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())
end

function onInstanceCreated(instance)
    SpawnMob(ID.mob.ULBRECHT, instance)
end

function onInstanceTimeUpdate(instance, elapsed)
    updateInstanceTime(instance, elapsed, ID.text)
end

function onInstanceFailure(instance)

    local mob = GetMobByID(ID.mob.ULBRECHT, instance)
    if mob then
        mob:messageText(mob, ID.text.UNLEARNT_SPRAT)
    end

    local chars = instance:getChars()
    for i, v in pairs(chars) do
        v:startEvent(10001)
    end
end

function onInstanceProgressUpdate(instance, progress)
end

function onInstanceComplete(instance)

    local chars = instance:getChars()

    for i, v in pairs(chars) do
        if (v:getCharVar("SeeingBloodRed") == 3) then
            v:setCharVar("SeeingBloodRed", 4)
            v:startEvent(10000, 300, 23, 1757) -- can't seem to get this to work manually with GM commands?
        else
            v:startEvent(10001) -- could be off by 1 or 2 or we just need to send them to grauberg
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end