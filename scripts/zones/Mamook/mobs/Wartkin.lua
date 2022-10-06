-----------------------------------
-- Area: Mamook
--   NM: Wartkin (T2 ZNM minions)
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 30)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onMobSpawn(mob)
end

function onMobFight( mob, target )
    if mob:getBattleTime() == 30 then
        DespawnMob(mob:getID())
    end
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.POISON, {power = 50})
end

function onMobDeath(mob, player, isKiller)
end