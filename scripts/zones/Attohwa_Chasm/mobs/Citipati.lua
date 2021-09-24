-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Citipati
-----------------------------------
require("scripts/globals/hunts")
local ID = require("scripts/zones/Attohwa_Chasm/IDs")

function onMobSpawn(mob)
    mob:setMod(tpz.mod.TRIPLE_ATTACK, 20)
    mob:setMobMod(tpz.mobMod.CLAIM_SHIELD, 1)
end

function onMobRoam(mob)
    local totd = VanadielTOTD()

    if totd ~= 1 and totd ~= 7 then -- Despawn Citipati if its day
        DespawnMob(mob:getID())
    end
end

function onMobDisengage(mob)
    local totd = VanadielTOTD()

    if totd ~= 1 and totd ~= 7 then -- Despawn Citipati if its day
        DespawnMob(mob:getID())
    end
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 278)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    SetServerVariable("CitipatiRespawn",(os.time() + 10800))
    DisallowRespawn(mob:getID(), true)
end