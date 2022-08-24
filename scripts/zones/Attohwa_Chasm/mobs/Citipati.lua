-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Citipati
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/world")
local ID = require("scripts/zones/Attohwa_Chasm/IDs")

function onMobSpawn(mob)
    mob:setMod(tpz.mod.TRIPLE_ATTACK, 20)
    mob:setMobMod(tpz.mobMod.CLAIM_SHIELD, 1)
end

function onMobRoam(mob)
    local totd = VanadielTOTD()

    if totd ~= tpz.time.NIGHT and totd ~= tpz.time.MIDNIGHT then -- Despawn Citipati if its day
        DespawnMob(mob:getID())
        -- force spawn on next spawn of a random PH
        local randomCorseID = 16806155
        tpz.mob.phOnDespawn(GetMobByID(randomCorseID), ID.mob.CITIPATI_PH, 100, 0, 1)
        printf("Citipati spawning when mobid %u spawns", randomCorseID)
    end
end

function onMobDisengage(mob)
    local totd = VanadielTOTD()

    if totd ~= tpz.time.NIGHT and totd ~= tpz.time.MIDNIGHT then -- Despawn Citipati if its day
        DespawnMob(mob:getID())
        -- force spawn on next spawn of a random PH
        local randomCorseID = 16806155
        tpz.mob.phOnDespawn(GetMobByID(randomCorseID), ID.mob.CITIPATI_PH, 100, 0, 1)
        printf("Citipati spawning when mobid %u spawns", randomCorseID)
    end
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 278)
end

function onMobDespawn(mob)
end