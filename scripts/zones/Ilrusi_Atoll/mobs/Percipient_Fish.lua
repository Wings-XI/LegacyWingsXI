-----------------------------------
-- Area: Ilrusi Atoll
--  Mob: Percipient Fish
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.SOUND_RANGE, 4)
end

function onMobDeath(mob, player, isKiller)
end
