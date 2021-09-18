-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Satellite Tachi
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    -- Each Satellite Weapon has 2 different Animation Subs
    -- that will display either two or three different weapon models.
    mob:AnimationSub(math.random(21, 22))
end

function onMobDeath(mob, isKiller, player)
end
