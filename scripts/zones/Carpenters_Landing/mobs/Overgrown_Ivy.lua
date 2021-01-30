-----------------------------------
-- Area: Carpenters_Landing
--  Mob: Overgrown Ivy
-----------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.MULTI_HIT, 3)
    mob:addMod(tpz.mod.REGAIN, 50)
end

function onMobDeath(mob, player, isKiller)
    if (player:getCurrentMission(COP) == tpz.mission.id.cop.THE_ROAD_FORKS and player:getCharVar("EMERALD_WATERS_Status") == 4) then
        player:setCharVar("EMERALD_WATERS_Status", 5)
    end
end
