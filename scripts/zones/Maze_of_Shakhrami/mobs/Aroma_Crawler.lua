-----------------------------------
-- Area: Maze of Shakhrami
--  Mob: Aroma Crawler (RSE Satchets)
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.SLOW)
end

function onMobDeath(mob, player, isKiller)
end
