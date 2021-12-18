------------------------------
-- Area: King Ranperres Tomb
--   NM: Ankou
------------------------------
require("scripts/globals/hunts")
local ID = require("scripts/zones/King_Ranperres_Tomb/IDs")
------------------------------

function onMobRoam(mob)
    local hour = VanadielHour()

    if hour >= 6 and hour < 18 then -- Despawn Shii if its day
        DespawnMob(mob:getID())
    end
end

function onMobDisengage(mob)
    local hour = VanadielHour()

    if hour >= 6 and hour < 18 then -- Despawn Shii if its day
        DespawnMob(mob:getID())
    end
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 176)
    mob:setLocalVar("Respawn", os.time() + 3600)
    DisallowRespawn(ID.mob.ANKOU, true)
end
