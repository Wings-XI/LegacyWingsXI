-----------------------------------
-- Area: Heavens Tower
--  NPC: Rakano-Marukano
-- Type: Immigration NPC
-- !pos 6.174 -1 32.285 242
-----------------------------------
require("scripts/globals/conquest")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local newNation = tpz.nation.WINDURST
    local oldNation = player:getNation()
    local rank = getNationRank(newNation)

    if oldNation == newNation then
        player:startEvent(10004, 0, 0, 0, oldNation)
    elseif player:getCurrentMission(oldNation) ~= tpz.mission.id.nation.NONE or player:getCharVar("MissionStatus") ~= 0 then
        player:startEvent(10003, 0, 0, 0, newNation)
    elseif oldNation ~= newNation then
        local hasGil = 0
        local cost = 0

        if rank == 1 then
            cost = 40000
        elseif rank == 2 then
            cost = 12000
        elseif rank == 3 then
            cost = 4000
        end

        if player:getGil() >= cost then
            hasGil = 1
        end

        player:startEvent(10002, 0, 1, player:getRank(newNation), newNation, hasGil, cost)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 10002 and option == 1 then
        local newNation = tpz.nation.WINDURST
        local rank = getNationRank(newNation)
        local cost = 0
        local ID = zones[player:getZoneID()]

        if rank == 1 then
            cost = 40000
        elseif rank == 2 then
            cost = 12000
        elseif rank == 3 then
            cost = 4000
        end

        -- WINGSCUSTOM - restrict supply runs until next conq reset, but allow all outposts from previous rank 10 nations
        -- rather than reinvent the getConquestTally function in cpp, just adding this to each allegiance npc
        if player:getRank() == 10 then
            player:setCharVar("supplyQuest_nextSupplies", getConquestTally())
            player:PrintToPlayer("Since you were rank 10, you may not collect supplies until the next conquest reset", 0x1F)
        end
        player:setNation(newNation)
        player:setGil(player:getGil() - cost)
        player:setRankPoints(0)
        player:addItem(536)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 536)
    end
end
