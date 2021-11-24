-----------------------------------
-- Area: Mamook
--  Mob: Sea Puk
-----------------------------------
local ID = require("scripts/zones/Wajaom_Woodlands/IDs")
mixins = {require("scripts/mixins/families/puk")}
-----------------------------------

function onMobSpawn(mob)
    mob:setMod(tpz.mod.WIND_ABSORB, 100)
end

function onMobDeath(mob, player, isKiller)
end