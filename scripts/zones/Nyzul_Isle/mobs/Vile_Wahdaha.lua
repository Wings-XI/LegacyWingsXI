------------------------------------------
-- Vile Wahdaha
-- Nyzul Isle
-- Only uses Deafening Tantara
-- Unknown to have any special behaviors at this time.
-- One site randomly mentions something about using Immortal skills a lot? - http://blog.livedoor.jp/tikrit/archives/50576040.html
------------------------------------------
require("scripts/globals/status")
------------------------------------------
function onMobInitialize(mob)
    mob:setMod(tpz.mod.SILENCERESTRAIT, 100)
end

function onMobWeaponSkillPrepare(mob, target)
    if (math.random(1,2)) then
        return 1968 -- Immortal Anathema?
    end
end

function onMobDeath(mob, player, isKiller)
end