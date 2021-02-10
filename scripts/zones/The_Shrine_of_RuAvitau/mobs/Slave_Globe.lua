-----------------------------------
-- Area: The Shrine of Ru'Avitau
--   NM: Slave Globe
-----------------------------------
local ID = require("scripts/zones/The_Shrine_of_RuAvitau/IDs")
require("scripts/globals/status")
require("scripts/globals/mobs")
require("scripts/globals/pathfind")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onMobSpawn(mob)
    mob:addMod(tpz.mod.MOVE, 200)
    onMobRoam(mob)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.STUN)
end

function onMobRoam(mob)
    local mother = GetMobByID(ID.mob.MOTHER_GLOBE.MOTHER)
    if mother:isSpawned() then
        local mobId = mob:getID()
        local pPet = GetMobByID(mobId - 1)
        switch (mobId): caseof {
            [17506397] = function() mob:pathTo(mother:getXPos() + 0.15, mother:getYPos(), mother:getZPos() + 0.15) end,
            [17506398] = function() mob:pathTo(pPet:getXPos() + 0.15, pPet:getYPos(), pPet:getZPos() + 0.15) end,
            [17506399] = function() mob:pathTo(pPet:getXPos() + 0.15, pPet:getYPos(), pPet:getZPos() + 0.15) end,
            [17506400] = function() mob:pathTo(pPet:getXPos() + 0.15, pPet:getYPos(), pPet:getZPos() + 0.15) end,
            [17506401] = function() mob:pathTo(pPet:getXPos() + 0.15, pPet:getYPos(), pPet:getZPos() + 0.15) end,
            [17506402] = function() mob:pathTo(pPet:getXPos() + 0.15, pPet:getYPos(), pPet:getZPos() + 0.15) end,
        }
    end
end

function onMobEngaged(mob, target)
    local mother = GetMobByID(ID.mob.MOTHER_GLOBE.MOTHER)
    if mother:getCurrentAction() == tpz.act.ROAMING then
        mother:updateEnmity(target)
    end

    for i = ID.mob.MOTHER_GLOBE.SLAVE_START, ID.mob.MOTHER_GLOBE.SLAVE_END do
        if i ~= mob:getID() then
            local slave = GetMobByID(i)
            if slave and slave:getCurrentAction() == tpz.act.ROAMING then
                slave:updateEnmity(target)
            end
        end
    end
end

function onMobDeath(mob)
end

function onMobDespawn(mob)
    local mother = GetMobByID(ID.mob.MOTHER_GLOBE.MOTHER)
    if mother:isSpawned() then
        mother:setLocalVar("SlavesSpawned", mother:getLocalVar("SlavesSpawned") - 1)
    end
end