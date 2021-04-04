-----------------------------------
-- Area: Sacrarium
--  Mob: Mariselle's Pupil
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/status")
-----------------------------------

function onMobFight(mob, target)
    mob:setMobMod(tpz.mobMod.TELEPORT_TYPE, 1)
    mob:setMobMod(tpz.mobMod.SPAWN_LEASH, 1)
    mob:setMobMod(tpz.mobMod.TELEPORT_CD, 1)
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn( mob )
end
