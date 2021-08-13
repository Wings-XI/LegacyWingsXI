-----------------------------------
-- Area: Lebros Cavern (Excavation Duty)
-- Mob: Qiqirn Volcanist
-----------------------------------
local ID = require("scripts/zones/Lebros_Cavern/IDs")
----------------------------------- 

function onMobSpawn(mob)
end

function onMobDeath(mob, player, firstCall)
    function onMobDeath(mob, player, firstCall)
        if math.random(0, 100) >= 70 and firstCall then
            local instance = player:getInstance()
            local chars = instance:getChars()
            
            player:addTempItem(5331, 1, 0, 0, 0, 0, 0, 0, 0, 0)
            for _, v in pairs(chars) do
                v:messageName(textTable.PLAYER_OBTAINS_TEM_ITEM, player, 5331)
            end
        end
    end
end

function onMobDespawn(mob)
end
