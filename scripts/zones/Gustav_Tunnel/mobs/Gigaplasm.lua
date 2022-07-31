-----------------------------------
-- Area: Gustav Tunnel
--   NM: Gigaplasm
-- Note: Part of mission "The Salt of the Earth"
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
    mob:addMod(tpz.mod.DELAY, 500)
end

function onMobDeath(mob, player, isKiller)
    if (isKiller) then
        local mobId = mob:getID()
        local x = mob:getXPos()
        local y = mob:getYPos()
        local z = mob:getZPos()

        SpawnMob(mobId + 1):setPos(x, y, z)
        SpawnMob(mobId + 2):setPos(x-1, y, z-1)
        -- Mobs are supposed to spawn unclaimed with no aggro
        --GetMobByID(mobId + 1):updateEnmity(player)
        --GetMobByID(mobId + 2):updateEnmity(player)
    end
end
