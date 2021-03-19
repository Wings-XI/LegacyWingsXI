-----------------------------------
-- Area: Mount Zhayolm
--   NM: Cerberus
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/titles")
local ID = require("scripts/zones/Mount_Zhayolm/IDs")
-----------------------------------

function onMobFight(mob, target)
    if mob:getHPP() > 25 then
        mob:setMod(tpz.mod.REGAIN, 10)
    else
        mob:setMod(tpz.mod.REGAIN, 70)
    end
end

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.CERBERUS_MUZZLER)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
	local respawn = math.random(48,72)*3600 -- 48 to 72 hours in 60min windows
    mob:setRespawnTime(respawn)
	SetServerVariable("CerbRespawn",(os.time() + respawn))
end
