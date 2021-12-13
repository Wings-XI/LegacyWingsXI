-----------------------------------
-- Area: Davoi
--  NPC: Quemaricond
-- Involved in Mission: Infiltrate Davoi
-- !pos 23 0.1 -23 149
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Davoi/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/settings")
-----------------------------------

local path =
{
    20.6, 0, -23,
    46, 0, -19,
    53.5, -1.8, -19,
    61, -1.1, -18.6,
    67.3, -1.5, -18.6,
    90, -0.5, -19
}

function onSpawn(npc)
    npc:initNpcAi()
    npc:setPos(tpz.path.first(path))
    onPath(npc)
end

function onPath(npc)

    tpz.path.patrolsimple(npc, path)
end

function onTrade(player, npc, trade)
    if player:getCharVar("AnnyEvent2020") == 11 and player:getCharVar("AnnyEvent2020_aery") == 1 and player:getCharVar("AnnyEvent2020_behe") == 1 and player:getCharVar("AnnyEvent2020_addy") == 1 and Anniversary_Event_2021 == 1 then
        if trade:hasItemQty(6405, 1) and trade:hasItemQty(6404, 1) and trade:hasItemQty(6403, 1) and player:getFreeSlotsCount() > 0 and trade:getItemCount() == 3 then
            player:tradeComplete()
            player:setCharVar("AnnyEvent2020", 12)
            player:PrintToPlayer("Quemaricond : Oh wow! These will really keep me going..", 0xD)
            player:PrintToPlayer("Quemaricond : Off you go! One last Request, venture where the storm is strongest..", 0xD)
            player:PrintToPlayer("Quemaricond : Take what you find to a great fighter now retired...", 0xD)
        end
    end
end

function onTrigger(player, npc)

    if (player:getCurrentMission(SANDORIA) == tpz.mission.id.sandoria.INFILTRATE_DAVOI and player:getCharVar("MissionStatus") == 3) then
        player:startEvent(117)
    else
        player:showText(npc, ID.text.QUEMARICOND_DIALOG)
        npc:wait(2000)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option, npc)

    if (csid == 117) then
        player:setCharVar("MissionStatus", 4)
        player:addKeyItem(tpz.ki.ROYAL_KNIGHTS_DAVOI_REPORT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.ROYAL_KNIGHTS_DAVOI_REPORT)
    else
        npc:wait(0)
    end
end
