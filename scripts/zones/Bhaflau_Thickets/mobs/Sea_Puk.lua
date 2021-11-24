-----------------------------------
-- Area: Bhaflau Thickets
--  Mob: Sea Puk
-- Note: Place holder Nis Puk
-----------------------------------
local ID = require("scripts/zones/Bhaflau_Thickets/IDs")
require("scripts/globals/mobs")
mixins = {require("scripts/mixins/families/puk")}
-----------------------------------

function onMobSpawn(mob)
    mob:setMod(tpz.mod.WIND_ABSORB, 100)
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.NIS_PUK_PH, 5, 43200) -- 12 hours
end
