-----------------------------------
-- Pirates helpers
-----------------------------------
require("scripts/globals/pathfind")

tpz = tpz or {}
tpz.pirates = tpz.pirates or {}
tpz.pirates.status = 
{
    IDLE       = 0,
    PREPARING  = 1,
    ARRIVING   = 2,
    SPAWNING   = 3,
    ATTACKING  = 4,
    DESPAWNING = 5,
    DEPARTING  = 6,
    FINISHED   = 7
}

local function SetZoneMusic(zone, block, track)
    for _, player in pairs(zone:getPlayers()) do
        player:ChangeMusic(block, track)
    end
end

tpz.pirates.init = function(ID)
    local ship = GetNPCByID(ID.npc.PIRATE_SHIP.id)
    ship:setAnimPath(ID.npc.PIRATE_SHIP.anim_path)
    ship:setStatus(tpz.status.DISAPPEAR)

    for k, pirate in pairs(ID.npc.PIRATES) do
        local npc = GetNPCByID(k)
        npc:setPos(pirate.start_pos)
        npc:initNpcAi()
    end
end

tpz.pirates.start = function(ID)
    local ship = GetNPCByID(ID.npc.PIRATE_SHIP.id)
    tpz.pirates.setStatus(ship, tpz.pirates.status.IDLE)
    tpz.pirates.despawnMobs(ID)
    tpz.pirates.despawnNPCs(ID)
    tpz.pirates.reset(ID)
end

tpz.pirates.getStatus = function(ship)
    return ship:getLocalVar("pirateStatus")
end

tpz.pirates.setStatus = function(ship, status)
    ship:setLocalVar("pirateStatus", status)
end

tpz.pirates.reset = function(ID)
    local ship = GetNPCByID(ID.npc.PIRATE_SHIP.id)
    ship:setAnimation(0)
    ship:setStatus(tpz.status.DISAPPEAR)
    tpz.pirates.setShipPosition(ship, ID.npc.PIRATE_SHIP.start_pos)
    ship:sendUpdateToZoneCharsInRange()
    GetMobByID(ID.mob.NM):setLocalVar("killed", 0)
end

tpz.pirates.spawnMob = function(mobId)
    local x = math.random(-4.5,4.5)
    local z = math.random(10,22)
    local rot = math.random(0,255)
    local mob = GetMobByID(mobId)
    mob:setSpawn(x,-7.263,z,rot)
    mob:spawn()
end

tpz.pirates.spawnMobs = function(ID)
    for i = 1, #ID.mob.CROSSBONES do
        local xbone = GetMobByID(ID.mob.CROSSBONES[i])
        if not xbone:isSpawned() and os.time() > xbone:getLocalVar("respawnTime") then
            tpz.pirates.spawnMob(ID.mob.CROSSBONES[i])
        end
    end
    local wight = GetMobByID(ID.mob.SHIP_WIGHT)
    local nm = GetMobByID(ID.mob.NM)
    if not wight:isSpawned() and not nm:isSpawned() then
        if os.time() > wight:getLocalVar("respawnTime") then
            if nm:getLocalVar("killed") == 1 or math.random(0,100) < 95 then
                tpz.pirates.spawnMob(ID.mob.SHIP_WIGHT)
            else
                tpz.pirates.spawnMob(ID.mob.NM)
            end
        end
    end
end

tpz.pirates.despawnMobs = function(ID)
    for i = 1, #ID.mob.CROSSBONES do
        if GetMobByID(ID.mob.CROSSBONES[i]):isSpawned() and GetMobAction(ID.mob.CROSSBONES[i]) == tpz.act.ROAMING then
            DespawnMob(ID.mob.CROSSBONES[i])
        end
    end
    if GetMobByID(ID.mob.SHIP_WIGHT):isSpawned() and GetMobAction(ID.mob.SHIP_WIGHT) == tpz.act.ROAMING then
        DespawnMob(ID.mob.SHIP_WIGHT)
    end
    if GetMobByID(ID.mob.NM):isSpawned() and GetMobAction(ID.mob.NM) == tpz.act.ROAMING then
        DespawnMob(ID.mob.NM)
    end
end

tpz.pirates.despawnNPCs = function(ID)
    for k, pirate in pairs(ID.npc.PIRATES) do
        local npc = GetNPCByID(k)
        npc:setLocalVar("summoning", 0)
        npc:setStatus(tpz.status.DISAPPEAR)
    end
end

tpz.pirates.setShipPosition = function(ship, pos)
    ship:setPos(pos.x, pos.y, pos.z, pos.rot)
end

tpz.pirates.summonAnimations = function(ID, firstcast)
    for k, pirate in pairs(ID.npc.PIRATES) do
        local npc = GetNPCByID(k)
        if npc:getLocalVar("castmode") == 1 and npc:getLocalVar("summoning") == 0 then
            npc:setLocalVar("summoning", 1)
            local startTime = 0
            if not firstcast then
                startTime = 2000 + math.random(0,2000)
            end
            npc:timer(startTime, function(npc)
                if npc:getLocalVar("castmode") == 1 then
                    npc:entityAnimationPacket("casm")
                    local randomSummonTime = 2000 + math.random(0,2000)
                    npc:timer(randomSummonTime, function(npc)
                        npc:entityAnimationPacket("shsm")
                        npc:setLocalVar("summoning", 0)
                    end)
                end
            end)
        end
    end
