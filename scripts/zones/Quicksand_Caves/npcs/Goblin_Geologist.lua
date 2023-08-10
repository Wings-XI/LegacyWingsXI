-----------------------------------
-- Area: Quicksand Caves
--  NPC: Goblin Geologist
--   ID: 17629743
-- Type: Mission
-- !pos -737.000 -11.125 -550.000 208
-- Geologist markers event: cutscene, progress, playerHasMap, markerSet, ???
-- Progress: 0 - start, 1 - all collected, 2 - markers given
-----------------------------------
require("scripts/globals/events/amkhelpers")
-----------------------------------
function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local hasMap = player:hasKeyItem(tpz.ki.MAP_OF_THE_QUICKSAND_CAVES) and 1 or 0
    local stones = 0

    for i=1, 9 do
        if player:hasKeyItem(tpz.ki.STONE_OFFSET + i) then
            stones = stones + 1
        end
    end
    if stones == 9 then
        player:setCharVar("[AMK]8_rescueProgress", 1)
    end
    local amkProgress = player:getCharVar("[AMK]8_rescueProgress")

    if player:getCurrentMission(AMK) >= tpz.mission.id.amk.RESCUE_A_MOOGLES_LABOR_OF_LOVE then
        if amkProgress == 1 then
            player:startEvent(100, amkProgress, hasMap, 0, 0)
        else
            local markerSet = amkHelpers.getMarkerSet(player)
            --  the markerSet sent to the event automatically adds markers to the player's map
            player:startEvent(100, amkProgress, hasMap, markerSet, 0)
        end
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    local amkProgress = player:getCharVar("[AMK]8_rescueProgress")
    if csid == 100 then
        if amkProgress == 0 then
            player:setCharVar("[AMK]8_rescueProgress", 2)
        elseif
            amkProgress == 1 and
            option == 11
        then
            npcUtil.giveKeyItem(player, tpz.ki.NAVARATNA_TALISMAN)
            for i=1, 9 do
                player:delKeyItem(tpz.ki.STONE_OFFSET + i)
            end
        end
    end
end
