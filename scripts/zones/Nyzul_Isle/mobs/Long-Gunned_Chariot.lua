-----------------------------------
-- Area: Nyzul Isle
--  Mob: Long-Gunned Chariot
--  Note: Uses Homing Missile at lower health
--  Note: Homing Missile requires facing target - LGC compensates by turning to face target at intervals
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    -- attacks once per 4 seconds
    mob:setMod(tpz.mod.DELAY, 1750)
end

local function setHomingMissileTarget(mob, target)
    mob:setLocalVar("homingMainTarget", target:getID())
end

function onMobWeaponSkillPrepare(mob, target)
    local homingMissile = 2058
    if (mob:getHPP() <= 30) and (math.random(1,4) == 1) then
        setHomingMissileTarget(mob, target)
        return homingMissile
    elseif (mob:getHPP() <= 20) and (math.random(1,4) <= 2) then
        setHomingMissileTarget(mob, target)
        return homingMissile
    elseif (mob:getHPP() <= 10) then
        setHomingMissileTarget(mob, target)
        return homingMissile
    end
end

function onMobFight(mob, target)
    --mob:lookAt(target:getPos())
end

function onMobDeath(mob, player, isKiller)
end
