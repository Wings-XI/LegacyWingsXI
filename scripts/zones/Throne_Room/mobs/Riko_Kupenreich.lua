-----------------------------------
-- Area: Throne Room
--  Mob: Smash! A Malevolent Menace
-- AMK 14 fight
-----------------------------------
require("scripts/globals/status")
-----------------------------------

-- all of this is untested

local function phaseChange(mob)
    local bf = mob:getBattlefield()
    local bfArea = bf:getArea()
    local area_pos = {
        { x = -488.286, y = -172.000, z = -240.000 },
        { x = -808.666, y = -412.000, z = -479.897 },
        { x = -1126.113, y = -652.000, z = -720.000 },
    }
    mob:setLocalVar("retreated", 1)
    -- place at top of stairs based on bf instance id
    mob:pathTo(area_pos[bfArea].x, area_pos[bfArea].y, area_pos[bfArea].z)
    -- change animation, set to non-violent
    -- just sits there, doens't aggro, but attacks if get near him
    
    -- spawn blms on spot
    
    -- spawn whms up top
    for i = mob:getID() + 8, mob:getID() + 9 do
        local moogle = GetMobByID(i)
        if not moogle:isSpawned() then
            moogle:spawn()
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
            moogle:despawn()
        end
    end
end

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
end

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.ALLI_HATE, 60)
    mob:setMod(tpz.mod.UDMGPHYS, 2000)
    mob:setMod(tpz.mod.UDMGBREATH, 2000)
    mob:setMod(tpz.mod.UDMGMAGIC, 200)
    mob:setMod(tpz.mod.UDMGRANGE, 2000)
    mob:setLocalVar("phase", 1)
end

function onMobEngaged(mob, target)
    -- sets/increments phase counters
    reEngage(mob)
end

function onMobFight(mob, target)
    local bf = mob:getBattlefield()
    local phase = mob:getLocalVar("phase")

    -- give up
    if phase == 3 and mob:getHPP() < 25 then
        bf:win()
    elseif mob:getHP() / mob:getLocalVar("phaseStartHP") < 0.5 then
        -- lost 50% hp this phase
        phaseChange(mob)
    elseif mob:getHP() / mob:getLocalVar("phaseStartHP") < 0.75 then
        -- lost 25% hp this phase
        -- draw-in
        -- crystilline flare
    end
end
