-----------------------------------
-- Area: The Sanctuary of Zi'Tah
--   NM: Elusive Edwin
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onMobSpawn(mob)
    mob:setMod(tpz.mod.REGAIN, 250)
end
function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.SILENCE)
end

function onMobWeaponSkill(target, mob, skill, action)
    mob:resetEnmity(target)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 323)
end

function onMobDespawn(mob)
    mob:setRespawnTime(7200 + math.random(0, 600)) -- 2 hours, then 10 minute window
end
