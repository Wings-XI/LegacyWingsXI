-----------------------------------
--
-- Zone: Ranguemont Pass (166)
--
-----------------------------------
local ID = require("scripts/zones/Ranguemont_Pass/IDs")
require("scripts/globals/conquest")
-----------------------------------

function onInitialize(zone)
    -- pick a random Taisaijin PH and set its do not disturb time
	
	local TaisaijinAlive = GetServerVariable("TaisaijinAlive")
	local ph1picked = GetServerVariable("TaisaiPicked1")
	local ph2picked = GetServerVariable("TaisaiPicked2")
	local ph3picked = GetServerVariable("TaisaiPicked3")
	local phIndex = 0
	
	
	if (ph1picked > 0) then
		phIndex = 1
	elseif (ph2picked > 0) then
		phIndex = 2
	elseif (ph3picked > 0) then
		phIndex = 3
	end
	
	
	if (TaisaijinAlive == 0 and phIndex == 0) then
		--print("Taisaijin dead and phIndex not found")
		local phIndex = math.random(1, 3)
		local ph = GetMobByID(ID.mob.TAISAIJIN_PH[phIndex])
		ph:setLocalVar("timeToGrow", os.time() + math.random(86400, 259200)) -- 1 to 3 days
		ph:setLocalVar("phIndex", phIndex)
	elseif (TaisaijinAlive > 0) then
		--print("Taisaijin alive")
		phIndex = TaisaijinAlive
		local ph = GetMobByID(ID.mob.TAISAIJIN_PH[phIndex])
		local nm = GetMobByID(ID.mob.TAISAIJIN)
		DisallowRespawn(ph:getID(), true) -- Taisai
		DespawnMob(ph:getID())
		DisallowRespawn(nm:getID(), false) -- Taisaijin
		SpawnMob(nm:getID())
		nm:setLocalVar("phIndex", phIndex)
	elseif (phIndex > 0) then
		local ph = GetMobByID(ID.mob.TAISAIJIN_PH[phIndex])
		ph:setLocalVar("phIndex",phIndex)
		if phIndex == 1 then
			ph:setLocalVar("timeToGrow", GetServerVariable("timeToGrow1"))
		elseif phIndex == 2 then
			ph:setLocalVar("timeToGrow", GetServerVariable("timeToGrow2"))
		elseif phIndex == 3 then
			ph:setLocalVar("timeToGrow", GetServerVariable("timeToGrow3"))
		end
		
		--local respawntime = GetServerVariable("timeToGrow1") + GetServerVariable("timeToGrow2") + GetServerVariable("timeToGrow3") - os.time()
		--print("phIndex found, setting local vars. respawntime is" .. respawntime)
		
	end
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(302.778, -68.131, 257.759, 137)
    end
    return cs
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

function onGameHour()

	local ph1 = GetMobByID(17457213)
	local ph2 = GetMobByID(17457214)
	local ph3 = GetMobByID(17457215)

	SetServerVariable("timeToGrow1", ph1:getLocalVar("timeToGrow"))
	SetServerVariable("timeToGrow2", ph2:getLocalVar("timeToGrow"))
	SetServerVariable("timeToGrow3", ph3:getLocalVar("timeToGrow"))
	SetServerVariable("TaisaiPicked1", ph1:getLocalVar("phIndex"))
	SetServerVariable("TaisaiPicked2", ph2:getLocalVar("phIndex"))
	SetServerVariable("TaisaiPicked3", ph3:getLocalVar("phIndex"))
	
end
