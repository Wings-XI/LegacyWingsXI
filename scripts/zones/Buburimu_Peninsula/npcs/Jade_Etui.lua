-----------------------------------
-- Area: Buburimu Peninsula
-- NPC: Jade Etui
-- Involved In Quest: Brigand's Chart
-----------------------------------
require("scripts/globals/treasure")
require("scripts/zones/Buburimu_Peninsula/npcs/qm1")
-----------------------------------

function onSpawn(npc)
    -- workaround for getting spawned Jade Etui to display immediately
    -- moved status update into lua
    -- all 5 chests are spawned until the quest starts due to client issue with rendering the chest otherwise
    npc:AnimationSub(1)
    npc:entityAnimationPacket("kesu")
    npc:setStatus(tpz.status.DISAPPEAR)
    npc:timer(2000, function(npc)
        -- npc:setPos(npc:getPos())
        npc:setStatus(tpz.status.NORMAL)
        npc:AnimationSub(0)
        npc:entityAnimationPacket("deru")
    end)
end

    function onTrade(player, npc, trade)        
    end
    
    function onTrigger(player, npc)
        --Distribute rewards
        if npc:getLocalVar("open") == 0 and player:getLocalVar("BCQ") == 1 then
            npc:entityAnimationPacket("open")
            npc:setLocalVar("open", 1)
            npcs.qm1.openChest(player, npc)
            npc:timer(15000, function(npc)
                if npc:getLocalVar("BCQ") == 1 then
                    npc:entityAnimationPacket("kesu")
                end
                npc:timer(2000, function(npc)
                    if npc:getLocalVar("BCQ") == 1 then
                        npc:AnimationSub(1)
                        npc:setStatus(tpz.status.DISAPPEAR)
                        npc:setLocalVar("open", 0)
                        npc:setLocalVar("lastOpened", os.time())
                    end
                end)
            end)
        end
    end

    function onEventUpdate(player, csid, option)
    end
    
    function onEventFinish(player, csid, option)
    end