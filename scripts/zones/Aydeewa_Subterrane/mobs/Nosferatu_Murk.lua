-----------------------------------
--   Area: Aydeewa Subterrane
--    Mob: Nosferatu Murk
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
end    



function onMobEngaged(mob, target)
    local mother = GetMobByID(ID.mob.NOSFERATU)
    local af = mother:getLocalVar("AF")

    if af == 1 then
        mob:useMobAbility(1111) -- Foxfire ASCAR
    else
        mob:useMobAbility(2222) -- barbed crecent ASCAR
    end

    mob:setLocalVar("time2die", os.time() + 3 )
end

function onMobFight(mob, target)
    local mobId = mob:getID()
    local death = getLocalVar("time2die")
    local now = os.time()
    if now >= death then
        DespawnMob(mobID)
    end
end

-- Death stuff
function onMobDeath(mob, player, isKiller)
    local mother = GetMobByID(ID.mob.NOSFERATU)
    mother:setLocalVar("AF", 3)
end

function onMobDespawn(mob)
    local mother = GetMobByID(ID.mob.NOSFERATU)
    mother:setLocalVar("AF", 3)
end