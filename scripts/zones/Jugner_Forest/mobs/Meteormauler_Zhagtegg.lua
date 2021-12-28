-----------------------------------
-- Area: Jugner Forest
--   NM: Meteormauler Zhagtegg
-----------------------------------
local ID = require("scripts/zones/Jugner_Forest/IDs")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobSpawn(mob)
    -- Takes half damage from all attacks
    mob:addMod(tpz.mod.DMGPHYS,-50)
    mob:addMod(tpz.mod.DMGRANGE,-50)
    mob:addMod(tpz.mod.DMGMAGIC,-50)

    local chance = math.random(1,2)
    if chance == 1 then
        SpawnMob(ID.mob.METEORMAULER_GUARD1):setPos(mob:getXPos()+2, mob:getYPos(), mob:getZPos())
        SpawnMob(ID.mob.METEORMAULER_GUARD2):setPos(mob:getXPos()+4, mob:getYPos(), mob:getZPos())
    end
end

function onMobFight(mob, target)
    local mobId = mob:getID()

    for i = 1, 2 do
        local child = GetMobByID(mobId + i)
        if child:isSpawned() then
            if target and child:getCurrentAction() == tpz.act.ROAMING then -- doing nothing, make share enmity
                child:updateEnmity(target)
            end
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
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(75600 + math.random(0, 600)) -- 21 hours, 10 minute window
end
