------------------------------
-- Area: Rolanberry Fields
--   NM: Black Triple Stars
------------------------------
require("scripts/globals/hunts")
require("scripts/globals/world")
------------------------------

function onMobRoam(mob)
    local hour = VanadielHour()

    if hour >= 6 and hour < 18 then -- Despawn if its day
        DespawnMob(mob:getID())
    end
end

function onMobDisengage(mob)
    local hour = VanadielHour()

    if hour >= 6 and hour < 18 then -- Despawn if its day
        DespawnMob(mob:getID())
    end
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 215)
end
