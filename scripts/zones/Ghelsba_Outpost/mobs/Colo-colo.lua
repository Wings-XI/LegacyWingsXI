-----------------------------------
-- Area: Ghelsba Outpost
--  Mob: Colo-colo
-- BCNM: Wings of Fury
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:setMobMod(tpz.mobMod.SOUND_RANGE, 18)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 40)
    mob:setMobMod(tpz.mobMod.MAGIC_DELAY, 7)
end

function onMobEngaged(mob, target)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)

    -- next two mob IDs are two furies
    local mobID = mob:getID()
    for i = mobID+1, mobID+2 do
        local m = GetMobByID(i)
        if m and m:isSpawned() and m:isAlive() then
            m:updateEnmity(target)
        end
    end
end

function onMobFight(mob, target)
    if mob:getHPP() == 100 then
        mob:SetMagicCastingEnabled(false)
    else
        mob:SetMagicCastingEnabled(true)
    end
end

function onMobDeath(mob, player, isKiller)
end