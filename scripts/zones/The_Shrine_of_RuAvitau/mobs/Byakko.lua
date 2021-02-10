-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Byakko (Pet version)
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobs")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onMobSpawn(mob)
    mob:setMod(tpz.mod.REGAIN, 150)
end

function onMobSpawn(mob)
	mob:setMod(tpz.mod.TRIPLE_ATTACK, 40)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENLIGHT)
end

function onMonsterMagicPrepare(mob, target)
    local rnd = math.random()
    if (rnd < 0.5) then
        return 40 -- Banishga 3
    elseif (rnd < 0.7) then
        return 31 -- Banish 4
    elseif (rnd < 0.9) then
        return 35 -- Diaga III
    else
        return 21 -- Holy
    end
    return 0 -- Still need a return, so use 0 when not casting
end

function onMobDeath(mob, player, isKiller)
end
