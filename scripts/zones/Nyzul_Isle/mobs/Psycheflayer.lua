------------------------------------------
-- Psycheflayer
-- Nyzul Isle
-- As per retail testing, resistant to silence
------------------------------------------
require("scripts/globals/status")
------------------------------------------
function onMobInitialize(mob)
    mob:setMod(tpz.mod.SILENCERESTRAIT, 100)
end

function onMobDeath(mob, player, isKiller)
end