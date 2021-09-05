-----------------------------------
-- Area: Dragons Aery
--  Mob: Darter
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ALLI_HATE, 30) -- 30 yalm distance
end

function onMobDeath(mob, player, isKiller)
end
