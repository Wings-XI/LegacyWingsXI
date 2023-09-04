-----------------------------------
-- Area: Throne Room
--  Mob: Smash! A Malevolent Menace
-- AMK 14 fight
-- TODO: Make it so Riko does his TP move attack without that "readying #3148" text
--       Put Riko into healing animation when hes in heal mode
-- Testing notes:
--  Do his attacks seem too weak/strong?
--  Are the blms so weak that riko doesn't gain hp back fast enough?
--      fight too easy if you can just burn them down
-----------------------------------
local ID = require("scripts/zones/Throne_Room/IDs")
require("scripts/globals/status")
-----------------------------------

local function resetRiko(mob)
    -- "During this fight, most sources will inflict roughly threefold damage to all targets"
    mob:setMod(tpz.mod.UDMGPHYS, 200)
    mob:setMod(tpz.mod.UDMGBREATH, 200)
    mob:setMod(tpz.mod.UDMGMAGIC, 200)
    mob:setMod(tpz.mod.UDMGRANGE, 200)
    mob:setMobMod(tpz.mobMod.NO_AGGRO, 0)
    mob:setMobMod(tpz.mobMod.NO_LINK, 0)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
    mob:setBehaviour(tpz.behavior.NONE)
end

local function reEngage(mob)
    mob:setLocalVar("retreated", 0)
    mob:setLocalVar("used_flare", 0)
    mob:setLocalVar("phaseStartHP", mob:getHP())
    mob:setLocalVar("phase", mob:getLocalVar("phase") + 1)
    mob:setMod(tpz.mod.REGAIN, 100)

    -- despawn whms
    for i = mob:getID() + 8, mob:getID() + 9 do
        local whmMoogle = GetMobByID(i)
        if whmMoogle:isSpawned() then
            DespawnMob(whmMoogle:getID())
        end
    end

    -- Make Riko hurtable again, and reaggro last target, check phase
    resetRiko(mob)
    local player = GetPlayerByID(mob:getLocalVar("last_target"))
    if player ~= nil and player:isAlive() then
        mob:updateClaim(player)
        mob:addEnmity(player, 1, 0)
    end

    if mob:getLocalVar("phase") == 3 then
        mob:setUnkillable(false)
    end
    
    mob:showText(mob, ID.text.BACK_TO_BUSINESS)
end

local healModeTimer
healModeTimer = function(mob)
    -- Riko rejoins the fight if:
    -- 1) all five blms are dead or
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

local function spawnBlms(mob)
    -- Spawn 5 blms on spot
    local rikoId = mob:getID()
    local player = mob:getTarget()
    local currPos = mob:getPos()
    local spawned = 0
    mob:setLocalVar("henchmen_blm_randomizer", math.random(0,5))
    for blmId = rikoId + 1, rikoId + 7 do
        if spawned < 5 then
            local blmMoogle = GetMobByID(blmId)
            if not blmMoogle:isSpawned() then
                local x = currPos.x + math.random(-2, 2)
                local z = currPos.z + math.random(-2, 2)
                blmMoogle:setSpawn(x, currPos.y, z)
                SpawnMob(blmId)
                if player ~= nil and player:isAlive() then
                    GetMobByID(blmId):updateClaim(player)
                end
                spawned = spawned + 1
            end
        end
    end
end

