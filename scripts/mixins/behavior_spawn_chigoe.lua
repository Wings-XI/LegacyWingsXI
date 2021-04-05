require("scripts/globals/mixins")
require("scripts/globals/status")


g_mixins = g_mixins or {}

g_mixins.behavior_spawn_chigoe = function(mob)

    mob:addListener("SPAWN", "SPAWN_CHIGOE_SPAWN", function(mob)
        mob:setLocalVar("[chigoe]pool", 1)
        mob:setLocalVar("[chigoe]perAbility", 1)
    end)

    mob:addListener("WEAPONSKILL_STATE_EXIT", "SPAWN_CHIGOE_WEAPONSKILL_STATE_EXIT", function(mob, skillid)
        mob:timer(2000, function(mob)
            local spawnCount = mob:getLocalVar("[chigoe]spawnCount")
            if spawnCount < 5 then
                local count = 0
                local perAbility = mob:getLocalVar("[chigoe]perAbility")
                local ID = zones[mob:getZoneID()]
                local target = mob:getTarget()
                if target and target:isPet() then
                    target = target:getMaster()
                end
                for i, id in ipairs(ID.mob.CHIGOE_POOLS[mob:getLocalVar("[chigoe]pool")]) do
                    local chigoe = GetMobByID(id)
                    if not chigoe:isSpawned() then
                        local pos = mob:getPos()
                        chigoe:setSpawn(pos.x, pos.y, pos.z)
                        chigoe:spawn()
                        if target then
                            chigoe:updateEnmity(target)
                        end
                        spawnCount = spawnCount + 1
                        mob:setLocalVar("[chigoe]spawnCount", spawnCount)
                        chigoe:addListener("DISENGAGE", "CHIGOE_DISENGAGE", function(mob)
                            mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
                            DespawnMob(mob:getID(), 15)
                        end)
                        count = count + 1
                        if count >= perAbility or spawnCount >= 5 then
                            break
                        end
                    end
                end
            end
        end)
    end)

end

return g_mixins.behavior_spawn_chigoe