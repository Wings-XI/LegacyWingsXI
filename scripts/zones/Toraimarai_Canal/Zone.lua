-----------------------------------
--
-- Zone: Toraimarai Canal (169)
--
-----------------------------------
local ID = require("scripts/zones/Toraimarai_Canal/IDs")
require("scripts/globals/conquest")
require("scripts/globals/treasure")
-----------------------------------

local posOne =
{
    {   8.945, 15.999, -179.990},
    {-179.871, 20.499,   98.223},
    { 160.512,  8.432, -120.236},
    {  20.060, 16.999,   60.461},
    {  70.367, 15.999, -180.244},
    { 219.927, 16.999,  -60.704},
    {  80.171, 20.433,  -39.799},
    {-300.800, 24.999,   59.860},
}

local posTwo =
{
    { 300.019,  16.00,  -49.542},
    { -20.004,  16.00,   -2.683},
    { 299.974,  16.00, -110.444},
    {-179.936,  16.00,   82.791},
    { 100.068,  17.00, -260.005},
    { 140.022,  17.00,   20.017},
    { 118.800, -7.825,  -80.398},
    {-319.974, 21.909,  -19.967},
}

local posThree =
{
    { -19.875,  20.50,  -19.422},
    {-179.871, 20.499,   98.223},
    { 160.512,  8.432, -120.236},
    {  20.060, 16.999,   60.461},
    {-184.366,  16.00,  138.403},
    { 219.927, 16.999,  -60.704},
    {  80.171, 20.433,  -39.799},
    {-300.800, 24.999,   59.860},
}

function onInitialize(zone)
    tpz.treasure.initZone(zone)
    local oni_carcass_respawn = GetServerVariable("Oni_Carcass_Respawn")
    if os.time() < oni_carcass_respawn then
		GetMobByID(ID.mob.ONI_CARCASS):setRespawnTime(oni_carcass_respawn - os.time())
	else
		SpawnMob(ID.mob.ONI_CARCASS)
    end
end

function onZoneIn(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-259.98, 21.794, 81.887, 66)
    end
    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

function onGameHour(zone)
    local sapMove = GetServerVariable("ASA_SapMoveTime")
    if os.time() > sapMove then
        sapMove = os.time() + math.random(18000,25200)
        SetServerVariable("ASA_SapMoveTime", sapMove)

        local position = math.random(1,3)
        if position == 1 then
            for offset = 1, 8 do
                GetNPCByID(ID.npc.SAP_OFFSET + offset):setPos(posOne[offset][1], posOne[offset][2], posOne[offset][3])
            end
        elseif position == 2 then
            for offset = 1, 8 do
                GetNPCByID(ID.npc.SAP_OFFSET + offset):setPos(posTwo[offset][1], posTwo[offset][2], posTwo[offset][3])
            end
        else
            for offset = 1, 8 do
                GetNPCByID(ID.npc.SAP_OFFSET + offset):setPos(posThree[offset][1], posThree[offset][2], posThree[offset][3])
            end
        end
    end
end