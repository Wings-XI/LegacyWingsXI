-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Corse
-- Note: PH for Citipati
-----------------------------------
local ID = require("scripts/zones/Attohwa_Chasm/IDs")
require("scripts/globals/mobs")

function onMobSpawn(mob)
    mob:setLocalVar("corseWasKilled", 0)
end

function onMobDeath(mob, player, isKiller)
    if isKiller == true then
        mob:setLocalVar("corseWasKilled", 1)
    end
end

function onMobDespawn(mob)
    -- only trigger PH check if a player killed mob, not on daytime despawn
    if mob:getLocalVar("corseWasKilled") == 1 then
        tpz.mob.phOnDespawn(mob, ID.mob.CITIPATI_PH, 80, 10800) -- 3 Hours
        printf("mob was killed")
    end
end
