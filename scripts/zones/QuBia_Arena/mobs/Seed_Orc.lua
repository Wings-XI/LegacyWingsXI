-----------------------------------
-- Area: Qu'Bia Arena (Those Who Lurk in Shadows (III))
--  Mob: Seed Orc
-----------------------------------

local ID = require("scripts/zones/QuBia_Arena/IDs")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:addMod(tpz.mod.SLEEPRESTRAIT, 100)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
end

function onMobFight(mob, target)
    local quadav = GetMobByID(mob:getID() + 1)
    local yagudo = GetMobByID(mob:getID() + 2)
    local newTarget = target

    -- Assists quadav then yagudo
    if quadav:isAlive() then
        newTarget = quadav:getTarget()
    elseif yagudo:isAlive() then
        newTarget = yagudo:getTarget()
    end

    -- If the Orc's target is different then build some hate
    if newTarget ~= nil and newTarget:getID() ~= target:getID() then
        mob:addEnmity(newTarget, 0, 1000)
    end
end

function onMobDeath(mob, player, isKiller)
end
