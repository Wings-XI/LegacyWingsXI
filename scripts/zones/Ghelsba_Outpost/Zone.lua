-----------------------------------
--
-- Zone: Ghelsba_Outpost (140)
--
-----------------------------------
local ID = require("scripts/zones/Ghelsba_Outpost/IDs")
require("scripts/globals/conquest")
require("scripts/globals/helm")
-----------------------------------

function onInitialize(zone)
    tpz.helm.initZone(zone, tpz.helm.type.LOGGING)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(125.852, -22.097, 180.403, 128)
    end
    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
    -- Carrion Dragon event initation does not set PChar->m_event.Script, and LoadEventScript does not look for bcnms - so this event bubbles up to the zone
    if (player:getBattlefield():getID() == 37) then
        local players = player:getBattlefield():getPlayers()
        local fellowParam = getFellowParam(player)

        if csid == 32004 then
            for i,player in pairs(players) do
                player:updateEvent(140, 0, 5, 0, 0, 1048578, 0, fellowParam)
            end
        end
    end
end

function onEventFinish(player, csid, option)
    if (player:getBattlefield():getID() == 37) then
        if csid == 32004 then
        local mob = GetMobByID(ID.mob.CARRION_DRAGON + 1)
        local players = player:getBattlefield():getPlayers()
        mob:setHP(GetServerVariable("[Mirror_Mirror]BCNMmobHP"))
        mob:setPos(-189, -10, 42)
        for i,player in pairs(players) do
            player:setLocalVar("triggerFellow", 1) -- no greeting on spawn
            player:setLocalVar("FellowDisengage", 1) -- fellow cannot sync disengage
            player:spawnFellow(player:getFellowValue("fellowid"))
            printf("spawned")
            player:getFellow():setPos(-197, -10, 40.5)
            player:timer(20000, function(player) player:fellowAttack(mob) end)
        end
    end
    end
end
