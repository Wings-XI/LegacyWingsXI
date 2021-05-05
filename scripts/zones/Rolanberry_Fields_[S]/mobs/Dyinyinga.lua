------------------------------
-- Area: Rolanberry Fields [S]
--   NM: Dyinyinga
------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMod(tpz.mod.RESBUILD_GRAVITY, 1)
    mob:setMod(tpz.mod.RESBUILD_BIND, 1)
    mob:setMod(tpz.mod.DMGMAGIC, 25)
    -- there is some discussion that the NM will change how it tries to be ontop of its target
    -- some say its linked to slow, some say its linked to silence, in videos ive found of the NM, it seems to always try to be on top of the player
    -- so more research is needed to determine if the encroach setting should toggle
    mob:setMobMod(tpz.mobMod.ENCROACH_PLAYER, 1) 
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.SLOW,  {chance = 100, duration = 120})
end

function onMobSpawn(mob)
    updateRegen(mob)
end

function onMobFight(mob, target)
    local distance = mob:checkDistance(target)
    if(distance < 2) then
        -- This should really be an on/off effect based on distance, for now I've done the next best - creating a pulse of status effects
        MobStatusEffectMove(mob, target, tpz.effect.AMNESIA, 0, 0, 7)
        MobStatusEffectMove(mob, target, tpz.effect.SILENCE, 0, 0, 7)
    end
    updateRegen(mob)
end

function onMobRoam(mob)
    updateRegen(mob)
end

function updateRegen(mob)
    if mob:getWeather() == tpz.weather.RAIN or mob:getWeather() == tpz.weather.SQUALL then
        mob:setMod(tpz.mod.REGEN, 75) -- Noticeably high Auto Regen during rain weather.
    else
        mob:setMod(tpz.mod.REGEN, 0)
    end
end


function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 511)
end
