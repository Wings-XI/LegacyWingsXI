-----------------------------------
--
-- Zone: Attohwa_Chasm (7)
--
-----------------------------------
local ID = require("scripts/zones/Attohwa_Chasm/IDs")
require("scripts/globals/conquest")
require("scripts/globals/settings")
require("scripts/globals/helm")
require("scripts/globals/zone")
require("scripts/globals/world")
-----------------------------------

function onInitialize(zone)
    -- Poison Flowers!
    zone:registerRegion(1, -475.809, 5, 316.499, 0, 0, 0)
    zone:registerRegion(2, -440.938, 7, 281.749, 0, 0, 0)
    zone:registerRegion(3, -388.027, 5, 264.831, 0, 0, 0)
    zone:registerRegion(4, -534.104, 5, 217.833, 0, 0, 0)
    zone:registerRegion(5, -530.000, 5, 210.000, 0, 0, 0)
    zone:registerRegion(6, -482.192, 5, 198.647, 0, 0, 0)
    zone:registerRegion(7, -595.756, 7, 157.532, 0, 0, 0)
    zone:registerRegion(8, -514.000, 5, 166.000, 0, 0, 0)
    zone:registerRegion(9, -396.844, 5, 164.790, 0, 0, 0)
    zone:registerRegion(10, -382.919, 5, 143.572, 0, 0, 0)
    zone:registerRegion(11, -537.558, 5, 102.683, 0, 0, 0)
    zone:registerRegion(12, -393.979, 5, 101.877, 0, 0, 0)
    zone:registerRegion(13, -367.892, 5, 75.774, 0, 0, 0)
    zone:registerRegion(14, -369.333, 5, 69.333, 0, 0, 0)
    zone:registerRegion(15, -351.717, 5, 64.773, 0, 0, 0)
    zone:registerRegion(16, -386.000, 5, 50.000, 0, 0, 0)
    zone:registerRegion(17, -360.705, 5, 51.505, 0, 0, 0)
    zone:registerRegion(18, -475.667, 5, 37.081, 0, 0, 0)
    zone:registerRegion(19, -321.902, 5, 36.697, 0, 0, 0)
    zone:registerRegion(20, -351.916, 5, 10.501, 0, 0, 0)
    zone:registerRegion(21, -554.739, 5, -3.057, 0, 0, 0)
    zone:registerRegion(22, -397.667, 5, -5.563, 0, 0, 0)
    zone:registerRegion(23, -330.062, 5, -18.832, 0, 0, 0)
    zone:registerRegion(24, -233.015, 5, -19.049, 0, 0, 0)
    zone:registerRegion(25, -553.523, 5, -72.071, 0, 0, 0)
    zone:registerRegion(26, -535.904, 7, -67.914, 0, 0, 0)
    zone:registerRegion(27, -435.438, 5, -74.171, 0, 0, 0)
    zone:registerRegion(28, -369.343, 5, -73.449, 0, 0, 0)
    zone:registerRegion(29, -238, 5, -118, 0, 0, 0)
    zone:registerRegion(30, -385.349, 5, -173.973, 0, 0, 0)

    -- TIAMAT draw in ypos mod region
    zone:registerRegion(100, -570, -30, -45, -492, 10, 30)

    UpdateNMSpawnPoint(ID.mob.TIAMAT)
    local tiare = GetServerVariable("TiamatRespawn")
    if os.time() < tiare then
        GetMobByID(ID.mob.TIAMAT):setRespawnTime(tiare - os.time())
    else
        SpawnMob(ID.mob.TIAMAT)
    end

    UpdateNMSpawnPoint(ID.mob.XOLOTL)
    local xolre = GetServerVariable("XolotlRespawn")
    local Xolotl = GetMobByID(ID.mob.XOLOTL)
    local hour = VanadielHour()
    DisallowRespawn(Xolotl:getID(), true)
    if os.time() < xolre then
        GetMobByID(ID.mob.XOLOTL):setRespawnTime(xolre - os.time())
    elseif hour < 4 or hour >= 20 then
        DisallowRespawn(Xolotl:getID(), false)
        SpawnMob(Xolotl:getID())
    end

    local citire = GetServerVariable("CitipatiRespawn")
    local Citipati = GetMobByID(ID.mob.CITIPATI)
    UpdateNMSpawnPoint(ID.mob.CITIPATI)
    DisallowRespawn(Citipati:getID(), true)
    if os.time() < citire then
        GetMobByID(ID.mob.CITIPATI):setRespawnTime(citire - os.time())
    elseif hour < 4 or hour >= 20 then
        DisallowRespawn(Citipati:getID(), false)
    end

    tpz.helm.initZone(zone, tpz.helm.type.EXCAVATION)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(-194.487, -13.766, 338.704, 141)
    end
    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
    -- TODO: Gasponia's shouldn't "always" poison you. However, in retail regions constantly reapply themselves without having to re-enter the region. In Topaz that doesn't happen so I'm leaving it as-is for now.
    local regionId = region:GetRegionID()
    if (regionId <= 30) then
        local gasponia = GetNPCByID(ID.npc.GASPONIA_OFFSET + (regionId - 1))
        if (gasponia ~= nil) then
            gasponia:openDoor(3)
            if (not player:hasStatusEffect(tpz.effect.POISON)) then
                player:addStatusEffect(tpz.effect.POISON, 15, 0, math.random(30, 60))
                player:messageSpecial(ID.text.GASPONIA_POISON)
            end
        end
    end

    if (regionId == 100) then
        player:setDrawInOffsetY(-3.5)
    end
