------------------------------------------
-- Oriri Samariri
-- Nyzul Isle
-- Unknown - wikiwiki.jp says "After begging for heaven, no chanting spirit magic"
-- Until proven otherwise treating this as Fast Cast until death after providence is used
------------------------------------------
require("scripts/globals/status")
------------------------------------------
function onMobInitialize(mob)
    mob:setMod(tpz.mod.SILENCERESTRAIT, 100)
    mob:setMod(tpz.mod.SLEEPRESTRAIT, 100)
    mob:setMod(tpz.mod.LULLABYRESTRAIT, 100)
end

function onMobSkillFinished(mob, target, skill)
    if(skill:getID() == 1961) then
        mob:setMod(tpz.mod.FASTCAST, 50)
    end
end

function onMobDeath(mob, player, isKiller)
end