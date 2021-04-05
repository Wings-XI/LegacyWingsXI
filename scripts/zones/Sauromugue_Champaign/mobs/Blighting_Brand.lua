-----------------------------------
-- Area: Sauromugue Champaign
--   NM: Blighting Brand
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/regimes")
-----------------------------------

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.CLAIM_SHIELD, 1)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 275)
    tpz.regime.checkRegime(player, mob, 100, 2, tpz.regime.type.FIELDS)
end
