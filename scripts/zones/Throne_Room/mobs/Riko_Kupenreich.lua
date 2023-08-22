-----------------------------------
-- Area: Throne Room
--  Mob: Smash! A Malevolent Menace
-- AMK 14 fight
-----------------------------------
require("scripts/globals/status")
-----------------------------------

local function phaseChange(mob)
    local bf = mob:getBattlefield()
    local bfArea = bf:getArea()
    local bfAreaPos = {
        { x = -488.286, y = -172.000, z = -240.000 },
        { x = -808.666, y = -412.000, z = -479.897 },
        { x = -1126.113, y = -652.000, z = -720.000 },
    }
    mob:setLocalVar("retreated", 1)
    mob:setLocalVar("used_flare", 0)

    mob:pathTo(bfAreaPos[bfArea].x, bfAreaPos[bfArea].y, bfAreaPos[bfArea].z)
    -- change animation, set to non-violent
    -- just sits there, doens't aggro, but attacks if get near him

    -- spawn blms on spot
    local currPos = mob:getPos()
    local spawned = 0
    for blmID = mob:getID() + 1, mob:getID() + 7 do
        if spawned < 5 then
            local blmStooge = GetMobByID(blmID)
            if not blmStooge:isSpawned() then
                local x = currPos.x + math.random(-2, 2)
                local z = currPos.z + math.random(-2, 2)
                blmStooge:setSpawn(x, currPos.y, z)
                blmStooge:spawn()
            end
            spawned = spawned + 1
        end
    end

    -- -- spawn whms up top
    for whmID = mob:getID() + 8, mob:getID() + 9 do
        local whmStooge = GetMobByID(whmID)
        if not whmStooge:isSpawned() then
            whmStooge:spawn()
        end
    end
end

local function reEngage(mob)
    mob:setLocalVar("retreated", 0)
    mob:setLocalVar("phaseStartHP", mob:getHP())
    -- despawn whms
    for i = mob:getID() + 8, mob:getID() + 9 do
        local moogle = GetMobByID(i)
        if moogle:isSpawned() then
            DespawnMob(moogle:getID())
        end
    end
end

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
end

function onMobSpawn(mob)
    -- mob:setMobMod(tpz.mobMod.ALLI_HATE, 60)
    mob:setMod(tpz.mod.UDMGPHYS, 300)
    mob:setMod(tpz.mod.UDMGBREATH, 300)
    mob:setMod(tpz.mod.UDMGMAGIC, 300)
    mob:setMod(tpz.mod.UDMGRANGE, 300)
    mob:setLocalVar("phase", 1)
    mob:SetMobSkillAttack(185)
end

function onMobEngaged(mob, target)
    -- sets/increments phase counters
    reEngage(mob)
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
    elseif mob:getHP() / mob:getLocalVar("phaseStartHP") < 0.5 then
        -- lost 50% hp this phase
        phaseChange(mob)
    elseif
        mob:getHP() / mob:getLocalVar("phaseStartHP") < 0.75 and
        mob:getLocalVar("used_flare") == 0
    then
        -- lost 25% hp this phase
        mob:setMobMod(tpz.mobMod.DRAW_IN_INCLUDE_PARTY, 1)
        mob:setMobMod(tpz.mobMod.DRAW_IN_CUSTOM_RANGE, 25)
        mob:useMobAbility(2467) -- crystilline flare
        mob:setLocalVar("used_flare", 1)

    end
end

function onMobWeaponSkillPrepare(mob, target)
    if mob:getLocalVar("retreated") == 0 then
        return 3148
    end
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    mob:setLocalVar("phase", 1)
end