---------------------------------------
-- Area: Buburimu Peninsula
--  Mob: Puffer Pugil
--   ID: 17261040
-- !pos: -87 19.5 -330
--
-- Involved in quest: Brigand's Chart
---------------------------------------

require("scripts/globals/regimes")
local buburimuID = require("scripts/zones/Buburimu_Peninsula/IDs")

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 62, 1, tpz.regime.type.FIELDS)
end

function onMobSpawn(mob)
    if mob:getID() == buburimuID.mob.PUFFER_PUGIL then
        mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
        mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
        mob:setMobMod(tpz.mobMod.CHARMABLE, 0)
        mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    end
end

