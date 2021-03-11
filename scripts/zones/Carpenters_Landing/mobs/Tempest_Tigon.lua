-----------------------------------
-- Area: Carpenters' Landing
--   NM: Tempest Tigon
-----------------------------------
require("scripts/globals/hunts")

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
	result = math.random(1,2)

    if result == 2 then
        return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENAERO, {chance = 30})
    else
        return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENWATER, {chance = 30})
    end
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 168)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(3600, 7200)) -- 1 to 2 hours
end
