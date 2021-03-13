-----------------------------------
-- Area: Open sea route to Al Zahbi
--  MOB: Southern Piranu
-- Note: Fishable NM
-----------------------------------
require("scripts/globals/settings");
-----------------------------------

function onMobInitialize(mob)
    mob:setLocalVar('lastTOD',os.time())
end;

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    mob:setLocalVar('lastTOD',os.time())
end
