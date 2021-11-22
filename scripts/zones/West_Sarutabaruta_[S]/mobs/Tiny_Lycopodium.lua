-----------------------------------
-- Area: West Sarutabaruta [S]
--  Mob: Tiny Lycopodium
-- Note: PH for Jeduah
-----------------------------------
local ID = require("scripts/zones/West_Sarutabaruta_[S]/IDs")
require("scripts/globals/mobs")
mixins = {require("scripts/mixins/families/lycopodium")}
-----------------------------------

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.ALWAYS_AGGRO, 1)
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.JEDUAH_PH, 10, 3600) -- 1 hour
end
