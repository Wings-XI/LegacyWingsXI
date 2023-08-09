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
    mob:stun(60000)
    mob:setLocalVar("retreated", 1)
    -- place at top of stairs based on bf instance id
    -- mob:setPos()
    -- alternate pair of mobids for whm to ensure they always spawn even when completing phases quickly
    local whmBaseID = mob:getID() + (mob:getLocalVar("phase") % 2)*2 + 1
    GetMobByID(whmBaseID):spawn()
    GetMobByID(whmBaseID + 1):spawn()
    for i = mob:getID() + 5, mob:getID() + 9 do
        GetMobByID(i):spawn()
    end
end

local function reEngage(mob)
    mob:setLocalVar("phase", mob:getLocalVar("phase"))
    mob:setLocalVar("retreated", 0)
    mob:setLocalVar("phaseStartHP", mob:getHP())
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
        return
    elseif mob:getHP() / mob:getLocalVar("phaseStartHP") < 0.5 then
        -- lost 50% hp this phase
    elseif mob:getHP() / mob:getLocalVar("phaseStartHP") < 0.75 then
        -- lost 25% hp this phase
    end
end
