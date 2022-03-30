-----------------------------------
-- Area: Pashhow Marshlands
--   NM: Bo'Who Warmonger
-----------------------------------
require("scripts/globals/regimes")
mixins = {require("scripts/mixins/job_special")}
local ID = require("scripts/zones/Pashhow_Marshlands/IDs")
-----------------------------------

function onMobSpawn(mob)
    -- Takes half damage from all attacks
    mob:addMod(tpz.mod.DMGPHYS,-50)
    mob:addMod(tpz.mod.DMGRANGE,-50)
    mob:addMod(tpz.mod.DMGMAGIC,-50)

    local chance = math.random(1,2)
    if chance == 1 then
        GetMobByID(ID.mob.BOWHO_GUARD1):setSpawn(mob:getXPos()+2, mob:getYPos(), mob:getZPos())
        GetMobByID(ID.mob.BOWHO_GUARD2):setSpawn(mob:getXPos()+4, mob:getYPos(), mob:getZPos())
        SpawnMob(ID.mob.BOWHO_GUARD1)
        SpawnMob(ID.mob.BOWHO_GUARD2)
    end
end

function onMobEngaged(mob, target)
    local mobId = mob:getID()

    for i = 1, 2 do
        local guard = GetMobByID(mobId + i)
        if guard:isSpawned() then
            guard:updateEnmity(target)
        end
    end
end

function onMobRoam(mob)
    local mobId = mob:getID()

    for i = 1, 2 do
        local guard = GetMobByID(mobId + i)
        if guard:isSpawned() and guard:getID() == mobId + 1 then
            guard:pathTo(mob:getXPos() + 1, mob:getYPos() + 3, mob:getZPos() + 0.15)
        elseif guard:isSpawned() and guard:getID() == mobId + 2 then
            guard:pathTo(mob:getXPos() + 3, mob:getYPos() + 5, mob:getZPos() + 0.15)
        end
    end
end

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 60, 1, tpz.regime.type.FIELDS)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(75600 + math.random(600, 900)) -- 21 hours, plus 10 to 15 min
end
