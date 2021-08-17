-----------------------------------
-- Area: Leujaoam Sanctum (Leujaoam Cleansing)
--  Mob: Leujaoam Worm
-- Immune to Charm, strong to Magical Attacks
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
end

function onMobDeath(mob, player, isKiller)
    local instance = mob:getInstance()
    instance:setProgress(instance:getProgress() + 1)
end

function onMobDespawn(mob)
end
