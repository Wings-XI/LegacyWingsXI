-----------------------------------
-- Area: Jugner Forest [S]
--  Mob: Decrepit Gnole
-- Note: PH for Voirloup
-----------------------------------
mixins = {require("scripts/mixins/families/gnole")}
local ID = require("scripts/zones/Jugner_Forest_[S]/IDs")
require("scripts/globals/mobs")
-----------------------------------

function onMobDespawn(mob)
    -- Wiki and other sources do not have much information here
    -- only one comment about the mob not respawning after 4 hours of server uptime - although its unclear if they were killing PHs
    -- As such, until we can get some information - I'm going with what Lyft Scimitar, Lyft Tabar, and Lyft GAX have - 1 hour cooldown
    tpz.mob.phOnDespawn(mob, ID.mob.VOIRLOUP_PH, 20, 3600) -- 1 hour
end

function onMobDeath(mob, player, isKiller)
end
