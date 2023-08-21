-----------------------------------
-- Area: Throne Room
--  Mob: Henchman Moogle (WHM)
-- AMK14 - Smash! A Malevolent Menace
-----------------------------------
local ID = require("scripts/zones/Throne_Room/IDs")
require("scripts/globals/status")
require("scripts/globals/titles")

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
end

function onMobSpawn(mob)
end

function onMobFight(mob, target)
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
end

