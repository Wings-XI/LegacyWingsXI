-----------------------------------
-- Area: Ruhotz Silvermines
--  Mob: Sapphire Quadav
-----------------------------------
mixins =
{
    require("scripts/mixins/job_special")
}
require("scripts/globals/instance")
require("scripts/globals/pathfind")
-----------------------------------

local pathNodes =
{
    -1.279, 1.016, 40.152,
    -2.279, 1.016, 35.152,
    -15.023, 1.201, 47.723,
    -30.27, 0.437, 55.10,
    -38.11, 0.980, 36.33,
}

function onMobInitialize(mob)
    mob:setMod(tpz.mod.SLEEPRESTRAIT, 95) -- very resistant to sleep silence bind and grav
    mob:setMod(tpz.mod.SILENCERESTRAIT, 95)
    mob:setMod(tpz.mod.BINDRESTRAIT, 95)
    mob:setMod(tpz.mod.GRAVITYRESTRAIT, 95)
    mob:setMod(tpz.mod.LULLABYRESTRAIT, 95)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.MUG_GIL, -1)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.NO_AGGRO, 1)
end

function onMobRoam(mob)
    if mob:isFollowingPath() == false then
        mob:pathThrough(tpz.path.fromStart(pathNodes))
    end
end

function onMobSpawn(mob)
    
    onMobRoam(mob)
end

function onPath(mob)
    tpz.path.patrol(mob, pathNodes)
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
    instance:setStage(2)
end