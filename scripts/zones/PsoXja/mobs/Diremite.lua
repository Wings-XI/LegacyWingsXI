-----------------------------------
-- Area: Pso'Xja
--  Mob: Diremite
-----------------------------------
local ID = require("scripts/zones/PsoXja/IDs")

local GyreCarlinPlaceholderSpawnPoints = {
    [0] = {x = 34.057,  z = -0.352, y = 165.306},
    [1] = {x = -12.169, z = -0.352, y = 219.675},
    [2] = {x = -48.378, z = -0.352, y = 192.539}
}
function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.GYRE_CARLIN_PH, 15, math.random(900, 1800)) -- 15-30 minute cooldown.
    if mob:getID() == 16814330 then -- PH for Gyre Carlin shifts between 3 rooms
        local position = GyreCarlinPlaceholderSpawnPoints[math.random(0,2)]
        mob:setSpawn(position.x, position.z, position.y)
    end
end
