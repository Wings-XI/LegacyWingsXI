-----------------------------------
-- Area: Throne Room
--  Mob: Smash! A Malevolent Menace
-- AMK 14 fight
-----------------------------------
require("scripts/globals/status")
-----------------------------------

local function reEngage(mob)
    mob:setLocalVar("retreated", 0)
    mob:setLocalVar("used_flare", 0)
    mob:setLocalVar("phaseStartHP", mob:getHP())
    mob:setLocalVar("phase", mob:getLocalVar("phase") + 1)

    -- despawn whms
    for i = mob:getID() + 8, mob:getID() + 9 do
        local whmMoogle = GetMobByID(i)
        if whmMoogle:isSpawned() then
            DespawnMob(whmMoogle:getID())
        end
    end

    -- Make Riko hurtable again
    local player = GetPlayerByID(mob:getLocalVar("last_target"))
    mob:setMod(tpz.mod.UDMGPHYS, 250)
    mob:setMod(tpz.mod.UDMGBREATH, 250)
    mob:setMod(tpz.mod.UDMGMAGIC, 250)
    mob:setMod(tpz.mod.UDMGRANGE, 250)
    mob:setMobMod(tpz.mobMod.NO_AGGRO, 0)
    mob:setMobMod(tpz.mobMod.NO_LINK, 0)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
    mob:untargetable(false)
    mob:updateClaim(player)
end

local healModeTimer
healModeTimer = function(mob)
    -- Riko rejoins the fight if:
    -- 1) all five blms are dead
    -- 2) he reaches 100%hp
    if
        amkHelpers.rikoBlmsAlive(mob) == 0 or
        mob:getHPP() == 100
    then
        reEngage(mob)
    elseif mob:isSpawned() then
        mob:timer(3 * 1000, function(mob)
            healModeTimer(mob)
        end)
    end
end

local function phaseChange(mob, player)
    local rikoID = mob:getID()
    local bf = mob:getBattlefield()
    local bfArea = bf:getArea()
    local healSpot = amkHelpers.rikoSpots[bfArea]
    mob:setLocalVar("retreated", 1)
    mob:setLocalVar("last_target", player:getID())
    mob:setMobMod(tpz.mobMod.NO_AGGRO, 1)
    mob:setMobMod(tpz.mobMod.NO_LINK, 1)
    mob:untargetable(true)
    mob:setMod(tpz.mod.UDMGPHYS, 0)
    mob:setMod(tpz.mod.UDMGBREATH, 0)
    mob:setMod(tpz.mod.UDMGMAGIC, 0)
    mob:setMod(tpz.mod.UDMGRANGE, 0)

    -- -- Move to top of stairs and go into fetal position while getting healed
    mob:pathTo(healSpot.x, healSpot.y, healSpot.z)

    -- spawn blms on spot
    local currPos = mob:getPos()
    local spawned = 0
    for blmID = rikoID + 1, rikoID + 7 do
        if spawned < 1 then
            local blmMoogle = GetMobByID(blmID)
            if not blmMoogle:isSpawned() then
                local x = currPos.x + math.random(-2, 2)
                local z = currPos.z + math.random(-2, 2)
                blmMoogle:setSpawn(x, currPos.y, z)
                SpawnMob(blmID):updateClaim(player)
                spawned = spawned + 1
            end
        end
    end

    -- -- spawn whms up top
    for whmID = rikoID + 8, rikoID + 9 do
        if not GetMobByID(whmID):isSpawned() then
            SpawnMob(whmID)
        end
    end

    healModeTimer(mob)
end

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
end

function onMobSpawn(mob)
    mob:setLocalVar("phase", 1)
    mob:SetMobSkillAttack(185)
    mob:setLocalVar("retreated", 0)
    mob:setLocalVar("phaseStartHP", mob:getHP())
end

function onMobEngaged(mob, target)
    -- sets/increments phase counters
    mob:setMod(tpz.mod.REGAIN, 50)
end

function onMobFight(mob, target)
    local bf = mob:getBattlefield()
    local bfArea = bf:getArea()

    local healSpot = amkHelpers.rikoSpots[bfArea]
    local retreated = mob:getLocalVar("retreated")
    if
        retreated == 1 and
        mob:atPoint(healSpot.x, healSpot.y, healSpot.z)
    then
        mob:deaggroAll()
        mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
        -- mob:AnimationSub(tpz.anim.HEALING)
    end

    local bf = mob:getBattlefield()
    local phase = mob:getLocalVar("phase")

    -- give up
    if phase == 3 and mob:getHPP() < 25 then
        bf:win()
    elseif
        mob:getHP() / mob:getLocalVar("phaseStartHP") < 0.5 and
        retreated == 0 and
        mob:getLocalVar("phase") < 3
    then
        -- lost 50% hp this phase
        phaseChange(mob, target)
    elseif
        mob:getHP() / mob:getLocalVar("phaseStartHP") < 0.75 and
        mob:getLocalVar("used_flare") == 0 and
        mob:getLocalVar("phase") < 3
    then
        -- lost 25% hp this phase
        local drawInTarget = target
        if drawInTarget ~= nil then
            if target:isPet() then
                drawInTarget = drawInTarget:getMaster()
            end
            -- mob:triggerDrawIn(true, 1, 60, drawInTarget)
            for _, member in pairs(drawInTarget:getAlliance()) do
                if member:hasEnmity(mob) then
                    mob:triggerDrawIn(false, 1, 60, member)
                end
            end
        end
        mob:useMobAbility(2467) -- crystalline flare
        mob:setLocalVar("used_flare", 1)
    end
end

function onMobWeaponSkillPrepare(mob, target)
    if mob:getLocalVar("phase") == 3 then
        if math.random(1,8) == 1 then
            mob:useMobAbility(2467) -- crystalline flare
        end
    elseif math.random(1, 4) ~= 1 then
        return 3148
    end
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    mob:setLocalVar("phase", 1)
    mob:untargetable(false)
    mob:setMobMod(tpz.mobMod.NO_AGGRO, 0)
    mob:setMobMod(tpz.mobMod.NO_LINK, 0)
end
