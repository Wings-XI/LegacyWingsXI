-----------------------------------
-- Area: VeLugannon Palace
--  Mob: Detector
-----------------------------------
local ID = require("scripts/zones/VeLugannon_Palace/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/regimes")
-----------------------------------

SC_DETECTOR_PATHS = 
{
    ISLAND1 =
    {
        a = 
        {
            410, 16, -20,
            423, 16, -20,
            430, 16, -25,
            446, 16, -36,
            459, 16, -26,
            460, 16, -6,
            460, 16, 19,
            414, 16, 21,
            395, 16, 39,
            380, 16, 26,
            380, 16, 2,
            380, 16, -19,
        },
        b = 
        {
            380, 16, -19,
            380, 16, 2,
            380, 16, 26,
            395, 16, 39,
            414, 16, 21,
            460, 16, 19,
            460, 16, -6,
            459, 16, -26,
            446, 16, -36,
            430, 16, -25,
            423, 16, -20,
            410, 16, -20,
        },
    },
    ISLAND2 = 
    {
        a = 
        {
            379, 16, 301,
            378, 16, 339,
            333, 16, 340,
            322, 16, 353,
            303, 16, 350,
            299, 16, 336,
            299, 16, 308,
            307, 16, 300,
            348, 16, 300,
            379, 16, 301,
        },
        b =
        {
            379, 16, 301,
            348, 16, 300,
            307, 16, 300,
            299, 16, 308,
            299, 16, 336,
            303, 16, 350,
            322, 16, 353,
            333, 16, 340,
            378, 16, 339,
            379, 16, 301,
        },
    },
    ISLAND3 =
    {
        a =
        {
            399, 16, 37,
            381, 16, 28,
            380, 16, 6,
            380, 16, -19,
            401, 16, -20,
            424, 16, -20,
        },
        b =
        {
            424, 16, -20,
            401, 16, -20,
            380, 16, -19,
            380, 16, 6,
            381, 16, 28,
            399, 16, 37,
        },
    },
    ISLAND4 =
    {
        a = 
        {
            -362, 16, 317,
            -346, 16, 300,
            -327, 16, 300,
            -306, 16, 300,
            -300, 16, 310,
            -299, 16, 339,
            -300, 16, 371,
            -309, 16, 380,
            -340, 16, 379,
            -373, 16, 379,
            -380, 16, 370,
            -379, 16, 334,
            -362, 16, 317,
        },
        b = 
        {
            -362, 16, 317,
            -379, 16, 334,
            -380, 16, 370,
            -373, 16, 379,
            -340, 16, 379,
            -309, 16, 380,
            -300, 16, 371,
            -299, 16, 339,
            -300, 16, 310,
            -306, 16, 300,
            -327, 16, 300,
            -346, 16, 300,
            -362, 16, 317,
        }
    }
}

function onMobSpawn(mob)
    onMobRoam(mob)
    mob:setLocalVar("petCount", 1)
end

function onPath(mob)
    local mobId = mob:getID()
    if mobId == ID.mob.SC_DETECTORS.DET1 then
        tpz.path.patrol(mob, SC_DETECTOR_PATHS.ISLAND1.a)
    elseif mobId == ID.mob.SC_DETECTORS.DET2 then
        tpz.path.patrol(mob, SC_DETECTOR_PATHS.ISLAND1.b)
    elseif mobId == ID.mob.SC_DETECTORS.DET3 then
        tpz.path.patrol(mob, SC_DETECTOR_PATHS.ISLAND2.a)
    elseif mobId == ID.mob.SC_DETECTORS.DET4 then
        tpz.path.patrol(mob, SC_DETECTOR_PATHS.ISLAND2.b)
    elseif mobId == ID.mob.SC_DETECTORS.DET5 then
        tpz.path.patrol(mob, SC_DETECTOR_PATHS.ISLAND3.a)
    elseif mobId == ID.mob.SC_DETECTORS.DET6 then
        tpz.path.patrol(mob, SC_DETECTOR_PATHS.ISLAND3.b)
    elseif mobId == ID.mob.SC_DETECTORS.DET7 then
        tpz.path.patrol(mob, SC_DETECTOR_PATHS.ISLAND4.a)
    elseif mobId == ID.mob.SC_DETECTORS.DET8 then
        tpz.path.patrol(mob, SC_DETECTOR_PATHS.ISLAND4.b)
    end
