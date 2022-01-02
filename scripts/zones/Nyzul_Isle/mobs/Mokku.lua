------------------------------------------
-- Mokku
-- Nyzul Isle
-- Per capture no exceptional resists
-- Only uses Frenetic Rip
------------------------------------------
require("scripts/globals/status")
------------------------------------------
function onMobInitialize(mob)
end

function onMobWeaponSkillPrepare(mob, target)
    return 1711 -- Frenetic Rip
end

function onMobDeath(mob, player, isKiller)
end