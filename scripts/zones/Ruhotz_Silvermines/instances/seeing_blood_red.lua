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
    -- maybe delete key item here?
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())
end

function onInstanceCreated(instance)
    --SpawnMob(ID.mob.GESSHO, instance)
end

function onInstanceTimeUpdate(instance, elapsed)
    updateInstanceTime(instance, elapsed, ID.text)
end

function onInstanceFailure(instance)

    local chars = instance:getChars()

    for i, v in pairs(chars) do
        --v:messageSpecial(ID.text.MISSION_FAILED, 10, 10)
        v:startEvent(102)
    end
end

function onInstanceProgressUpdate(instance, progress)
end

function onInstanceComplete(instance)

    local chars = instance:getChars()

    for i, v in pairs(chars) do
        if (v:getCharVar("SeeingBloodRed") == 3) then
            v:setCharVar("SeeingBloodRed", 4)
            v:startEvent(10000)
        else
            v:startEvent(10000) -- could be off by 1 or 2 or we just need to send them to grauberg
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 10000 then

    end
end
