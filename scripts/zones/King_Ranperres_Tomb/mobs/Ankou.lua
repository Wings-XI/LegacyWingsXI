------------------------------
-- Area: King Ranperres Tomb
--   NM: Ankou
------------------------------
require("scripts/globals/hunts")
local ID = require("scripts/zones/King_Ranperres_Tomb/IDs")
------------------------------

function onMobRoam(mob)
end

function onMobDisengage(mob)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 176)
end
