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
    if (mob:getHPP() < 10) and (not (mob:getLocalVar("turnToFaceCooldown") == 5)) then
        mob:setMod(tpz.mod.REGAIN, 200)
        mob:setLocalVar("turnToFaceCooldown", 5)
    elseif (mob:getHPP() < 25) and (not (mob:getLocalVar("turnToFaceCooldown") == 10)) then
        mob:setMod(tpz.mod.REGAIN, 100)
        mob:setLocalVar("turnToFaceCooldown", 10)
    elseif (mob:getHPP() < 50) and (not (mob:getLocalVar("turnToFaceCooldown") == 15)) then
        mob:setLocalVar("turnToFaceCooldown", 15)
    elseif (mob:getHPP() < 75) and (not (mob:getLocalVar("turnToFaceCooldown") == 20)) then
        mob:setLocalVar("turnToFaceCooldown", 20)
    elseif (mob:getHPP() < 100) and (not (mob:getLocalVar("turnToFaceCooldown") == 25)) then
        mob:setLocalVar("turnToFaceCooldown", 25)
    end
    
    if (mob:getLocalVar("lastTurnToFace") + mob:getLocalVar("turnToFaceCooldown")) < os.time() then
        mob:lookAt(target:getPos())
        mob:setLocalVar("lastTurnToFace", os.time())
    end
end

function onMobDeath(mob, player, isKiller)
end
