-----------------------------------
-- Area: Chamber of Oracles
--  Mob: Goblin Enforcer
-- BCNM: Roar! A Cat Burglar Bares Her Fangs
-----------------------------------
require("scripts/globals/status")
local ID = require("scripts/zones/Chamber_of_Oracles/IDs")
-----------------------------------
function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setMod(tpz.mod.SLEEPRES, 50)
    mob:setMod(tpz.mod.LULLABYRES, 50)
end

function onMobEngaged(mob, target)
end

function onMobFight(mob, target)
end

function onMobWeaponSkill(target, mob, skill)
end

function onMobDeath(mob, player, isKiller)
end
