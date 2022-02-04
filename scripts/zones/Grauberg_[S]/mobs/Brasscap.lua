-----------------------------------
-- Area: Grauberg [S]
--  Mob: Brasscap
-- Note: Items stolen removes caps from head
-----------------------------------
local ID = require("scripts/zones/Grauberg_[S]/IDs")
require("scripts/globals/mobs")
-----------------------------------

function onMobSpawn(mob)
end

function onMobEngaged(mob, target)
    mob:addListener("ITEM_STOLEN", "SHROOM_ITEM_STOLEN", function(mob, player, itemId)
        if itemId == 4373 then
            mob:AnimationSub(1)
        elseif itemId == 4375 then 
            mob:AnimationSub(2)
        elseif itemId == 5680 then
            mob:AnimationSub(3)
        end
    end)
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
end