end

function onRegionLeave(player, region)
    if (region:GetRegionID() == 100) then
        player:setDrawInOffsetY(-1)
    end
end

function onGameHour()
    local xolre = GetServerVariable("XolotlRespawn")
    local XolotlDead = GetServerVariable("XolotlDead")
    local Xolotl = GetMobByID(ID.mob.XOLOTL)
    local totd = VanadielTOTD()

    if (totd == tpz.time.NIGHT or totd == tpz.time.MIDNIGHT) and (xolre - os.time() < 140) and XolotlDead == 1 and not Xolotl:isSpawned() then -- If respawn is less than one in game hour, allow Xolotl to spawn
        DisallowRespawn(Xolotl:getID(), false)
        SetServerVariable("XolotlDead", 0)
    elseif (totd == tpz.time.NIGHT or totd == tpz.time.MIDNIGHT) and xolre < os.time() and XolotlDead == 1 and not Xolotl:isSpawned() then -- If Xolotl's respawn window has passed, spawn him
        DisallowRespawn(Xolotl:getID(), false)
        SetServerVariable("XolotlDead", 0)
        SpawnMob(Xolotl:getID())
    elseif (totd == tpz.time.NIGHT or totd == tpz.time.MIDNIGHT) and XolotlDead == 0 and not Xolotl:isSpawned() then -- If Xolotl didn't die last night, spawn him
        DisallowRespawn(Xolotl:getID(), false)
        SpawnMob(Xolotl:getID())
    else
        DisallowRespawn(Xolotl:getID(), true)
    end

    local citire = GetServerVariable("CitipatiRespawn")

    if (totd == tpz.time.NIGHT or totd == tpz.time.MIDNIGHT) and (citire - os.time() < 140) then -- If respawn is less than one in game hour, allow Citipati to spawn
        DisallowRespawn(ID.mob.CITIPATI, false)
    elseif (totd == tpz.time.NIGHT or totd == tpz.time.MIDNIGHT) and citire < os.time() then -- If Citipati's respawn window has passed, allow him to spawn.
        DisallowRespawn(ID.mob.CITIPATI, false)
    else
        DisallowRespawn(ID.mob.CITIPATI, true)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
