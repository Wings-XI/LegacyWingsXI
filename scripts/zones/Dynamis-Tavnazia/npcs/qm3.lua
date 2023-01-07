-----------------------------------
-- Area: Dynamis-Valkrum
--  NPC: ??? (qm2)
-- Note: Provides Time and more mobs on floors 1 and 2
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------

function onTrigger(player, npc)
    local ID = require("scripts/zones/Dynamis-Tavnazia/IDs")
    local extendMsg = 7315

    if npc:getLocalVar("activated") == 0 then
        player:addTimeToDynamis(30, extendMsg)
        local wave = 0
        if npc:getID() == ID.mobs.QM3_Floor1 then
            wave = 2
        else
            wave = 3
        end
        dynamis.spawnWave(mobList[npc:getZoneID()], wave)
    end
    
    npc:setLocalVar("activated", 1)
end

