-----------------------------------
-- Area: The Shrine of Ru'Avitau
--   NM: Mother Globe
-- TODO: Looked like pets had an additional effect: stun with an unknown proc rate
-- TODO: "Links with Slave Globes, and Slave Globes link with Defenders. Defenders do not link with Slave Globes or Mother Globe."
-----------------------------------
local ID = require("scripts/zones/The_Shrine_of_RuAvitau/IDs")
require("scripts/globals/status")
require("scripts/globals/mobs")
require("scripts/globals/pathfind")
-----------------------------------

local path =
{
    859, -99, -539,
    874, -99, -551,
    888, -99, -569,
    887, -99, -594,
    872, -99, -611,
    860, -99, -620,
    844, -99, -609,
    832, -99, -591,
    831, -99, -567,
    847, -99, -550,
    860, -99, -554,
    860, -99, -568,
    859, -99, -596,
    882, -99, -599,
    877, -99, -580,
    839, -99, -580,
    839, -99, -558,
    859, -99, -539,
}

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onMobSpawn(mob)
    local now = os.time()
    mob:addStatusEffectEx(tpz.effect.SHOCK_SPIKES, 0, 60, 0, 0) -- ~60 damage
    mob:setLocalVar("Initial_SlaveTimer", now)
    mob:setLocalVar("SlaveRecast", now)
    onMobRoam(mob)
end

function onPath(mob)
    tpz.path.patrol(mob, path)
end

function onMobRoam(mob)
    local now = os.time()
    local slaves = mob:getLocalVar("SlavesSpawned")
    local slaveRecast = mob:getLocalVar("SlaveRecast")
    if slaves > 6 then
        mob:setLocalVar("SlavesSpawned", 0)
    end
    if slaves < 6 and (now >= mob:getLocalVar("Initial_SlaveTimer") + 60) then
        for i = ID.mob.MOTHER_GLOBE.SLAVE_START, ID.mob.MOTHER_GLOBE.SLAVE_END do
            local pet = GetMobByID(i)
            if not pet:isSpawned() and (now > slaveRecast + 10) then
                local pPet = nil
                local petId = pet:getID()
                switch (petId): caseof {
                    [17506397] = function() 
                        pet:setSpawn(mob:getXPos(), mob:getYPos(), mob:getZPos())
                        pet:spawn()
                        pet:pathTo(mob:getXPos() + 0.15, mob:getYPos(), mob:getZPos() + 0.15) 
                    end,
                    [17506398] = function() 
                        pPet = GetMobByID(petId - 1)
                        pet:setSpawn(mob:getXPos(), mob:getYPos(), mob:getZPos())
                        pet:spawn()
                        pet:pathTo(pPet:getXPos() + 0.5, pPet:getYPos(), pPet:getZPos() + 0.5) 
                    end,
                    [17506399] = function() 
                        pPet = GetMobByID(petId - 1)
                        pet:setSpawn(mob:getXPos(), mob:getYPos(), mob:getZPos())
                        pet:spawn()
                        pet:pathTo(pPet:getXPos() + 0.5, pPet:getYPos(), pPet:getZPos() + 0.5) 
                    end,
                    [17506400] = function() 
                        pPet = GetMobByID(petId - 1)
                        pet:setSpawn(mob:getXPos(), mob:getYPos(), mob:getZPos())
                        pet:spawn()
                        pet:pathTo(pPet:getXPos() + 0.5, pPet:getYPos(), pPet:getZPos() + 0.5) 
                    end,
                    [17506401] = function() 
                        pPet = GetMobByID(petId - 1)
                        pet:setSpawn(mob:getXPos(), mob:getYPos(), mob:getZPos())
                        pet:spawn()
                        pet:pathTo(pPet:getXPos() + 0.5, pPet:getYPos(), pPet:getZPos() + 0.5) 
                    end,
                    [17506402] = function() 
                        pPet = GetMobByID(petId - 1)
                        pet:setSpawn(mob:getXPos(), mob:getYPos(), mob:getZPos())
                        pet:spawn()
                        pet:pathTo(pPet:getXPos() + 0.5, pPet:getYPos(), pPet:getZPos() + 0.5) 
                    end,
                }
                mob:setLocalVar("SlaveRecast", now)
                mob:setLocalVar("SlavesSpawned", mob:getLocalVar("SlavesSpawned") + 1)
                break
            end
        end
    end

    if (mob:isFollowingPath() == false) then
        mob:pathThrough(tpz.path.first(path))
    end
end

function onMobFight(mob, target)
    -- Keep pets linked
    for i = ID.mob.MOTHER_GLOBE.SLAVE_START, ID.mob.MOTHER_GLOBE.SLAVE_END do
        local pet = GetMobByID(i)
        if pet:getCurrentAction() == tpz.act.ROAMING then
            pet:updateEnmity(target)
        end
    end

    -- Summons a single orb every 30 seconds.  Needs to be last, so other code runs.
    -- TODO: Should have a SMN casting effect for ~3-5 seconds while calling.
    if mob:getLocalVar("SlavesSpawned") < 6 then
        if mob:hasStatusEffect(tpz.effect.SHOCK_SPIKES) == false then
            mob:addStatusEffectEx(tpz.effect.SHOCK_SPIKES, 0, 60, 0, 0) -- ~60 damage
        end

        if mob:getBattleTime() % 30 == 0 and mob:getBattleTime() > 3 then
            for i = ID.mob.MOTHER_GLOBE.SLAVE_START, ID.mob.MOTHER_GLOBE.SLAVE_END do
                local pet = GetMobByID(i)
                if not pet:isSpawned() then
                    pet:setSpawn(mob:getXPos() + 1, mob:getYPos(), mob:getZPos() + 1)
                    pet:spawn()
                    pet:updateEnmity(target)
                    return
                end
            end
        end
    end
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENTHUNDER)
end

function onMobDeath(mob, player, isKiller)
    mob:setRespawnTime(math.random(10800, 21600)) -- respawn 3-6 hrs

    for i = ID.mob.MOTHER_GLOBE.SLAVE_START, ID.mob.MOTHER_GLOBE.SLAVE_END do
        local pet = GetMobByID(i)
        if pet:isSpawned() then
            DespawnMob(i)
        end
    end
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(10800, 21600)) -- 3 to 6 hours
end
