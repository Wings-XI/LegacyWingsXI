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
    print("reengaging")
    -- despawn whms
    for i = mob:getID() + 8, mob:getID() + 9 do
        local whmMoogle = GetMobByID(i)
        if whmMoogle:isSpawned() then
            DespawnMob(whmMoogle:getID())
        end
    end

    -- Make Riko hurtable again
    mob:setMod(tpz.mod.UDMGPHYS, 250)
    mob:setMod(tpz.mod.UDMGBREATH, 250)
    mob:setMod(tpz.mod.UDMGMAGIC, 250)
    mob:setMod(tpz.mod.UDMGRANGE, 250)
end

local healModeTimer
healModeTimer = function(mob)
    -- Riko rejoins the fight if:
    -- 1) all five blms are dead
    -- 2) he reaches 100%hp
    print("timer----")
    if
        amkHelpers.rikoBlmsAlive(mob) == 0 or
        mob:getHPP() == 100
    then
        print("reengaging from timer")
        reEngage(mob)
    else
        print("timer else function")
        mob:timer(3 * 1000, function(mob)
            healModeTimer(mob)
        end)
    end
end

local function phaseChange(mob, player)
    local rikoID = mob:getID()
    local bf = mob:getBattlefield()
    local bfArea = bf:getArea()
    local bfAreaPos = {
        { x = -488.286, y = -172.000, z = -240.000 },
        { x = -808.666, y = -412.000, z = -479.897 },
        { x = -1126.113, y = -652.000, z = -720.000 },
    }
    mob:setLocalVar("retreated", 1)

    -- reset enmity
    mob:setMobMod(tpz.mobMod.NO_AGGRO, 1)
    mob:setMobMod(tpz.mobMod.NO_LINK, 1)
    -- mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    -- mob:deaggroAll()
    for _, member in pairs(player:getAlliance()) do
        printf("reseting enmity: %s", member:getName())
        mob:resetEnmity(member)
        mob:deaggroPlayer(member)
    end
    -- Move to top of stairs and go into fetal position while getting healed
    mob:pathTo(bfAreaPos[bfArea].x, bfAreaPos[bfArea].y, bfAreaPos[bfArea].z)
    -- Riko moves to top of stairs then immmediately comes back to attack the player
    mob:setMod(tpz.mod.UDMGPHYS, 0)
    mob:setMod(tpz.mod.UDMGBREATH, 0)
    mob:setMod(tpz.mod.UDMGMAGIC, 0)
    mob:setMod(tpz.mod.UDMGRANGE, 0)

    -- change animation, set to non-violent
    -- just sits there, doens't aggro, but attacks if get near him

    -- spawn blms on spot
    local currPos = mob:getPos()
    local spawned = 0
    for blmID = rikoID + 1, rikoID + 7 do
        if spawned < 5 then
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
    -------DEBUG-------
    -- if mob:actionQueueEmpty() then
    --     mob:useMobAbility(2517)
    -- end
    -------DEBUG-------
    local bf = mob:getBattlefield()
    local phase = mob:getLocalVar("phase")

    -- give up
    if phase == 3 and mob:getHPP() < 25 then
        bf:win()
    elseif
        mob:getHP() / mob:getLocalVar("phaseStartHP") < 0.5 and
        mob:getLocalVar("retreated") == 0
    then
        -- lost 50% hp this phase
        phaseChange(mob, target)
    elseif
        mob:getHP() / mob:getLocalVar("phaseStartHP") < 0.75 and
        mob:getLocalVar("used_flare") == 0
    then
        -- lost 25% hp this phase
        mob:setMobMod(tpz.mobMod.DRAW_IN_INCLUDE_PARTY, 1)
        mob:setMobMod(tpz.mobMod.DRAW_IN_CUSTOM_RANGE, 25)
        mob:useMobAbility(2467) -- crystilline flare
        mob:setLocalVar("used_flare", 1)
        print("flaring")

    end
end

function onMobWeaponSkillPrepare(mob, target)
    if mob:getLocalVar("retreated") == 0 then
        if math.random(1, 4) ~= 1 then
            return 3148
        end
    end
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    mob:setLocalVar("phase", 1)
end
