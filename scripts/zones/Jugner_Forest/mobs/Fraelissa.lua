-----------------------------------
-- Area: Jugner Forest
--   NM: Fraelissa
-----------------------------------
require("scripts/globals/hunts")
local ID = require("scripts/zones/Jugner_Forest/IDs")
require("scripts/globals/mobs")
-----------------------------------

function onMobSpawn(mob)
    updateRegen(mob)
end

function onMobFight(mob)
    updateRegen(mob)
end

function onMobRoam(mob)
    updateRegen(mob)
end

function updateRegen(mob)
    local hour = VanadielHour()
    if hour >= 4 and hour < 20 then
        mob:setMod(tpz.mod.REGEN, 25)
    else
        mob:setMod(tpz.mod.REGEN, 0)
    end
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 158)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    if not tpz.mob.phOnDespawn(mob, ID.mob.FRADUBIO_PH, 10, 75600) then -- 21 hour minimum
        mob:setRespawnTime(math.random(3600, 4500)) -- 60 to 75 minutes
    end
end
