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
    {16801832, 16801835},
}

function onMobSpawn(mob)
    mob:setMod(tpz.mod.SLEEPRES, 75)
    mob:setMod(tpz.mod.LULLABYRES, 75)
    mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 50)

    -- 1s timer as the first mobs to spawn in a battlefield cannot query their battlefield info
    mob:timer(1, function(mobArg)
        local bfNum = mobArg:getBattlefield():getArea()
        local bf = mobArg:getBattlefield()

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

    mob:addListener("TAKE_DAMAGE", "DEVIL_TAKE_DAMAGE", function(mobArg, amount, attacker, attackType, damageType)
        if amount >= mobArg:getHP() then
            local bfNum = mob:getBattlefield():getArea()
            local bf = mob:getBattlefield()
            bf:setLocalVar("mobsDead", bf:getLocalVar("mobsDead") + 1)
            if
                bf:getLocalVar("mobsDead") >= bf:getLocalVar("adds") + 1 and
                bf:getLocalVar("wave") < 3
            then
                bf:setLocalVar("wave", bf:getLocalVar("wave") + 1)
                if bf:getLocalVar("controlBombID") == controlBombs[bfNum][1] then
                    SpawnMob(controlBombs[bfNum][2])
                else
                    SpawnMob(controlBombs[bfNum][1])
                end
            end
        end
    end)
end

entity.onMobDeath = function(mob, player, isKiller)
    mob:removeListener("DEVIL_TAKE_DAMAGE")
end
