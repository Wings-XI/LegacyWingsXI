------------------------------
-- Area: Rolanberry Fields
--   NM: Eldritch Edge
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.CLAIM_SHIELD, 1)
end

function onMobFight(mob, target)
    local rageTime = mob:getLocalVar("RageTimer")

    if os.time() >= rageTime then
        local timer = os.time() + math.random(10,15)
        mob:useAbility(397)
        mob:setLocalVar("RageTimer", timer)
    end
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 218)
end
