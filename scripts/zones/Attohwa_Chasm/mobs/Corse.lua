-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Corse
-- Note: PH for Citipati
-----------------------------------
local ID = require("scripts/zones/Attohwa_Chasm/IDs")
require("scripts/globals/mobs")

function onMobSpawn(mob)
    mob:setLocalVar("wasKilled", 0)
end

function onMobRoam(mob)
end

function onMobDisengage(mob)
end

function onMobDeath(mob, player, isKiller)
    -- WINGSTODO Fix upstream
    if isKiller == true then
        mob:setLocalVar("wasKilled", 1)
    end
end

function onMobDespawn(mob)
    -- only trigger PH check if a player killed mob, not on daytime despawn
    -- WINGSTODO Fix upstream
    if mob:getLocalVar("wasKilled") == 1 then
        tpz.mob.phOnDespawn(mob, ID.mob.CITIPATI_PH, 20, 10800) -- 3 Hours
    end
end
