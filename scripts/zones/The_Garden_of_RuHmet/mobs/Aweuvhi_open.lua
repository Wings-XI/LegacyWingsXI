-----------------------------------
-- Area: The Garden of Ru'Hmet
--  Mob: Aw'euvhi
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
mixins = {require("scripts/mixins/families/euvhi")}
-----------------------------------

function onMobSpawn(mob)
    mob:AnimationSub(2)
end

function onMobDisengage(mob)
    mob:AnimationSub(2)
end

function onMobDeath(mob, player, isKiller)
end
