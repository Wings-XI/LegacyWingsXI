-----------------------------------
-- Area: Maze of Shakhrami
--   NM: Argus
-----------------------------------
local ID = require("scripts/zones/Maze_of_Shakhrami/IDs")
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobSpawn(mob)
    mob:setMobMod(72, 1)
end

function onMobDespawn(mob)
    local respawnTime = math.random(64800,108000) -- 18-30 hours
	
	if math.random(2) == 1 then
        DisallowRespawn(ID.mob.LEECH_KING, true)
        DisallowRespawn(ID.mob.ARGUS, false)
        UpdateNMSpawnPoint(ID.mob.ARGUS)
        GetMobByID(ID.mob.ARGUS):setRespawnTime(respawnTime)
    else
        DisallowRespawn(ID.mob.ARGUS, true)
        DisallowRespawn(ID.mob.LEECH_KING, false)
        UpdateNMSpawnPoint(ID.mob.LEECH_KING)
        GetMobByID(ID.mob.LEECH_KING):setRespawnTime(respawnTime)
    end
	
	SetServerVariable("ArgusRespawn",(os.time() + respawnTime))
end
