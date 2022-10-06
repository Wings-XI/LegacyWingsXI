-----------------------------------
-- Area: Gustav Tunnel
--   NM: Nanoplasm
-- Note: Part of mission "The Salt of the Earth"
-----------------------------------
local ID = require("scripts/zones/Gustav_Tunnel/IDs")
require("scripts/globals/missions")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
    mob:addMod(tpz.mod.DELAY, 150)
    mob:addMod(tpz.mod.DMGMAGIC, 400)
end

function onMobDeath(mob, player, isKiller)
    if (player:getCurrentMission(BASTOK) == tpz.mission.id.bastok.THE_SALT_OF_THE_EARTH and player:getCharVar("BASTOK91") == 2) then
        player:setCharVar("BASTOK91", 3)
    end
end
