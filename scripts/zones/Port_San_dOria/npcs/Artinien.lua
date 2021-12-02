-----------------------------------
-- Area: Port San d'Oria
--  NPC: Artinien
-----------------------------------
local ID = require("scripts/zones/Port_San_dOria/IDs")
require("scripts/globals/events/starlight_festivals")
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    -17.142, -4.000, -74.747,
    -17.142, -4.000, -74.747,
    -17.142, -4.000, -74.747,
    -17.142, -4.000, -74.747,
    -20.721, -4.000, -76.425,
    -20.721, -4.000, -76.425,
    -20.721, -4.000, -76.425,
    -20.721, -4.000, -76.425,
    -21.725, -4.000, -73.177,
    -19.164, -4.000, -71.713,
    -17.037, -4.000, -74.698,
    -17.037, -4.000, -74.698,
    -17.037, -4.000, -74.698,
    -17.037, -4.000, -74.698,
    -20.893, -4.000, -76.206,
    -21.735, -4.000, -75.139,
    -22.984, -4.000, -73.555,
    -22.984, -4.000, -73.555,
    -22.984, -4.000, -73.555,
    -19.132, -4.000, -71.759,
}

function onSpawn(npc)
    npc:initNpcAi()
    npc:setPos(tpz.path.first(path))
    onPath(npc)
end

function onPath(npc)
    tpz.path.patrolsimple(npc, path, flags)
end

function onTrade(player, npc, trade)
    onStarlightSmilebringersTrade(player, trade, npc)
end

function onTrigger(player, npc)
    if player:getCharVar("thePickpocket") == 1 then
        player:showText(npc, ID.text.PICKPOCKET_ARTINIEN)
    else
        player:startEvent(588)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
