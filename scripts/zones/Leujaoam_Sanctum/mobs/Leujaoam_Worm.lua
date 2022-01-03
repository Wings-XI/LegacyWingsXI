-----------------------------------
-- Area: Leujaoam Sanctum (Leujaoam Cleansing)
--  Mob: Leujaoam Worm
-- Immune to Charm, strong to Magical Attacks
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:setLocalVar("wormRoaming", 0)
    mob:setLocalVar("wormRoamingMaxDistance", 10)
    mob:setLocalVar("wormOriginalXpos", mob:getXPos())
    mob:setLocalVar("wormOriginalZpos", mob:getZPos())
end

function onMobDeath(mob, player, isKiller)
    if mob:getLocalVar("Killed") == 0 then
        local instance = mob:getInstance()
        instance:setProgress(instance:getProgress() + 1)
        mob:setLocalVar("Killed", 1)
    end
end

function onMonsterMagicPrepare(mob, target)
    -- Used retail screenshot to determine spells's frequency
    local rnd = math.random(0,47)

    if rnd < 10 then
        return 258 -- Bind
    elseif rnd >= 10 < 16 then
        return 162 -- Stone IV
    elseif rnd >= 16 < 25 then
        return 191 -- Stonega III
    elseif rnd >= 25 < 31 then
        return 210 -- Quake
    elseif rnd >= 31 < 45 then
        return 238 -- Rasp
    else
        return 54 -- Stoneskin
    end
end

function onMobRoam(mob)
    -- had to add custom roaming method for worms in assault
    -- wormRoaming == 0 : worm is up and ready to go underground when condition is filfulled
    -- wormRoaming == 1 : worm is underground, and moving to a random position
    -- wormRoaming == 2 : worm is underground, and comming back up

    if mob:getLocalVar("wormRoaming") == 0 then
        -- every few second there less than 5% chance for the worm to move
        local rnd = math.random(0, 20)

        if rnd < 1 then
            mob:AnimationSub(1)
            mob:hideName(true)
            mob:untargetable(true)
            mob:timer(2000, function(mob) mob:setLocalVar("wormRoaming", 1) end)
        end
    elseif mob:getLocalVar("wormRoaming") == 1 then
        mob:speed(100)
        mob:setMobMod(tpz.mobMod.ROAM_COOL, 0)
        local rndRoamingDuration = math.random(4000, 7000) -- between 4 and 7 sec of roaming
        mob:timer(rndRoamingDuration, function(mob)
            mob:setMobMod(tpz.mobMod.ROAM_COOL, 90)
            mob:speed(0)
        end)
        mob:timer(rndRoamingDuration + 1000, function(mob) mob:setLocalVar("wormRoaming", 2) end)
    elseif mob:getLocalVar("wormRoaming") == 2 then
        mob:AnimationSub(0)
        mob:hideName(false)
        mob:untargetable(false)
        mob:setLocalVar("wormRoaming", 0)
    end
end

function onMobFight(mob, target)
    mob:hideName(false)
    mob:untargetable(false)
    
    if mob:getLocalVar("wormRoaming") == 2 then
        mob:AnimationSub(0)
        mob:setLocalVar("wormRoaming", 0)
    end
end
