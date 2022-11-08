-----------------------------------
-- Area: Buburimu Peninsula
-- NPC: Jade Etui
-- Involved In Quest: Brigand's Chart
-----------------------------------
require("scripts/globals/treasure")
require("scripts/zones/Buburimu_Peninsula/npcs/qm1")
-----------------------------------

    function onTrade(player, npc, trade)        
    end
    
    function onTrigger(player, npc)
        --Distribute rewards
        if npc:getLocalVar("open") == 0 and player:getLocalVar("BCQ") == 1 then
            npc:entityAnimationPacket("open")
            npc:setLocalVar("open", 1)
            npcs.qm1.openChest(player, npc)
            npc:timer(15000, function(npc)
                npc:entityAnimationPacket("kesu")
                npc:timer(2000, function(npc)
                    npc:setStatus(tpz.status.DISAPPEAR)
                    npc:setLocalVar("open", 0)
                end)
            end)
        end
    end

    function onEventUpdate(player, csid, option)
    end
    
    function onEventFinish(player, csid, option)
    end