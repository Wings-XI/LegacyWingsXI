-----------------------------------
-- Area: Sauromugue Champaign [S]
--  Mob: Sandworm
-- Note:  Title Given if Sandworm does not Doomvoid
-----------------------------------
require("scripts/globals/titles")
-----------------------------------

function onMobSpawn(mob)
    DespawnMob(mob:getID())
end

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.SANDWORM_WRANGLER)
end