local function retreat(mob, player)
    local rikoId = mob:getID()
    local bf = mob:getBattlefield()
    local bfArea = bf:getArea()
    local healSpot = amkHelpers.rikoSpots[bfArea]

    -- Store last target to reaggro upon reengage
    mob:setLocalVar("last_target", player:getID())

    -- Enter retreat mode
    mob:setLocalVar("retreated", 1)
    mob:setMobMod(tpz.mobMod.NO_AGGRO, 1)
    mob:setMobMod(tpz.mobMod.NO_LINK, 1)
    mob:setBehaviour(tpz.behavior.NO_TURN + tpz.behavior.STANDBACK)
    mob:setMod(tpz.mod.UDMGPHYS, -100)
    mob:setMod(tpz.mod.UDMGBREATH, -100)
    mob:setMod(tpz.mod.UDMGMAGIC, -100)
    mob:setMod(tpz.mod.UDMGRANGE, -100)
    mob:setMod(tpz.mod.REGAIN, 0)

    -- Spawn whms at top of stairs
    for whmId = rikoId + 8, rikoId + 9 do
        if not GetMobByID(whmId):isSpawned() then
            SpawnMob(whmId)
        end
    end

    -- Move to top of stairs and go into fetal position while getting healed
    mob:pathTo(healSpot.x, healSpot.y, healSpot.z)

    -- Begin reoccuring timer to check for reengage parameters
    healModeTimer(mob)
end

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
end

function onMobSpawn(mob)
    resetRiko(mob)
    mob:setLocalVar("phase", 1)
    mob:SetMobSkillAttack(185)
    mob:setLocalVar("retreated", 0)
    mob:setLocalVar("phaseStartHP", mob:getHP())
    mob:setUnkillable(true)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 0)
end

function onMobEngaged(mob, target)
    mob:showText(mob, ID.text.BONANZA_BEGINS)
    mob:setMod(tpz.mod.REGAIN, 100)
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
        -- reset all enmity
        for _, member in pairs(target:getAlliance()) do
            mob:resetEnmity(member)
        end
        mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
        mob:setLocalVar("retreated", 2)
        mob:timer(2 * 1000, function(mob)
            mob:showText(mob, ID.text.THAT_HIT_THE_SPOT)
        end)
    end

    local bf = mob:getBattlefield()
    local phase = mob:getLocalVar("phase")

    -- Give up @ 25% HP
    if
        phase == 4 and 
        (mob:getHP() / mob:getLocalVar("phaseStartHP")) < 0.25
    then
        mob:showText(mob, ID.text.CURTAINS_FOR_FESTIVAL)
        bf:win()
    elseif
        mob:getHP() / mob:getLocalVar("phaseStartHP") < 0.5 and
        retreated == 0
    then
        -- lost 50% hp this phase
        if phase < 3 then
            mob:showText(mob, ID.text.THIRD_PRIZE_REST_RELAXATION)
            mob:delStatusEffectsByFlag(tpz.effectFlag.WALTZABLE, false)
            mob:delStatusEffectsByFlag(tpz.effectFlag.ERASABLE, false)
            retreat(mob, target)
        end
        if phase < 4 then
            spawnBlms(mob)
            if phase == 3 then
                mob:setLocalVar("phase", 4)
            end
        end
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
    mob:setLocalVar("skill_tp", mob:getTP())
    if mob:getLocalVar("next_tp_move") < os.time() then
        if mob:getTP() < 3000 then
            mob:setLocalVar("next_tp_move", os.time() + 2)
            return 3148
        elseif mob:getLocalVar("phase") == 3 then
            if mob:getTP() < 1000 then
                mob:setLocalVar("next_tp_move", os.time() + 2)
                return 3148
            else
                return math.random(2465, 2467)
            end
        else
            return math.random(2465, 2466)
        end
    end
end

function onMobWeaponSkill(target, mob, skill)
    -- logic from hostile herbivores: fighting sheep
    if skill:getID() == 3148 then
        mob:addTP(mob:getLocalVar("skill_tp"))
        mob:setLocalVar("skill_tp", 0)
    elseif skill:getID() == 2465 then
        mob:showText(mob, ID.text.RANK_2_PRIZE)
    elseif skill:getID() == 2466 then
        mob:showText(mob, ID.text.BOOBY_PRIZE)
    elseif skill:getID() == 2467 then
        mob:showText(mob, ID.text.CRYSTAL_PRIZE)
    end
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    mob:setLocalVar("phase", 1)
    resetRiko(mob)
end
