------------------------------------------
-- Mint Custard
-- Nyzul Isle
-- Absorbs Lightning
------------------------------------------
require("scripts/globals/status")
------------------------------------------
function onMobInitialize(mob)
    mob:addMod(tpz.mod.LTNG_ABSORB, 100)
end

function onMobDeath(mob, player, isKiller)
end