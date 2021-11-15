-----------------------------------
-- Area: Periqia (Shades of Vengeance)
--  Mob: K23H1-LAMIA
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ROAM_DISTANCE, 10, 1) 
    mob:setMobMod(tpz.mobMod.ROAM_TURNS, 1, 1)
    mob:setMobMod(tpz.mobMod.ROAM_COOL, 20, 1)
    mob:setMobMod(tpz.mobMod.ROAM_RATE, 15, 1)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.MUG_GIL, -1)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMod(tpz.mod.LULLABYRESTRAIT, 95)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.POISON, {power = 80, duration = 30, chance = 100})
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    local instance = mob:getInstance()
    local progress = 1
    instance:setProgress(instance:getProgress() + progress)
end
