------------------------------------------
-- Mokke
-- Nyzul Isle
-- Only uses Abrasive Tantara
------------------------------------------
require("scripts/globals/status")
------------------------------------------
function onMobInitialize(mob)
end

function onMobWeaponSkillPrepare(mob, target)
    return 1709 -- Abrasive Tantara
end


function onMobDeath(mob, player, isKiller)
end