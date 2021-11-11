-----------------------------------
-- Area: Stellar Fulcrum (Ode of Life Bestowing)
--  Mob: Seed Thrall
-----------------------------------
local ID = require("scripts/zones/Stellar_Fulcrum/IDs")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
end

function onMobDeath(mob, player, isKiller)
    if isKiller then
        DespawnMob(mob:getID())
    end
end