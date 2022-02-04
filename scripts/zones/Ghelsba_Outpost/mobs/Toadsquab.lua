-----------------------------------
-- Area: Ghelsba Outpost
--  Mob: Toadsquab
-- BCNM: Toadal Recall
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.SUPERLINK, 1)
    mob:setMod(tpz.mod.SLEEPRES, 100)
    mob:setMod(tpz.mod.BINDRES, 50)
    mob:setMod(tpz.mod.LULLABYRES, 100)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:setMobMod(tpz.mobMod.SOUND_RANGE, 15)
end

function onMobSpawn(mob)
    mob:setLocalVar("tpskill", math.random(15, 30))
    mob:setLocalVar("capreset", 120)
end

function onMobEngaged(mob)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
end

function onMobFight(mob, target)
    local tpskill = mob:getLocalVar("tpskill")
    local capreset = mob:getLocalVar("capreset")
    local wait = mob:getLocalVar("wait")
    local caps = mob:getLocalVar("caps")
    local reset = mob:getLocalVar("reset")

    if wait >= tpskill and mob:checkDistance(mob:getTarget()) <= 8 then
        if mob:AnimationSub() == 0 or mob:AnimationSub() == 4 and caps == 0 then
            mob:useMobAbility(310)
            mob:setLocalVar("tpskill", math.random(15, 30))
            wait = 0
            mob:setLocalVar("caps", 1) 
        elseif mob:AnimationSub() == 1 then
            mob:useMobAbility(311)
            mob:setLocalVar("tpskill", math.random(15, 30))
            wait = 0
            mob:setLocalVar("caps", 2) 
        elseif mob:AnimationSub() == 2 then
            mob:useMobAbility(312)
            mob:setLocalVar("tpskill", 100)
            wait = 0
            mob:setLocalVar("caps", 3) 
        end
    else
        mob:setLocalVar("wait", wait+1)
    end

    if mob:getLocalVar("caps") == 3 and wait >= capreset and reset == 0 then
        mob:setLocalVar("caps", 0) 
        mob:timer(1000 , function(mob) mob:AnimationSub(4) end)
        mob:useMobAbility(626)
        mob:setLocalVar("reset", 1)
        mob:setLocalVar("tpskill", math.random(15, 30))
        mob:setLocalVar("wait", 0)
    else
        mob:setLocalVar("wait", wait+1)
    end
end

function onMobDeath(mob, player, isKiller)
end
