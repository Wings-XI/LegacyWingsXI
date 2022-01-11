------------------------------------------
-- Qiqirn Treasure Hunter in Nyzul Isle
-- Thf type Qiqirn
------------------------------------------
require("scripts/globals/status")
------------------------------------------
local NYZUL_ISLE_INVESTIGATION_QIQIRN_MINE = 17092962
local MINE_SPAWN_RATE_IN_SECONDS = 60

function onMobInitialize(mob)
    mob:setMod(tpz.mod.ACC, 100) -- extra accurate
end

function onMobEngaged(mob, target)
    -- dont start dropping mines immediately
    mob:setLocalVar("QQ_MineTime", os.time() + 30)
end

function onMobFight(mob, target)
    if (mob:getHPP() <= 50 and mob:getLocalVar("QQ_RunAway") == 0) then
        mob:setLocalVar("QQ_RunAway", 1)
        mob:setMod(tpz.mod.MOVE, 50)
        mob:setLocalVar("QQ_MineTime", os.time() + 3)

        local runAwayX = mob:getLocalVar("QQ_RunAwayX")
        local runAwayY = mob:getLocalVar("QQ_RunAwayY")
        local runAwayZ = mob:getLocalVar("QQ_RunAwayZ")

        if (mob:getLocalVar("QQ_RunAwayX_Negative") > 0) then
            runAwayX = runAwayX * -1
        end
        if (mob:getLocalVar("QQ_RunAwayY_Negative") > 0) then
            runAwayY = runAwayY * -1
        end
        if (mob:getLocalVar("QQ_RunAwayZ_Negative") > 0) then
            runAwayZ = runAwayZ * -1
        end

        -- runaway logic unless we have a 0,0,0 pos
        if (runAwayX ~= 0) or (runAwayZ ~= 0) then
            mob:pathTo(runAwayX, runAwayY, runAwayZ, 9)
        end
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
        end
    end
end

function onMobDeath(mob, player, isKiller)
end