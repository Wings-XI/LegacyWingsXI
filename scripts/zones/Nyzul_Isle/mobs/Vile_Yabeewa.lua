------------------------------------------
-- Vile Yabeewa
-- Nyzul Isle
-- Uses Manafont
-- Some reports of fast cast? no capture
-- As per retail testing, resistant to silence
------------------------------------------
require("scripts/globals/status")
mixins = {require("scripts/mixins/job_special")}
------------------------------------------
function onMobInitialize(mob)
    mob:setMod(tpz.mod.SILENCERESTRAIT, 100)
end

function onMobDeath(mob, player, isKiller)
end