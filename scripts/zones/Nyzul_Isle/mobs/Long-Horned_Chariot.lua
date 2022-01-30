-----------------------------------
-- Area: Nyzul Isle
--  Mob: Long-Horned Chariot
--  Note: Uses Brainjack at lower health
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    -- attacks once per 4 seconds
    mob:setMod(tpz.mod.DELAY, 1750)
end

function onMobWeaponSkillPrepare(mob, target)
    local brainjack = 2060
    if (mob:getHPP() <= 30) and (math.random(1,4) == 1) then
        return brainjack
    elseif (mob:getHPP() <= 20) and (math.random(1,4) <= 2) then
        return brainjack
    elseif (mob:getHPP() <= 10) then
        return brainjack
    end
end

function onMobDeath(mob, player, isKiller)
end
