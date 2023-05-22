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

function onMobRoam(mob)
    onPath(mob)
end

function onMobSpawn(mob)
    mob:addMod(tpz.mod.MOVE, 200)
    onPath(mob)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.STUN)
end

function onPath(mob)
    local mother = GetMobByID(ID.mob.MOTHER_GLOBE.MOTHER)
    if mother:isSpawned() then
        local petOffset = mob:getID() - ID.mob.MOTHER_GLOBE.MOTHER
        -- path X yalms away from previous pet, but do it all based on the mother's location
        mob:pathTo(mother:getXPos() + 0.25 * petOffset, mother:getYPos(), mother:getZPos()  + 0.25 * petOffset)
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