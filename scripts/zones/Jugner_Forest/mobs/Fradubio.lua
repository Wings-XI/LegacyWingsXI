-----------------------------------
-- Area: Jugner_Forest
--   NM: Fradubio
-----------------------------------
local ID = require("scripts/zones/Jugner_Forest/IDs")

function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 329 then
        for i = ID.mob.DUESSA_START, ID.mob.DUESSA_END do
            local pet = GetMobByID(i)
            if not pet:isSpawned() then
                local petId = pet:getID()
                switch (petId): caseof {
                    [17203449] = function()
                        pet:setSpawn(mob:getXPos() + 1, mob:getYPos(), mob:getZPos())
                        pet:spawn()
                        pet:updateEnmity(mob:getTarget())
                    end,
                    [17203450] = function()
                        pet:setSpawn(mob:getXPos() + 2, mob:getYPos(), mob:getZPos())
                        pet:spawn()
                        pet:updateEnmity(mob:getTarget())
                    end,
                    [17203451] = function()
                        pet:setSpawn(mob:getXPos() + 3, mob:getYPos(), mob:getZPos())
                        pet:spawn()
                        pet:updateEnmity(mob:getTarget())
                    end,
                    [17203452] = function()
                        pet:setSpawn(mob:getXPos() + 4, mob:getYPos(), mob:getZPos())
                        pet:spawn()
                        pet:updateEnmity(mob:getTarget())
                    end,
                    [17203453] = function()
                        pet:setSpawn(mob:getXPos() + 5, mob:getYPos(), mob:getZPos())
                        pet:spawn()
                        pet:updateEnmity(mob:getTarget())
                    end,
                }
                break
            end
        end
    end
end


function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    for i = ID.mob.DUESSA_START, ID.mob.DUESSA_START do
        DespawnMob(i)
    end
end
