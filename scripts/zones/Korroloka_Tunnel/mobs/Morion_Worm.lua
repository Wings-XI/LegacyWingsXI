-----------------------------------
-- Area: Korroloka Tunnel (173)
--  Mob: Morion Worm
-----------------------------------
local ID = require("scripts/zones/Korroloka_Tunnel/IDs")
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 1800)
end

function onMobSpawn(mob)
    mob:addMod(tpz.mod.REGEN, 1)
end

function onMobDeath(mob, player, isKiller)
    -- Once Morion Worm is killed, the ??? may not reset for up to 15 minutes.
    GetNPCByID(ID.npc.MORION_WORM_QM):updateNPCHideTime(math.random(300, 900))
end
