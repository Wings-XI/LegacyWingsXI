-----------------------------------
-- Area: Kuftal Tunnel
--  MOB: Devil Manta
-- Note: Fishable NM
-----------------------------------
require("scripts/globals/settings");
-----------------------------------

function onMobInitialize(mob)
    mob:setLocalVar('lastTOD', os.time())
end;

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    mob:setLocalVar('lastTOD', os.time())
end
