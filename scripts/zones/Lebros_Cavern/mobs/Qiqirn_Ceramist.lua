-----------------------------------
-- Area: Lebros Cavern (Excavation Duty)
-- Mob: Qiqirn Ceramist
-----------------------------------
local ID = require("scripts/zones/Lebros_Cavern/IDs")
-----------------------------------

function onMobSpawn(mob)
end

function onMobDeath(mob, player, firstCall)
    if math.random(0, 100) >= 70 and firstCall then
        player:addTempItem(5331, 1, 0, 0, 0, 0, 0, 0, 0, 0)
        player:messageSpecial(ID.text.TEMP_ITEM, 5331)
    end
end

function onMobDespawn(mob)
end
