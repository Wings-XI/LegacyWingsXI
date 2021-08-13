-----------------------------------
-- Area: Dynamis - San d'Oria
--  Mob: Vanguard's Hecteyes
-----------------------------------
require("scripts/globals/dynamis")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    dynamis.setPetStats(mob)
    mob:setMod(tpz.mod.SLEEPRESTRAIT, 100)
    mob:setMod(tpz.mod.LULLABYRESTRAIT, 100)
end