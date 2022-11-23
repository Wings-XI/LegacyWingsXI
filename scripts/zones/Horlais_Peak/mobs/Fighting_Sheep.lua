-----------------------------------
-- Area: Horlais Peak
--  Mob: Fighting Sheep
-- BCNM: Hostile Herbivores
-- TODO: melee attacks cause knockback.
-----------------------------------
require("scripts/globals/status")
-----------------------------------


function onMobInitialize(mob)
    mob:setMod(tpz.mod.ICERES, 75)
    mob:setMod(tpz.mod.SLEEPRES, 100)
    mob:setMod(tpz.mod.LULLABYRES, 100)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(tpz.mobMod.CHARMABLE, 0)
end

function onAdditionalEffect(mob, target, damage)
    -- 30 yalm knockback
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.KNOCKBACK, { power = 30, chance = 100 })
end

function onMobSpawn(mob)
    mob:setMod(tpz.mod.HASTE_GEAR, 5000) -- 50% haste
end


function onMobDeath(mob, player, isKiller)
end
