-----------------------------------
-- Area: Eastern Altepa Desert (114)
--   NM: Centurio XII-I
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobSpawn(mob)
    -- Takes only 50% damage from both physical and magical attacks. Enfeebles are at best half-resisted.
    mob:addMod(tpz.mod.DMGPHYS,-50)
    mob:addMod(tpz.mod.DMGMAGIC,-50)
    mob:addMod(tpz.mod.STATUSRES,50)
end

function onMobFight( mob, target )
    local mobId = mob:getID()
    -- make sure minions have a target
    for i = mobId + 1, mobId + 2 do
        local pet = GetMobByID(i)
        if (pet:getCurrentAction() == tpz.act.ROAMING) then
            pet:updateEnmity(target)
        end
    end
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    -- Set Centurio XII-I's spawnpoint and respawn time (21-24 hours)
    UpdateNMSpawnPoint(mob:getID())
    local respawn = math.random(75600,86400)
    mob:setRespawnTime(respawn)
    SetServerVariable("CenturioRespawn",(os.time() + respawn))
end
