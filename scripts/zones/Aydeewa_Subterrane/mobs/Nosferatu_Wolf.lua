-----------------------------------
--   Area: Aydeewa Subterrane
--    Mob: Nosferatu Wolf
-- Author: Spaceballs
--   Note: Pet of Nosferatu
-----------------------------------

-- Mob should spawn, use TP move (single target if regular spawn, AoE is astral flow), then despawn.

mixins = {
    require("scripts/mixins/job_special"),
    require("scripts/globals/status")
}
local ID = require("scripts/zones/Aydeewa_Subterrane/IDs")

function onMobSpawn(mob)
    mob:SetAutoAttackEnabled(false)
    mob:setLocalVar("time2die", os.time() + 6 )
    mob:setLocalVar("ws", os.time() + 2 )
    mob:setLocalVar("hit", 0 )
end    

function onMobFight(mob, target)
    if os.time() >= mob:getLocalVar("time2die") then
        DespawnMob(mob:getID())
    end
    if os.time() >=mob:getLocalVar("ws") and mob:getLocalVar("hit") == 0 then
        if mob:getLocalVar("AF") == 1 then
            mob:useMobAbility(470) -- methane breath ASCAR
        else
            mob:useMobAbility(468) -- Dirty claw ASCAR
        end
        mob:setLocalVar("hit", 1 )
    end
end

-- Death stuff
function onMobDeath(mob, player, isKiller)
    if mob:getLocalVar("AF") == 1 then
        GetMobByID(ID.mob.NOSFERATU):setLocalVar("AF", 3)
        mob:setLocalVar("AF", 0) 
    end
end

function onMobDespawn(mob)
    if mob:getLocalVar("AF") == 1 then
        GetMobByID(ID.mob.NOSFERATU):setLocalVar("AF", 3)
        mob:setLocalVar("AF", 0) 
    end
end