end

tpz.pirates.update = function(ID, zone, tripTime)
    local ship = GetNPCByID(ID.npc.PIRATE_SHIP.id)
    local pirateStatus = tpz.pirates.getStatus(ship)

    switch (pirateStatus): caseof
    {
        [tpz.pirates.status.IDLE] = function (x)
            if tripTime >= 200 then
                SetZoneMusic(zone, 0, 0)
                SetZoneMusic(zone, 1, 0)
                tpz.pirates.setStatus(ship, tpz.pirates.status.PREPARING)
            end
        end,
        [tpz.pirates.status.PREPARING] = function (x)
            if tripTime >= 240 then
                ship:setAnimation(18)
                ship:setAnimStart(true)
                ship:setAnimBegin(VanadielTime())
                ship:setStatus(tpz.status.NORMAL)
                tpz.pirates.setShipPosition(ship, ID.npc.PIRATE_SHIP.start_pos)
                ship:sendUpdateToZoneCharsInRange()
                tpz.pirates.setStatus(ship, tpz.pirates.status.ARRIVING)
            end
        end,
        [tpz.pirates.status.ARRIVING] = function (x)
            if tripTime >= 290 then
                for k, pirate in pairs(ID.npc.PIRATES) do
                    local npc = GetNPCByID(k)
                    npc:setPos(tpz.path.first(pirate.enter_path))
                    tpz.path.patrol(npc, pirate.enter_path)
                    npc:lookAt(pirate.look_at)
                    npc:setStatus(tpz.status.NORMAL)
                    npc:sendUpdateToZoneCharsInRange()
                end
                SetZoneMusic(zone, 0, 170)
                SetZoneMusic(zone, 1, 170)
                tpz.pirates.setShipPosition(ship, ID.npc.PIRATE_SHIP.event_pos)
                ship:sendUpdateToZoneCharsInRange()
                tpz.pirates.setStatus(ship, tpz.pirates.status.SPAWNING)
            end
        end,
        [tpz.pirates.status.SPAWNING] = function (x)
            if tripTime >= 296 then
                tpz.pirates.setShipPosition(ship, ID.npc.PIRATE_SHIP.event_pos)
                ship:setAnimation(0)
                ship:sendUpdateToZoneCharsInRange()
                tpz.pirates.setStatus(ship, tpz.pirates.status.ATTACKING)
                for k, pirate in pairs(ID.npc.PIRATES) do
                    local npc = GetNPCByID(k)
                    npc:setLocalVar("castmode",1)
                    npc:lookAt(pirate.look_at)
                    npc:sendUpdateToZoneCharsInRange()
                end
                tpz.pirates.summonAnimations(ID, true)
                tpz.pirates.spawnMobs(ID)
            else
                for k, pirate in pairs(ID.npc.PIRATES) do
                    local npc = GetNPCByID(k)
                    tpz.path.patrol(npc, pirate.enter_path)
                    npc:lookAt(pirate.look_at)
                    npc:sendUpdateToZoneCharsInRange()
                end
            end
        end,
        [tpz.pirates.status.ATTACKING] = function (x)
            if tripTime >= 695 then
                for k, pirate in pairs(ID.npc.PIRATES) do
                    local npc = GetNPCByID(k)
                    npc:setLocalVar("castmode",0)
                    npc:setPos(tpz.path.first(pirate.exit_path))
                    tpz.path.patrol(npc, pirate.exit_path)
                end
                tpz.pirates.despawnMobs(ID)
                tpz.pirates.setStatus(ship, tpz.pirates.status.DESPAWNING)
            elseif tripTime <= 685 then
                tpz.pirates.summonAnimations(ID, false)
                tpz.pirates.spawnMobs(ID)
                SetZoneMusic(zone, 0, 170)
                SetZoneMusic(zone, 1, 170)
            end
        end,
        [tpz.pirates.status.DESPAWNING] = function (x)
            tpz.pirates.despawnMobs(ID)
            if tripTime >= 706 then
                tpz.pirates.despawnNPCs(ID)
                ship:setAnimPath(ID.npc.PIRATE_SHIP.anim_path)
                ship:setAnimation(19)
                ship:setAnimStart(true)
                ship:setAnimBegin(VanadielTime())
                tpz.pirates.setShipPosition(ship, ID.npc.PIRATE_SHIP.start_pos)
                ship:sendUpdateToZoneCharsInRange()
                tpz.pirates.setStatus(ship, tpz.pirates.status.DEPARTING)
            else
                for k, pirate in pairs(ID.npc.PIRATES) do
                    tpz.path.patrol(GetNPCByID(k), pirate.exit_path)
                end
            end
        end,
        [tpz.pirates.status.DEPARTING] = function (x)
            tpz.pirates.despawnMobs(ID)
            if tripTime >= 760 then
                SetZoneMusic(zone, 0, 106)
                SetZoneMusic(zone, 1, 106)
                ship:setAnimation(0)
                ship:setStatus(tpz.status.DISAPPEAR)
                ship:sendUpdateToZoneCharsInRange()
                tpz.pirates.setStatus(ship, tpz.pirates.status.FINISHED)
            end
        end,
        [tpz.pirates.status.FINISHED] = function (x)
            tpz.pirates.despawnMobs(ID)
        end
    }
end
