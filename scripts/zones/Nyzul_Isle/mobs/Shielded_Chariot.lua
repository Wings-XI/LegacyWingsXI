-----------------------------------
-- Area: Nyzul Isle
--  Mob: Shielded Chariot
--  Note: Uses Mortal Revolution at lower health
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    -- attacks once per 4 seconds
    mob:setMod(tpz.mod.DELAY, 1750)
end

function onMobWeaponSkillPrepare(mob, target)
    local mortalRevolution = 2057
    if (mob:getHPP() <= 30) and (math.random(1,4) == 1) then
        return mortalRevolution
    elseif (mob:getHPP() <= 20) and (math.random(1,4) <= 2) then
        return mortalRevolution
    elseif (mob:getHPP() <= 10) then
        return mortalRevolution
    end
end

function onMobDeath(mob, player, isKiller)
end
