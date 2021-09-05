-----------------------------------
-- Area: Ghelsba Outpost
--  Mob: Colo-colo
-- BCNM: Wings of Fury
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

-- next two mob IDs are two furies

function onMobEngaged(mob, target)
    local mobID = mob:getID()
    for i = mobID+1, mobID+2 do
        local m = GetMobByID(i)
        if m and m:isSpawned() and m:isAlive() then
            m:updateEnmity(target)
        end
    end
end
