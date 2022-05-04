-----------------------------------
--
-- Zone: Xarcabard (112)
--
-----------------------------------
local ID = require("scripts/zones/Xarcabard/IDs")
require("scripts/quests/i_can_hear_a_rainbow")
require("scripts/globals/conquest")
require("scripts/globals/keyitems")
require("scripts/globals/utils")
require("scripts/globals/zone")
-----------------------------------

function onInitialize(zone)
    tpz.conq.setRegionalConquestOverseers(zone:getRegionID(), 2)
    local ereshkigal_respawn = GetServerVariable("Ereshkigal_Respawn")
    if os.time() < ereshkigal_respawn then
		GetMobByID(ID.mob.ERESHKIGAL):setRespawnTime(ereshkigal_respawn - os.time())
	else
		SpawnMob(ID.mob.ERESHKIGAL)
    end
end

function onZoneIn(player, prevZone)
    local cs = -1
    local UnbridledPassionCS = player:getCharVar("unbridledPassion")
    local charDynaCS = player:getCharVar("HasSeenXarcabardDynamisCS")
    local oldPos = {}
    local newPos = {}

    -- Get the old position
    oldPos = player:getPos()

    -- Set new position to default to zoneline at BEAUCEDINE_GLACIER
    newPos = {x = -136.287, y = -23.268, z = 137.302, rot = 91}

    if player:getCharVar("Teleport") == tpz.ki.VAHZL_GATE_CRYSTAL then
        -- Teleport-Vahzl used.  Clear the teleport variable on the character
        newPos = {x = 150.258, y = -21.048, z = -37.256, rot = 94}
        player:setCharVar("Teleport", 0)
    elseif prevZone == tpz.zone.DYNAMIS_XARCABARD then
        -- Warp player to a correct position after dynamis
        newPos = {x = 569.312, y = -0.098, z = -270.158, rot = 90}
    elseif oldPos.x == 0 and oldPos.y == 0 and oldPos.z == 0 then
        -- Default position, in case of 0 errors in position table
        newPos = {x = -136.287, y = -23.268, z = 137.302, rot = 91}
    else
        -- Just keep the previous position, if nothing else
        newPos = oldPos
    end

    player:setPos(newPos.x, newPos.y, newPos.z, newPos.rot)

    if
        not player:hasKeyItem(tpz.ki.VIAL_OF_SHROUDED_SAND) and
        player:getRank() >= 6 and
        player:getMainLvl() >= 65 and
        charDynaCS == 0
    then
        cs = 13
    elseif quests.rainbow.onZoneIn(player) then
        cs = 9
    elseif UnbridledPassionCS == 3 then
        cs = 4
    elseif player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.VAIN and player:getCharVar("MissionStatus") == 1 then
        cs = 11
    end

    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
    if csid == 9 then
        quests.rainbow.onEventUpdate(player)
    elseif csid == 11 then
        if player:getPreviousZone() == tpz.zone.BEAUCEDINE_GLACIER then
            player:updateEvent(0, 0, 0, 0, 0, 2)
        else
            player:updateEvent(0, 0, 0, 0, 0, 3)
        end
    end
end

function onEventFinish(player, csid, option)
    if csid == 4 then
        player:setCharVar("unbridledPassion", 4)
    elseif csid == 13 then
        player:setCharVar("HasSeenXarcabardDynamisCS", 1)
    end
end
