-----------------------------------
-- Area: Ghoyus_Reverie
--  Mob: Yagudo Theologist
-----------------------------------
require("scripts/globals/instance")
-----------------------------------

function onMobInitialize(mob)
    mob:setMod(tpz.mod.SLEEPRES, 100) -- immune to sleep
    mob:setMod(tpz.mod.ATT, -100) -- mobs are very weak
    mob:setMod(tpz.mod.RATT, -100) 
    mob:setMod(tpz.mod.MATT, -90)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1);
    mob:setMobMod(tpz.mobMod.MUG_GIL, -1);
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100);
end

function onMobRoam(mob)
end



function onMobDespawn(mob)
    local instance = mob:getInstance()
    instance:setProgress(instance:getProgress()+1)
    mob:setSpawn(-141.111, -0.420, 163.878)
end

function onMobDeath(mob, player, isKiller)
end