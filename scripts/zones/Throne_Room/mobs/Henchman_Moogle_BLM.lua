-----------------------------------
-- Area: Throne Room
--  Mob: Henchman Moogle (BLM)
-- AMK14 - Smash! A Malevolent Menace
-----------------------------------
local ID = require("scripts/zones/Throne_Room/IDs")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
end

function onMobSpawn(mob)
    -- "During this fight, most sources will inflict roughly threefold damage to all targets"
    mob:setMod(tpz.mod.UDMGPHYS, 200)
    mob:setMod(tpz.mod.UDMGBREATH, 200)
    mob:setMod(tpz.mod.UDMGMAGIC, 200)
    mob:setMod(tpz.mod.UDMGRANGE, 200)
end

function onMobFight(mob, target)
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
end

