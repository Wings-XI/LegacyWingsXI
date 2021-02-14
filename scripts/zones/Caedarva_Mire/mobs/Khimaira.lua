-----------------------------------
-- Area: Caedarva Mire
--   NM: Khimaira
-----------------------------------
require("scripts/globals/titles")
local ID = require("scripts/zones/Caedarva_Mire/IDs")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.KHIMAIRA_CARVER)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
	local respawn = math.random(172800, 259200) -- 48 to 72 hours.
    mob:setRespawnTime(respawn)
	SetServerVariable("KhimairaRespawn",(os.time() + respawn))
end
