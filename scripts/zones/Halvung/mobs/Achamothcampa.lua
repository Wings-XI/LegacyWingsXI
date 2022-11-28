-----------------------------------
-- Area: Halvung
--  Mob: Achamothcampa
-- Author: Spaceballs
-----------------------------------


-- Immune to either physical or magic damage depending on curl form
-- If add is not killed in 30s time, will turn into Achamoth Nympha
-- Max of 2 adds TOTAL

local ID = require("scripts/zones/Halvung/IDs")

local function spawnBig(mob, target)
    local mother = GetMobByID(ID.mob.ACHAMOTH) -- should be 17031600
    local big = mother:getLocalVar("bigAdds")
    local mobId = mob:getID()
    local mobPos = mob:getPos()

    -- Determine which mob should grow up, then do so
    if GetMobByID(17031603):isSpawned() then 
        local pet = GetMobByID(17031604)
        pet:setSpawn(mobPos.x + math.random(-2, 2), mobPos.y, mobPos.z + math.random(-2, 2), mobPos.r)
        pet:spawn(17031604) 
        pet:updateEnmity(target)    
    else
        local pet = GetMobByID(17031603)
        pet:setSpawn(mobPos.x + math.random(-2, 2), mobPos.y, mobPos.z + math.random(-2, 2), mobPos.r)
        pet:spawn(17031603)
        pet:updateEnmity(target)
    end
    
    GetMobByID(ID.mob.ACHAMOTH):setLocalVar("bigAdds", big + 1)
    local mobId = mob:getID()
    DespawnMob(mobId)
end


function onMobSpawn(mob)
    mob:setLocalVar("clock", os.time() + 30) 
end


function onMobDeath(mob)
end

function onMobDespawn(mob)
    local mother = GetMobByID(ID.mob.ACHAMOTH) 
    if mother:isSpawned() then
        mother:setLocalVar("smallAdds", mother:getLocalVar("smallAdds") - 1)
    end
end

function onMobFight(mob, target)
    local now = os.time()
    local popTime = mob:getLocalVar("clock")

    if now >= popTime then
        spawnBig(mob, target)
    end
end 