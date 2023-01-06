-----------------------------------
-- Area: Dynamis-Tavnazia
--  Mob: Diabolos Club
-- Note: Mega Boss
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    local ID = require("scripts/zones/Dynamis-Tavnazia/IDs")
    dynamis.mobOnDeath(mob, mobList[zone], ID.text.DYNAMIS_TIME_EXTEND)

    local winQM = GetNPCByID(ID.mobs.winQM)
    local pos = mob:getPos()
    winQM:setPos(pos.x,pos.y,pos.z,pos.rot)
    winQM:setStatus(tpz.status.NORMAL)
    player:addTitle(tpz.title.NIGHTMARE_AWAKENER)
end
