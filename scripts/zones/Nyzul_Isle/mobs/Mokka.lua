------------------------------------------
-- Mokka
-- Nyzul Isle
-- Only uses Deafening Tantara
------------------------------------------
require("scripts/globals/status")
------------------------------------------
function onMobInitialize(mob)
end

function onMobWeaponSkillPrepare(mob, target)
    return 1710 -- Deafening Tantara
end

function onMobDeath(mob, player, isKiller)
end