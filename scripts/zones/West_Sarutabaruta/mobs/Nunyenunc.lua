-----------------------------------
-- Area: West Sarutabaruta (115)
--   NM: Nunyenunc
-----------------------------------
require("scripts/globals/hunts")

function onMobSpawn(mob)
    mob:setMod(tpz.mod.LIGHTRES, 50)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 251)
end
