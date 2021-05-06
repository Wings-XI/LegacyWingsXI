-----------------------------------
--  Area: Windurst Walls
--  Door: Priming Gate
--  Involved in quest: Toraimarai Turmoil
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    X = player:getXPos()
    Z = player:getZPos()

    if (X >= 4 and X <= 8) and (Z >= 276 and Z <= 280) then
        if player:hasKeyItem(tpz.ki.RHINOSTERY_CERTIFICATE) then
            player:startEvent(401)
        else
            player:startEvent(264)
        end
    elseif (X >= 0 and X <= 3) and (Z >= 270 and Z <= 275) then
        player:startEvent(395)
    end
    return 1
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
