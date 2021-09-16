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
    mob:setMobMod(tpz.mobMod.ROAM_DISTANCE, 1) -- This does not seem to actually restrict move distsnce on roam - underlying code attempts to restrict but can often miss
    mob:setMobMod(tpz.mobMod.ROAM_TURNS, 1)
    mob:setMobMod(tpz.mobMod.NO_AGGRO, 1)
end

function onMobRoam(mob)
end

function onMobFight(mob)
    -- remove aggro pause if players are fighting a mob
    local instance = mob:getInstance()
    if instance:getStage() == 0 then
        instance:setStage(1)
    end
end

function onMobWeaponSkill(target, mob, skill)
end

function onMobDespawn(mob)

end

function onMobDeath(mob, player, isKiller)
    local instance = mob:getInstance()
    instance:setProgress(instance:getProgress()+1)
end