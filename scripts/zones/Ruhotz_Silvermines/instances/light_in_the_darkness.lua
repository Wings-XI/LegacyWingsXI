-----------------------------------
-- Light in the Darkness
-- WotG Bastok Mission Quest - 03
-----------------------------------
require("scripts/globals/instance")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Ruhotz_Silvermines/IDs")
-----------------------------------

local stage2Positions = {
    [17158192] = {x = -100.45,  z = 0.4639, y = 5.1662},
    [17158193] = {x = -139.2461, z = 0.0958, y = 3.9902},
    [17158194] = {x = -140.1666, z = 0.2225, y = 151.874},
    [17158195] = {x = -100.239, z = 0.6913, y = 178.543},
    [17158196] = {x = -96.4195, z = 0.7734, y = 138.922},
    [17158197] = {x = -34.8375, z = -2.375, y = 99.3041},
    [17158198] = {x = -20.2044, z = -2.4518, y = 112.5729},
    [17158199] = {x = 72.0351, z = 0.0562, y = 20.1773},
    [17158200] = {x = 14.1505, z = 0.1939, y = 27.3358}
}

function afterInstanceRegister(player)
    local instance = player:getInstance()
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())
end

function onInstanceZoneIn(player, instance)
    -- currently does not trigger w/o changing luautils::OnInstanceZoneIn
    -- replicated in Ruhotz_Silvermines Zone.lua with an instance ID check
    local lightInTheDarknessProgress = player:getCharVar("LightInTheDarkness")
    if (lightInTheDarknessProgress == 5 or lightInTheDarknessProgress == 8) then
        player:startEvent(4)
    end
end

function onInstanceCreated(instance)
    for i = 0, 9 do
        SpawnMob(ID.mob.SAPPHIRINE_QUADAV_OFFSET + i, instance)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 10001 or csid == 10000 then 
        player:setPos(-385.705, 23.938, 460.703, 192, 90)
    end
end

function onInstanceTimeUpdate(instance, elapsed)
    if instance:getStage() == 0 and elapsed > 180000 then
        instance:setStage(1) -- give players 3 mins to get in and view CS before letting quads aggro
    end
    updateInstanceTime(instance, elapsed, ID.text)
end

function onInstanceStageChange(instance, stage)
    if(stage >= 1) then
        local mobs = instance:getMobs()
        for i, mob in pairs(mobs) do
            if mob:isSpawned() then
                mob:setMobMod(tpz.mobMod.NO_AGGRO, 0)
            end
        end
    end

    if(stage == 2) then -- sapphire quadav was killed, scatter mobs
        local mobs = instance:getMobs()
        for i, mob in pairs(mobs) do
            mobID = mob:getID()
            mob:setSpawn(stage2Positions[mobID].x, stage2Positions[mobID].z, stage2Positions[mobID].y)
            mob:pathTo(stage2Positions[mobID].x, stage2Positions[mobID].z, stage2Positions[mobID].y)
        end
    end
end

function onInstanceFailure(instance)
    local chars = instance:getChars()
    for i, v in pairs(chars) do
        v:setCharVar("LightInTheDarkness", 6)
        v:startEvent(10001)
    end
end

function onInstanceProgressUpdate(instance, progress)
     if progress == 7 then
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

