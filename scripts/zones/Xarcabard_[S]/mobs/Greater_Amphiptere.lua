-----------------------------------
-- Area: Xarcabard [S]
--  Mob: Greater Amphiptere
-----------------------------------
mixins = {require("scripts/mixins/families/amphiptere")}
require("scripts/globals/status")
require("scripts/globals/pathfind")
-----------------------------------

local path1 = {
    205, -30, -211,
    154, -30, -187,
    105, -30, -158,
    50, -30, -111,
    12, -30, -110,
    -22, -30, -130,
    -40, -30, -80,
    60, -30, -62,
    134, -30, -72,
    181, -30, -157,
}

local path2 = {
    327, -30, 206,
    303, -30, -88,
    360, -30, -63,
    461, -30, 67,
    389, -30, -87,
    424, -30, -186,
    342, -30, -275,
    246, -30, -216,
}

local path3 = {
    -299, -35, -18,
    -292, -35 ,117,
    -181, -35, 108,
    -196, -35, -63,
    -257, -35, -118,
    -278, -35, -50,
    -291, -35, 10,
    -315, -35, -63,
    -330, -35, -10,
    -382, -35, 22,
}

function onPath(mob)
    local mobID = mob:getID()
    if mobID == 17338587 then
        tpz.path.patrolsimple(mob, path1, tpz.path.flag.RUN)
    elseif mobID == 17338586 then
        tpz.path.patrolsimple(mob, path2, tpz.path.flag.RUN)
    elseif mobID == 17338588 then
        tpz.path.patrolsimple(mob, path3, tpz.path.flag.RUN)
    end
end

function onMobSpawn(mob)
    onPath(mob)
end

function onMobRoam(mob)
    onPath(mob)
end

function onMobDeath(mob, player, isKiller)
    mob:setRespawnTime(3600)
end
