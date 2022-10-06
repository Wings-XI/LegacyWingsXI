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
    mob:setLocalVar("wasKilled", 0)
end

function onMobRoam(mob)
    local totd = VanadielTOTD()

    if totd ~= tpz.time.NIGHT and totd ~= tpz.time.MIDNIGHT then -- Despawn if daytime
        DespawnMob(mob:getID())
    end
end

function onMobDisengage(mob)
    local totd = VanadielTOTD()

    if totd ~= tpz.time.NIGHT and totd ~= tpz.time.MIDNIGHT then -- Despawn if daytime
        DespawnMob(mob:getID())
    end
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 278)
    if isKiller == true then
        mob:setLocalVar("wasKilled", 1)
    end
end

function onMobDespawn(mob)
    if mob:getLocalVar("wasKilled") ~= 1 then
        -- force spawn on next kill of any PH
        -- hoping we don't have a race condition with the despawn listener
        -- if we do, worst case is citipati isn't preserved when 4am hits, and we trigger his 3-hour cooldown
        mob:setLocalVar("preservePop", 1)
    end
end
