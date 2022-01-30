-----------------------------------
-- Area: Stellar Fulcrum (Ode of Life Bestowing)
--  Mob: Seed Crystal
-----------------------------------
local ID = require("scripts/zones/Stellar_Fulcrum/IDs")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 1)
    mob:setMobMod(tpz.mobMod.DRAW_IN_IGNORE_STATIONARY, 1)
    mob:setMobMod(tpz.mobMod.DRAW_IN_CUSTOM_RANGE, 6)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 70)
    mob:SetAutoAttackEnabled(false)
    mob:setMod(tpz.mod.REGAIN, 1200) -- Basic attack is a WS
    mob:addMod(tpz.mod.EVA, -50)
    mob:addMod(tpz.mod.MATT, -25)
    mob:setLocalVar("attacks", 0)
end

function onMobEngaged(mob, target)
end


function onMobFight(mob, target)
    if mob:getHPP() < 25 then
        mob:setMod(tpz.mod.REGAIN, 300) -- Since TP moves go off sooner, let's lower this
    end
end

function onMobWeaponSkillPrepare(mob, target)
    local TPchance = 0
    local skillID = 2415 -- basic aoe attack
    local attacks = mob:getLocalVar("attacks")

    -- 25% after 2 attacks, 50% after 3, 25% after 4
    if attacks == 2 then
        TPchance = 25
    elseif attacks == 3 then
        TPchance = 66
    elseif attacks >= 4 then
        TPchance = 100
    end

    -- Use a normal TP Move
    local rnd = math.random(100)
    if rnd <= TPchance then
        if mob:getHPP() > 50 then
            skillID = ({2416,2417,2418})[math.random(1,3)]
        else
            skillID = ({2416,2417,2418,2419})[math.random(1,4)] -- Access to Seed of Judgement
        end
    end

    return skillID
end

function onMobSkillFinished(mob, target, skill)
    local attacks = mob:getLocalVar("attacks")
    if skill:getID() == 2415 then
        mob:setLocalVar("attacks", attacks + 1)
    else
        mob:setLocalVar("attacks", 0)
    end
end

function onMobDeath(mob, player, isKiller)
    local mobID = mob:getID()

    for i = mobID + 1, mobID + 6 do
        local thrall = GetMobByID(i)
        if thrall:isSpawned() then
            DespawnMob(i)
        end
    end
end

function onMobDespawn(mob)
end