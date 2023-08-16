-----------------------------------
-- Area: Throne Room
--  Mob: Smash! A Malevolent Menace
-- AMK 14 fight
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
end

function onMobSpawn(mob)
end

function onMobEngaged(mob, target)
end
