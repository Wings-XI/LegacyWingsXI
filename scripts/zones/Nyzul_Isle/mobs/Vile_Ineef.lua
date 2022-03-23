------------------------------------------
-- Vile Ineef
-- Nyzul Isle
-- Only uses Tribulation
-- As per retail testing, resistant to silence
------------------------------------------
require("scripts/globals/status")
------------------------------------------
function onMobInitialize(mob)
    mob:setMod(tpz.mod.SILENCERESTRAIT, 100)
end

function onMobWeaponSkillPrepare(mob, target)
    return 1967 -- Tribulation
end

function onMobDeath(mob, player, isKiller)
end