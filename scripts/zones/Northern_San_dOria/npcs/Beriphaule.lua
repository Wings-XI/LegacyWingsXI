-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Beriphaule
-- Type: Allegiance Changer NPC
-- !pos -247.422 7.000 28.992 231
-----------------------------------
require("scripts/globals/conquest")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local new_nation = tpz.nation.SANDORIA
    local old_nation = player:getNation()
    local rank = getNationRank(new_nation)

    if (old_nation == new_nation) then
        player:startEvent(608, 0, 0, 0, old_nation)
    elseif (player:getCurrentMission(old_nation) ~= tpz.mission.id.nation.NONE or player:getCharVar("MissionStatus") ~= 0) then
        player:startEvent(607, 0, 0, 0, new_nation)
    elseif (old_nation ~= new_nation) then
        local has_gil = 0
        local cost = 0

        if (rank == 1) then
            cost = 40000
        elseif (rank == 2) then
            cost = 12000
        elseif (rank == 3) then
            cost = 4000
        end

        if (player:getGil() >= cost) then
            has_gil = 1
        end

        player:startEvent(606, 0, 1, player:getRank(new_nation), new_nation, has_gil, cost)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 606 and option == 1) then
        local new_nation = tpz.nation.SANDORIA
        local rank = getNationRank(new_nation)
        local cost = 0
        local ID = zones[player:getZoneID()]

        if (rank == 1) then
            cost = 40000
        elseif (rank == 2) then
            cost = 12000
        elseif (rank == 3) then
            cost = 4000
        end

        -- WINGSCUSTOM - restrict supply runs until next conq reset, but allow all outposts from previous rank 10 nations
        -- rather than reinvent the getConquestTally function in cpp, just adding this to each allegiance npc
        if player:getRank() == 10 then
            player:setCharVar("supplyQuest_nextSupplies", getConquestTally())
            player:PrintToPlayer("Since you were rank 10, you may not collect supplies until the next conquest reset", 0x1F)
        end
        player:setNation(new_nation)
        player:setGil(player:getGil() - cost)
        player:setRankPoints(0)
        player:addItem(536)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 536)
    end

end
