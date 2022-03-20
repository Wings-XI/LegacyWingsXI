-----------------------------------
--
-- Zone: Gusgen Mines (196)
--
-----------------------------------
local ID = require("scripts/zones/Gusgen_Mines/IDs")
require("scripts/globals/conquest")
require("scripts/globals/treasure")
require("scripts/globals/helm")
-----------------------------------

function onInitialize(zone)
    tpz.treasure.initZone(zone)
    tpz.helm.initZone(zone, tpz.helm.type.MINING)
    local juggler_respawn = GetServerVariable("Juggler_Hecatomb_Respawn")
	if os.time() < juggler_respawn then
		GetMobByID(ID.mob.JUGGLER_HECATOMB):setRespawnTime(juggler_respawn - os.time())
	else
		SpawnMob(ID.mob.JUGGLER_HECATOMB)
    end
end

function onZoneIn(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(100.007, -61.63, -237.441, 187)
    end
    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

function onGameHour(zone)
    local totd = VanadielTOTD()

    if totd == tpz.time.NEW_DAY or totd == tpz.time.MIDNIGHT then
        local asphyxiated = GetMobByID(ID.mob.ASPHYXIATED_AMSEL)
        local burned = GetMobByID(ID.mob.BURNED_BERGMANN)
        local crushed = GetMobByID(ID.mob.CRUSHED_KRAUSE)
        local pulverized = GetMobByID(ID.mob.PULVERIZED_PFEFFER)
        local smothered = GetMobByID(ID.mob.SMOTHERED_SCHMIDT)
        local wounded = GetMobByID(ID.mob.WOUNDED_WURFEL)
        
        if not asphyxiated:isSpawned() and os.time() > asphyxiated:getLocalVar("cooldown") then
            SpawnMob(ID.mob.ASPHYXIATED_AMSEL)
        end

        if not burned:isSpawned() and os.time() > burned:getLocalVar("cooldown") then
            SpawnMob(ID.mob.BURNED_BERGMANN)
        end

        if not crushed:isSpawned() and os.time() > crushed:getLocalVar("cooldown") then
            SpawnMob(ID.mob.CRUSHED_KRAUSE)
        end

        if not pulverized:isSpawned() and os.time() > pulverized:getLocalVar("cooldown") then
            SpawnMob(ID.mob.PULVERIZED_PFEFFER)
        end

        if not smothered:isSpawned() and os.time() > smothered:getLocalVar("cooldown") then
            SpawnMob(ID.mob.SMOTHERED_SCHMIDT)
        end

        if not wounded:isSpawned() and os.time() > wounded:getLocalVar("cooldown") then
            SpawnMob(ID.mob.WOUNDED_WURFEL)
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
