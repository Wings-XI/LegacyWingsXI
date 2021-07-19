-----------------------------------
--
-- Zone: Windurst_Waters_[S] (94)
--
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters_[S]/IDs")
require("scripts/globals/chocobo")
require("scripts/globals/npc_util")
-----------------------------------

function onInitialize(zone)
    tpz.chocobo.initZone(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1

    -- MOG HOUSE EXIT
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(157 + math.random(1, 5), -5, -62, 192)
    end

    if player:getCharVar("ManifestProblem") == 5 then
       cs = 153
    end

    return cs
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 153 then
        player:startEvent(231)
    elseif csid == 231 then
        player:startEvent(232)
    elseif csid == 232 then
        player:startEvent(233)
    elseif csid == 233 then
        npcUtil.completeQuest(player, CRYSTAL_WAR, tpz.quest.id.crystalWar.A_MANIFEST_PROBLEM, {item=5708, title=tpz.title.FRIEND_OF_LEHKO_HABHOKA, var="ManifestProblem"})
    end
end
