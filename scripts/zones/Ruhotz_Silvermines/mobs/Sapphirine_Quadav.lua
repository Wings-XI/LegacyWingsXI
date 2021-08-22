-----------------------------------
-- Area: Ruhotz Silvermines
--  Mob: Sapphirine Quadav
-----------------------------------
require("scripts/globals/instance")
-----------------------------------

function onMobInitialize(mob)
    mob:setMod(tpz.mod.SLEEPRESTRAIT, 95) -- very resistant to sleep silence bind and grav
    mob:setMod(tpz.mod.SILENCERESTRAIT, 95)
    mob:setMod(tpz.mod.BINDRESTRAIT, 95)
    mob:setMod(tpz.mod.GRAVITYRESTRAIT, 95)
    mob:setMod(tpz.mod.LULLABYRESTRAIT, 95)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.MUG_GIL, -1)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setTrueDetection(1)
end

function onMobRoam(mob)
end

function onMobFight(mob)
end

function onMobWeaponSkill(target, mob, skill)
end

function onMobDespawn(mob)
end

function onMobDeath(mob, player, isKiller)
    local instance = mob:getInstance()
    instance:setProgress(instance:getProgress()+1)
end