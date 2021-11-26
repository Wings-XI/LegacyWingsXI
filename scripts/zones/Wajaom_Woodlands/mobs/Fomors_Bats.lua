-----------------------------------
-- Area: Wajaom Woodlands
--  Mob: Fomor's Bats
-----------------------------------
require("scripts/globals/world")
-----------------------------------

function onMobRoam(mob)
    local totd = VanadielTOTD()

    if totd ~= tpz.time.NIGHT and totd ~= tpz.time.MIDNIGHT then
        DespawnMob(mob:getID())
    end
end

function onMobDisengage(mob)
    local totd = VanadielTOTD()

    if totd ~= tpz.time.NIGHT and totd ~= tpz.time.MIDNIGHT then
        DespawnMob(mob:getID())
    end
end

function onMobDeath(mob, player, isKiller)
end