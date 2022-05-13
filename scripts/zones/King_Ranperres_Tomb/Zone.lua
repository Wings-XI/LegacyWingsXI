-----------------------------------
--
-- Zone: King Ranperres Tomb (190)
--
-----------------------------------
local ID = require("scripts/zones/King_Ranperres_Tomb/IDs")
require("scripts/globals/conquest")
require("scripts/globals/treasure")
require("scripts/globals/zone")
-----------------------------------

function onInitialize(zone)
    zone:registerRegion(1, -84.302, 6.5, -120.997, -77, 7.5, -114) -- Used for stairs teleport -85.1, 7, -119.9

    UpdateNMSpawnPoint(ID.mob.VRTRA)
    local vrtre = GetServerVariable("VrtraRespawn")
	if os.time() < vrtre then
		GetMobByID(ID.mob.VRTRA):setRespawnTime(vrtre - os.time())
	else
		SpawnMob(ID.mob.VRTRA)
	end

	local re = GetServerVariable("CherryRespawn")
	if os.time() < re then
        for i = ID.mob.CHERRY_SAPLING_OFFSET, ID.mob.CHERRY_SAPLING_OFFSET + 12 do
            local mob = GetMobByID(i)
            if mob ~= nil and mob:getName() == 'Cherry_Sapling' and not mob:isSpawned() then
                mob:setRespawnTime(re - os.time())
            end
        end
	else
        for i = ID.mob.CHERRY_SAPLING_OFFSET, ID.mob.CHERRY_SAPLING_OFFSET + 12 do
            local mob = GetMobByID(i)
            if mob ~= nil and mob:getName() == 'Cherry_Sapling' and not mob:isSpawned() then
                SpawnMob(mob:getID())
            end
        end
	end

    tpz.treasure.initZone(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(242.012, 5.305, 340.059, 121)
    end
    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
    if region:GetRegionID() == 1 then
        player:startEvent(9)
    end
end

function onRegionLeave(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end