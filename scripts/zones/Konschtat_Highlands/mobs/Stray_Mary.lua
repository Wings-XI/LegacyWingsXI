-----------------------------------
-- Area: Konschtat Highlands
--   NM: Stray Mary
-----------------------------------
local ID = require("scripts/zones/Konschtat_Highlands/IDs")
require("scripts/globals/hunts")
require("scripts/globals/titles")
require("scripts/quests/tutorial")
-----------------------------------

function onMobSpawn(mob)
    -- Disallow two Stray Marys from spawning
    if mob:getID() == ID.Konschtat_Highlands.STRAY_MARY_N then
        DisallowRespawn(ID.Konschtat_Highlands.STRAY_MARY_S, true)
    elseif mob:getID() == ID.Konschtat_Highlands.STRAY_MARY_S then
        DisallowRespawn(ID.Konschtat_Highlands.STRAY_MARY_N, true)
    end
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 203)
    player:addTitle(tpz.title.MARYS_GUIDE)
    tpz.tutorial.onMobDeath(player)

    if mob:getID() == ID.Konschtat_Highlands.STRAY_MARY_N then
        DisallowRespawn(ID.Konschtat_Highlands.STRAY_MARY_S, false)
    elseif mob:getID() == ID.Konschtat_Highlands.STRAY_MARY_S then
        DisallowRespawn(ID.Konschtat_Highlands.STRAY_MARY_N, false)
    end
end
