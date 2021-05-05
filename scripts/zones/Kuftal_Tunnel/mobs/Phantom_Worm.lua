-----------------------------------
-- Area: Kuftal Tunnel
--   NM: Phantom Worm
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 1800)
end

function onMobSpawn(mob)
    mob:addMod(tpz.mod.REGEN, 25)
end

function onMobDeath(mob, player, isKiller)
    GetNPCByID(ID.npc.PHANTOM_WORM_QM):updateNPCHideTime(900)
end
