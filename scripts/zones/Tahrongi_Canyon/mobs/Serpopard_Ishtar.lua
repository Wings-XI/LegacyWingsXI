------------------------------
-- Area: Tahrongi Canyon
--   NM: Serpopard Ishtar
------------------------------
local ID = require("scripts/zones/Tahrongi_Canyon/IDs")
require("scripts/globals/hunts")
------------------------------

function onMobSpawn(mob)
    -- Disallow two Serpopard Ishtar from spawning
    if mob:getID() == ID.Tahrongi_Canyon.SERPOPARD_ISHTAR_N then
        DisallowRespawn(ID.Tahrongi_Canyon.SERPOPARD_ISHTAR_S, true)
    elseif mob:getID() == ID.Tahrongi_Canyon.SERPOPARD_ISHTAR_S then
        DisallowRespawn(ID.Tahrongi_Canyon.SERPOPARD_ISHTAR_N, true)
    end
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 257)

    if mob:getID() == ID.Tahrongi_Canyon.SERPOPARD_ISHTAR_N then
        DisallowRespawn(ID.Tahrongi_Canyon.SERPOPARD_ISHTAR_S, false)
    elseif mob:getID() == ID.Tahrongi_Canyon.SERPOPARD_ISHTAR_S then
        DisallowRespawn(ID.Tahrongi_Canyon.SERPOPARD_ISHTAR_N, false)
    end
end