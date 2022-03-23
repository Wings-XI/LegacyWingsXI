------------------------------------------
-- Eriri Samariri
-- Nyzul Isle
-- Only uses Frog Song
------------------------------------------
require("scripts/globals/status")
------------------------------------------
function onMobInitialize(mob)
    mob:setMod(tpz.mod.SILENCERESTRAIT, 100)
    mob:setMod(tpz.mod.SLEEPRESTRAIT, 100)
    mob:setMod(tpz.mod.LULLABYRESTRAIT, 100)
end

function onMobWeaponSkillPrepare(mob, target)
    return 1957 -- Frog Song
end

function onMobDeath(mob, player, isKiller)
end