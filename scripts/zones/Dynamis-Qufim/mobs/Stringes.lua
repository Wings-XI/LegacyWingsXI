-----------------------------------
-- Area: Dynamis - Qufim
--  Mob: Stringes
-----------------------------------
mixins = {require("scripts/mixins/dynamis_dreamland")}
require("scripts/globals/dynamis")
-----------------------------------

function onMobSpawn(mob)
    dynamis.setNMStats(mob)
end