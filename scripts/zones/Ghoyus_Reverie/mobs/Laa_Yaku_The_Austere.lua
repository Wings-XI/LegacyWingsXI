-----------------------------------
-- Area: Ghoyus_Reverie
--  Mob: Laa Yaku The Austere
-----------------------------------
require("scripts/globals/instance")
-----------------------------------

function onMobInitialize(mob)
    mob:setMod(tpz.mod.SLEEPRESTRAIT, 100) -- immune to sleep
    mob:setMod(tpz.mod.LULLABYRESTRAIT, 100)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1);
    mob:setMobMod(tpz.mobMod.MUG_GIL, -1);
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100);
    mob:setMod(tpz.mod.UDMGMAGIC, 50) -- takes 50% additional elemental dmg.  For now, modeled as 50% magical dmg.
end


function onMobDespawn(mob)
    local instance = mob:getInstance()
    instance:setStage(3)
end

function onMobDeath(mob, player, isKiller)
end