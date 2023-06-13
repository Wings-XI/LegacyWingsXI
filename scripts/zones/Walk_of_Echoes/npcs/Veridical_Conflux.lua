-----------------------------------
-- Area: Walk Of Echoes
--  NPC: Veridical Conflux
-- !pos -414 14 -60 182
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(1004)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    local posX = player:getXPos()
    local posY = player:getYPos()
    local posZ = player:getZPos()

    if (csid == 1004 and option == 0) then
        if math.abs(-700 - posX) < 5 and math.abs(0 - posY) < 10 and math.abs(-444 - posZ) < 10 then
            player:setPos(-142, -6.75, 582, 192, 89) -- Grauberg_S
        else
            player:setPos(238, -8, -248, 0, 137) -- Xarc_S
        end
    end
end
