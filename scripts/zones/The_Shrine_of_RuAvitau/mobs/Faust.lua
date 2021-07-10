-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Faust
-----------------------------------

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 30)
end

function onMobFight(mob, target)
    local changeTime = mob:getLocalVar("changeTime")
    local state = mob:getLocalVar("state")
    -- > 40% uses Typhoon back to back every 15 seconds
    if mob:getHPP() >= 40 and mob:getBattleTime() - changeTime >= 15 then
        mob:useMobAbility(539)
        mob:timer(4500, function(faust)
            if faust:checkDistance(faust:getTarget()) <= 6 then
                faust:useMobAbility(539)
            end
        end)
        mob:setLocalVar("changeTime", mob:getBattleTime())
    -- < 40% spams Typhoon over and over
    elseif mob:getHPP() < 40 and state == 0 then
        mob:setMobMod(tpz.mobMod.SKILL_LIST, 367)
        mob:setMod(tpz.mod.REGAIN, 3000)
        mob:setLocalVar("state", 1)
    end
end

function onMobRoam(mob)
    local roam = mob:getLocalVar("roam")
    local faustPos = mob:getPos()
    -- Stationary looking back and forth every 9 seconds
    if (roam == 2 and faustPos.x == 740 and faustPos.y == 0 and faustPos.z == -99) then
        mob:setLocalVar("roam", 0)
        if (faustPos.rot ~= 255) then
            faustPos.rot = 255
        else
            faustPos.rot = 190
        end
        mob:setPos(faustPos.x, faustPos.y, faustPos.z, faustPos.rot)
    else 
        mob:setLocalVar("roam", roam+1)
        mob:pathThrough({ 740.000, -0.400, -99.000 })
    end
end

function onMobDisengage(mob)
    mob:setLocalVar("changeTime", 0)
    mob:setLocalVar("state", 0)
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    local respawn = math.random(10800, 21600)
    mob:setRespawnTime(respawn) -- 3 to 6 hours
    SetServerVariable("Faust_Respawn", (os.time() + respawn))
end
