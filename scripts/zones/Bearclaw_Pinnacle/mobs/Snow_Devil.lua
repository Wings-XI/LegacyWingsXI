-----------------------------------
-- Area: Bearclaw Pinnacle
-- Mob: Snoll Tzar
-- ENM: When Hell Freezes Over
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
-----------------------------------

local controlBombs =
{
    {16801818, 16801821},
    {16801826, 16801829},
    {16801834, 16801837},
}

function onMobSpawn(mob)
    mob:setMod(tpz.mod.SLEEPRES, 75)
    mob:setMod(tpz.mod.LULLABYRES, 75)
    mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 50)
    mob:setUnkillable(true)
    mob:setLocalVar("unkillable", 1)

    -- timer because
        -- the first mobs to spawn in a battlefield cannot query their battlefield info
        -- also so new waves reset battlefield localvars _after_ all take_damage listeners resolve
    mob:timer(1000, function(mobArg)
        local bf = mobArg:getBattlefield()
        local bfNum = bf:getArea()

        for i = 1, 2 do
            if mobArg:getID() == controlBombs[bfNum][i] then
                bf:setLocalVar("mobsDead", 0)
                bf:setLocalVar("controlBombID", controlBombs[bfNum][i])
                bf:setLocalVar("adds", math.random(0,2))

                -- "Each wave has a random number of Snow Devils ranging between 1 and 3. There are a total of 4 waves of Snow Devils."
                -- "Thus, the total number of Snow Devils fought for this ENM is between 4 and 12."
                for y = 1, bf:getLocalVar("adds") do
                    SpawnMob(mobArg:getID() + y)
                end
            end
        end
    end)

    -- avoid duplicate listeners, putting this in onMobDeath didn't always remove it
    mob:removeListener("DEVIL_TAKE_DAMAGE")
    mob:addListener("TAKE_DAMAGE", "DEVIL_TAKE_DAMAGE", function(mobArg, amount, attacker, attackType, damageType)
        if amount >= mobArg:getHP() then
            local bf = mobArg:getBattlefield()
            local bfNum = bf:getArea()
            local controlID = bf:getLocalVar("controlBombID")
            if mobArg:getLocalVar("unkillable") == 0 then
                bf:setLocalVar("mobsDead", bf:getLocalVar("mobsDead") + 1)
                if
                    bf:getLocalVar("mobsDead") >= bf:getLocalVar("adds") + 1 and
                    bf:getLocalVar("wave") < 3
                then
                    bf:setLocalVar("wave", bf:getLocalVar("wave") + 1)
                    bf:setLocalVar("lastWaveStart", os.time())
                    if bf:getLocalVar("controlBombID") == controlBombs[bfNum][1] then
                        SpawnMob(controlBombs[bfNum][2])
                    else
                        SpawnMob(controlBombs[bfNum][1])
                    end
                end
            end
        end
    end)
end

function onMobFight(mob, target)
    local bf = mob:getBattlefield()
    -- Take note that killing a wave before the previous despawned will complete the battlefield early.
        -- This should be impossible without GM powers, but we should protect regardless (15s despawn timer + death animation)
    if mob:getLocalVar("unkillable") == 1 and bf:getLocalVar("lastWaveStart") + 20 < os.time() then
        mob:setUnkillable(false)
        mob:setLocalVar("unkillable", 0)
    end
end

function onMobRoam(mob, target)
    local bf = mob:getBattlefield()
    if mob:getLocalVar("unkillable") == 1 and bf:getLocalVar("lastWaveStart") + 20 < os.time() then
        mob:setUnkillable(false)
        mob:setLocalVar("unkillable", 0)
    end
end

function onMobDeath(mob, player, isKiller)
end
