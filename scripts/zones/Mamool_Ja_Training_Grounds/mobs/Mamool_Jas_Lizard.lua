-----------------------------------
-- Area: Mamool Ja Training Grounds (Imperial Agent Rescue)
--  Mob: Mamool Ja Lizard
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:setLocalVar("masterID", mob:getID() -1)
    onPath(mob)
end

function onMobDeath(mob, player, isKiller)
end

function onPath(mob)
    mob:timer(1000, function(mob) 
        local master = GetMobByID(mob:getLocalVar("masterID"), mob:getInstance())

        if master:isSpawned() then
            local petX = master:getXPos()
            local petY = master:getYPos()
            local petZ = master:getZPos()
            
            local radians = (256 - master:getRotPos()) * (math.pi / 128)

            petX = petX - (2 * math.cos(radians))
            petZ = petZ - (2 * math.sin(radians))
            
            mob:pathTo(petX, petY, petZ)    
            mob:lookAt(master:getXPos(), master:getYPos(), master:getZPos())
        end
    end)
end

