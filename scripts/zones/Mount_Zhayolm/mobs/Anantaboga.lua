-----------------------------------
-- Area: Mount Zhayolm
--  ZNM: Anantaboga
-----------------------------------
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 4500)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 7500)
end

function onMobSpawn(mob)
    mob:setLocalVar("[rage]timer", 4500)
    mob:setMod(tpz.mod.RESBUILD_GRAVITY, 25)
    mob:setMod(tpz.mod.RESBUILD_BIND, 25)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 15)
    mob:setMod(tpz.mod.SLEEPRESTRAIT, 100)

    -- event listeners for when silence is applied/wears off
    mob:addListener("EFFECT_GAIN", "SILENCE_IS_HERE", function(mob, effect)
        if effect:getType() == tpz.effect.SILENCE then
            mob:setMobMod(tpz.mobMod.SKILL_LIST, 5298)
            mob:setMobMod(tpz.effect.REGAIN, 200)
        end
    end)

    mob:addListener("EFFECT_LOSE", "SILENCE_WAS_HERE", function(mob, effect)
        if effect:getType() == tpz.effect.SILENCE then
            mob:setMobMod(tpz.mobMod.SKILL_LIST, 298)
            mob:setMobMod(tpz.effect.REGAIN, 0)
        end
    end)
end

function onMobRoam(mob)
    -- do not delay roaming back to spawn and don't do a direct path when over 20 yalms away (in case he charms all players on hate table)
    if not mob:isFollowingPath() then
        local spawn = mob:getSpawnPos()
        mob:pathTo(spawn.x, spawn.y, spawn.z)
    end
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    -- remove listeners upon despawn
    mob:removeListener("SILENCE_IS_HERE")
    mob:removeListener("SILENCE_WAS_HERE")
end