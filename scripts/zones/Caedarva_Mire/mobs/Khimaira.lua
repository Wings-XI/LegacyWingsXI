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
	local respawn = math.random(48,72)*3600 -- 48 to 72 hours in 60min windows
    mob:setRespawnTime(respawn)
	SetServerVariable("KhimairaRespawn",(os.time() + respawn))
end
