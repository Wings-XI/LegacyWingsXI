-----------------------------------
-- Area: Ghoyus_Reverie
--  Mob: Laa Yaku The Austere
-----------------------------------
require("scripts/globals/instance")
-----------------------------------

function onMobInitialize(mob)
    mob:setMod(tpz.mod.SLEEPRES, 100) -- immune to sleep
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1);
    mob:setMobMod(tpz.mobMod.MUG_GIL, -1);
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100);
end


function onMobDespawn(mob)
    local instance = mob:getInstance()
    instance:setStage(3)
end

function onMobDeath(mob, player, isKiller)
end