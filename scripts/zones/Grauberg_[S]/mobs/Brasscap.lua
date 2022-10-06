-----------------------------------
-- Area: Grauberg [S]
--  Mob: Brasscap
-- Note: Items stolen removes caps from head
-----------------------------------
require("scripts/globals/mobs")
mixins = {require("scripts/mixins/families/funguar_s")}
-----------------------------------

function onMobSpawn(mob)
    mob:AnimationSub(0)
    mob:setStealItemID(4373) -- Woozyshroom is default steal item, needed here in case first action on the mob is steal
end

function onMobInitialize(mob)
end

function onMobEngaged(mob, target)
end

function onMobFight(mob)
end

function onMobRoam(mob)
end

function onMobDisengage(mob)
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
end
