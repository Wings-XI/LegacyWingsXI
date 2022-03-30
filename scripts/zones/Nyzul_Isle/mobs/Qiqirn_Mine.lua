------------------------------------------
-- Qiqirn Mine in Nyzul Isle
--  blows up 8-9 seconds after spawn using entityAnimationPacket mai1
------------------------------------------
require("scripts/globals/status")

function onMobInitialize(mob)
    mob:setMod(tpz.mod.LULLABYRESTRAIT, 100)
    mob:setMod(tpz.mod.SLEEPRESTRAIT, 100)
    mob:setMod(tpz.mod.STUNRESTRAIT, 100)
    mob:untargetable(true)
    mob:SetAutoAttackEnabled(false)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:setMobMod(tpz.mobMod.ALWAYS_AGGRO, 1)
    mob:addListener("ON_AGGRO_PLAYER", "MINE_AGGRO", function(mob, player)
        if (mob and mob:isSpawned() and mob:isAlive()) then
            if (mob:getLocalVar("MineAggro") == 0) then
                mob:setLocalVar("MineAggro", 1)
                -- mine blast - 1838
                mob:useMobAbility(1838, player)
            end
        end
    end)
end

function onMobRoam(mob)
    if (mob:getLocalVar("SelfDestructCountdown") <= 0) then
        -- explosion animation
        mob:entityAnimationPacket("mai1")
        mob:setHP(0)
        mob:timer(500, function(mob)
            DespawnMob(mob:getID(), mob:getInstance())
        end)
    else
        mob:setLocalVar("SelfDestructCountdown", mob:getLocalVar("SelfDestructCountdown") - 1)
    end
end

function onMobSpawn(mob)
    -- 3 roaming ticks seems to do it
    mob:setLocalVar("SelfDestructCountdown", 3)
end

function onMobSkillFinished(mob, target, skill)
    mob:setHP(0)
    mob:timer(500, function(mob)
        DespawnMob(mob:getID(), mob:getInstance())
    end)
end

function onMobDespawn(mob)
    mob:setLocalVar("MineAggro", 0)
end

function onMobDeath(mob, player, isKiller)
end