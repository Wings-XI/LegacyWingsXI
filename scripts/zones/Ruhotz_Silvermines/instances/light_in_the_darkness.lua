-----------------------------------
--
-- Light in the Darkness
-- WotG Bastok Mission Quest - 03
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
    for i = 0, 9 do
        SpawnMob(ID.mob.SAPPHIRINE_QUADAV_OFFSET + i, instance)
    end
end

function onInstanceTimeUpdate(instance, elapsed)
    updateInstanceTime(instance, elapsed, ID.text)
end

function onInstanceFailure(instance)
    local chars = instance:getChars()
    for i, v in pairs(chars) do
        v:startEvent(10001)
    end
end

function onInstanceProgressUpdate(instance, progress)
     if progress >= 7 then
        instance:complete()
     end
end

function onInstanceComplete(instance)

    local chars = instance:getChars()

    for i, v in pairs(chars) do
        -- 5 is the first attempt, 8 is retry attempts
        if (v:getCharVar("LightInTheDarkness") == 5 or v:getCharVar("LightInTheDarkness") == 8) then
            v:setCharVar("LightInTheDarkness", 9)
            v:startEvent(10000, 300, 500, 41555, 1299) -- can't seem to get this to work manually with GM commands?
        else
            v:startEvent(10001) -- could be off by 1 or 2 or we just need to send them to grauberg
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 10001 or csid == 10000 then 
        player:setPos(-385.705, 23.938, 460.703, 192, 90)
    end
end