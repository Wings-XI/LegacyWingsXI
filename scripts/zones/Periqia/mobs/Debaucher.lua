-----------------------------------
-- Area: Periqia (Seagull Grounded)
--  Mob: Debaucher
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:addImmunity(tpz.immunity.DARKSLEEP)
end

function onMobDeath(mob, player, isKiller)
end