end

function onMobRoam(mob)
    local mobId = mob:getID()
    if mobId == ID.mob.SC_DETECTORS.DET1 and (mob:isFollowingPath() == false) then
        mob:pathThrough(tpz.path.first(SC_DETECTOR_PATHS.ISLAND1.a))
    elseif mobId == ID.mob.SC_DETECTORS.DET2 and (mob:isFollowingPath() == false) then
        mob:pathThrough(tpz.path.first(SC_DETECTOR_PATHS.ISLAND1.b))
    elseif mobId == ID.mob.SC_DETECTORS.DET3 and (mob:isFollowingPath() == false) then
        mob:pathThrough(tpz.path.first(SC_DETECTOR_PATHS.ISLAND2.a))
    elseif mobId == ID.mob.SC_DETECTORS.DET4 and (mob:isFollowingPath() == false) then
        mob:pathThrough(tpz.path.first(SC_DETECTOR_PATHS.ISLAND2.b))
    elseif mobId == ID.mob.SC_DETECTORS.DET5 and (mob:isFollowingPath() == false) then
        mob:pathThrough(tpz.path.first(SC_DETECTOR_PATHS.ISLAND3.a))
    elseif mobId == ID.mob.SC_DETECTORS.DET6 and (mob:isFollowingPath() == false) then
        mob:pathThrough(tpz.path.first(SC_DETECTOR_PATHS.ISLAND3.b))
    elseif mobId == ID.mob.SC_DETECTORS.DET7 and (mob:isFollowingPath() == false) then
        mob:pathThrough(tpz.path.first(SC_DETECTOR_PATHS.ISLAND4.a))
    elseif mobId == ID.mob.SC_DETECTORS.DET8 and (mob:isFollowingPath() == false) then
        mob:pathThrough(tpz.path.first(SC_DETECTOR_PATHS.ISLAND4.b))
    end
end

function onMobFight(mob, target)
    local caretaker = GetMobByID(mob:getID() + 1)
    local petCount = mob:getLocalVar("petCount")
    local now = os.time()

    
    -- Summons a Caretaker every 15 seconds.
    -- TODO: Casting animation for before summons. When he spawns them isn't exactly retail accurate.
    --       Should be ~10s to start cast, and another ~5 to finish.
    if petCount <= 5 and mob:getBattleTime() % 15 < 3 and mob:getBattleTime() > 3 and not caretaker:isSpawned() and canDetectorSummonSC(mob) then
        if now >= GetServerVariable("SteamCleaner_Respawn") and (math.random(100) < 10) then
            local sc = GetMobByID(ID.mob.STEAM_CLEANER)
            if not sc:isSpawned() then
                sc:setSpawn(mob:getXPos() + 1, mob:getYPos(), mob:getZPos() + 1)
                sc:spawn()
                sc:updateEnmity(target)
            end
            return
        end
    end
    if petCount <= 5 and mob:getBattleTime() % 15 < 3 and mob:getBattleTime() > 3 and not caretaker:isSpawned() then
        caretaker:setSpawn(mob:getXPos() + 1, mob:getYPos(), mob:getZPos() + 1)
        caretaker:spawn()
        caretaker:updateEnmity(target)
        mob:setLocalVar("petCount", petCount + 1)
    end

    -- make sure pet has a target
    if caretaker:getCurrentAction() == tpz.act.ROAMING then
        caretaker:updateEnmity(target)
    end
end

function onMobDisengage(mob)
    local caretakerId = mob:getID() + 1

    mob:resetLocalVars()
    if GetMobByID(caretakerId):isSpawned() then
        DespawnMob(caretakerId)
    end
end

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 743, 1, tpz.regime.type.GROUNDS)
end

function onMobDespawn(mob)
    if canDetectorSummonSC(mob) then
        mob:setRespawnTime(1800)
    end
end

function canDetectorSummonSC(mob)
    local canSummonSC = false
    local mobId = mob:getID()

    for i,v in pairs(ID.mob.SC_DETECTORS) do
        printf("ID %d", v)
        if mobId == v then   
            canSummonSC = true
        end
    end

    return canSummonSC    
end