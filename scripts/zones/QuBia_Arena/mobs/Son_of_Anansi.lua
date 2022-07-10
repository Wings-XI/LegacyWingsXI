-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Son of Anansi
-- BCNM: Come Into My Parlor
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:speed(60)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(tpz.mobMod.CHARMABLE, 1)
end

function onMobSpawn(mob)
    -- these will spawn upon entry and remain hidden until Anansi dies
    mob:setStatus(tpz.status.INVISIBLE)
    mob:untargetable(true)
    mob:setMobMod(tpz.mobMod.NO_AGGRO, 1)
    mob:setMobMod(tpz.mobMod.NO_LINK, 1)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
end

function onAdditionalEffect(mob, target, damage)
    -- 25% chances to poison for 60 seconds at 50 per tick
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.POISON, { power = 50, duration = 60, chance = 25 })
end

function onMobDeath(mob, killer)
end