-----------------------------------
-- Area: Leujaoam Sanctum (Leujaoam Cleansing)
--  Mob: Leujaoam Worm
-- Immune to Charm, strong to Magical Attacks
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    -- TODO: mob:setMod(tpz.mod.UDMGMAGIC, -50)
    mob:addMod(tpz.mod.DEF, 100)
    --mob:setMobMod(tpz.mobMod.MAGIC_STANDBACK, 1) -- TODO: Only will cast when out of combat range
    --mob:setMobMod(tpz.mobMod.STANDBACK_COOL, 15) -- TODO: Doesn't work
end

function onMobDeath(mob, player, isKiller)
    local instance = mob:getInstance()
    instance:setProgress(instance:getProgress() + 1)
end

function onMobDespawn(mob)
end
