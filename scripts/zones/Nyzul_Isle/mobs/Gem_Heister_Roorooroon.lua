------------------------------------------
-- Gem Heister Roorooroon
-- Nyzul Isle
-- Thf type Qiqirn
-- Via capture - throws bombs like crazy and barely stops running
------------------------------------------
require("scripts/globals/status")
------------------------------------------
local NYZUL_ISLE_INVESTIGATION_QIQIRN_MINE = 17092962
local MINE_SPAWN_RATE_IN_SECONDS = 2 -- per capture

function onMobInitialize(mob)
    mob:addMod(tpz.mod.EVA, 200) -- capped evasion
    mob:setMod(tpz.mod.MOVE, 40) -- enhanced movement speed
end

function onMobFight(mob, target)
    local runningAway = mob:getLocalVar("QQ_RunningAway")
    local spawnPoint = mob:getSpawnPos()
    local runAwayPos = {}
    runAwayPos.x = mob:getLocalVar("QQ_RunAwayX")
    runAwayPos.y = mob:getLocalVar("QQ_RunAwayY")
    runAwayPos.z = mob:getLocalVar("QQ_RunAwayZ")

    -- using QQ_RunningAway as a state control
    -- 0 at spawn
    -- 1 at runAway point
    -- 2 in transit

    if (runningAway == 0) then
        mob:setLocalVar("QQ_RunningAway", 2)
        local runAwayX = mob:getLocalVar("QQ_RunAwayX")
        local runAwayY = mob:getLocalVar("QQ_RunAwayY")
        local runAwayZ = mob:getLocalVar("QQ_RunAwayZ")
        -- runaway logic unless we have a 0,0,0 pos
        if (runAwayX > 0) or (runAwayY > 0) or (runAwayZ > 0) then
            mob:pathTo(runAwayX, runAwayY, runAwayZ, 0)
        end
    elseif (runningAway == 1) then
        mob:setLocalVar("QQ_RunningAway", 2)
        mob:pathTo(spawnPoint.x, spawnPoint.y, spawnPoint.z, 0)
    end

    if (mob:checkDistance(runAwayPos) <= 2) then
        mob:setLocalVar("QQ_RunningAway", 1)
    elseif (mob:checkDistance(spawnPoint) <= 2) then
        mob:setLocalVar("QQ_RunningAway", 0)
    end

    -- toss out mines on the regualar
    local mineTime = mob:getLocalVar("QQ_MineTime")
    if (mineTime < os.time()) then
        mob:setLocalVar("QQ_MineTime", os.time() + MINE_SPAWN_RATE_IN_SECONDS)
        local mine = GetMobByID(NYZUL_ISLE_INVESTIGATION_QIQIRN_MINE, mob:getInstance())
        if(not mine:isSpawned()) then
            local pos = mob:getPos()
            mine:setSpawn(pos.x, pos.y, pos.z)
            SpawnMob(NYZUL_ISLE_INVESTIGATION_QIQIRN_MINE, mob:getInstance())
            mine:setLocalVar("wDmgMultiplier", 4)
        end
    end
end

function onMobDeath(mob, player, isKiller)
end