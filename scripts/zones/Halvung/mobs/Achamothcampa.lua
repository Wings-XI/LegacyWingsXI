-----------------------------------
-- Area: Halvung
--  Mob: Achamothcampa
-- Author: Spaceballs
-----------------------------------


-- Immune to either physical or magic damage depending on curl form
-- If add is not killed in 30s time, will turn into Achamoth Nympha
-- Max of 2 adds TOTAL

local smallList = { -- Achamothcampa
    17031601, 
    17031602
}
 
local bigList = { -- Achamoth_Nympha
    17031603, 
    17031604
}
local ID = require("scripts/zones/Halvung/IDs")

local function spawnBig(mob)
    local mother = GetMobByID(ID.mob.ACHAMOTH) -- should be 17031600
    local big = mother:getLocalVar("bigAdds")
    local mobId = mob:getID()
    local mobPos = mob:getPos()

    -- Determine which mob should grow up, then do so
    if mob:getHPP(bigList(1)) > 0 then 
        local pet = GetMobByID(bigList(2))
        pet:setSpawn(mobPos.x + math.random(-2, 2), mobPos.y, mobPos.z + math.random(-2, 2), mobPos.r)
        pet:spawn(bigList(2))     
    else
        local pet = GetMobByID(bigList(1))
        pet:setSpawn(mobPos.x + math.random(-2, 2), mobPos.y, mobPos.z + math.random(-2, 2), mobPos.r)
        pet:spawn(bigList(1))
    end
    pet:updateEnmity(target)
    mother:setLocalVar("bigAdds", big + 1)
    DespawnMob(mobId)
end


function onMobSpawn(mob)
    mob:setLocalVar("clock", os.time() + 30) 
end


function onMobDeath(mob)
    local mother = GetMobByID(ID.mob.ACHAMOTH) 
    if mother:isSpawned() then
        mother:setLocalVar("smallAdds", mother:getLocalVar("smallAdds") - 1)
    end
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
        spawnBig(mob)
    end
end 