-----------------------------------
-- Area: Mamook
--  Mob: Puk
-----------------------------------
local ID = require("scripts/zones/Mamook/IDs")
mixins = {require("scripts/mixins/families/puk")}
-----------------------------------

function onMobSpawn(mob)
    mob:setMod(tpz.mod.WIND_ABSORB, 100)
end

function onMobDeath(mob, player, isKiller)
end