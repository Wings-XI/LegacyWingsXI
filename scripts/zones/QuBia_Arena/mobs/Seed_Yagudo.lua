-----------------------------------
-- Area: Qu'Bia Arena (Those Who Lurk in Shadows (III))
--  Mob: Seed Yagudo
-----------------------------------

local ID = require("scripts/zones/QuBia_Arena/IDs")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:addMod(tpz.mod.LULLABYRES, 80)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
end

function onMobDeath(mob, player, isKiller)
end
