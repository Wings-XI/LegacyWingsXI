-----------------------------------
-- Area: Ilrusi Atoll
--  Mob: Cursed Chest
-----------------------------------
local ID = require("scripts/zones/Ilrusi_Atoll/IDs")
require("scripts/globals/status")
require("scripts/globals/assault")
-----------------------------------

function onMobSpawn(mob)
    printf("onMobSpawn")
    mob:setMobMod(tpz.mobMod.SOUND_RANGE, 2)
    mob:setStatus(tpz.status.NORMAL)
    --mob:hideName(true)
    -- mob:setLocalVar("despawn", 0)
end

function onMobEngaged(mob, target)
    mob:setStatus(1)
    mob:hideName(false)
    mob:setModelId(258)
    mob:AnimationSub(0)
end

function onMobFight(mob, target)
    if mob:AnimationSub() ~= 1 then
        mob:AnimationSub(1)
    end

    if mob:checkDistance(target) < 22 then
        mob:setMobMod(tpz.mobMod.DRAW_IN, 3)
        mob:setLocalVar("despawn", 0)
    else
        mob:setMobMod(tpz.mobMod.DRAW_IN, 0)
        if mob:getLocalVar("despawn") == 0 then
            mob:setLocalVar("despawn", os.time() + 30)
        end
    end

    if mob:getLocalVar("despawn") ~= 0 then
        if mob:getLocalVar("despawn") < os.time() then
            mob:setStatus(tpz.status.NORMAL)
            mob:disengage()
            mob:AnimationSub(0)
            mob:setHP(mob:getMaxHP())
            mob:setModelId(960)
            mob:hideName(true)
        end
    end
end

function onMobDespawn(mob)
end

function onMobDeath(mob, player, isKiller)
end
