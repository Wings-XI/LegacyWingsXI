-----------------------------------
-- Area: North Gustaberg [S]
--  Mob: Coppercap
-- Note: PH for Gloomanita
-- Note: Items stolen removes caps from head
-----------------------------------
local ID = require("scripts/zones/North_Gustaberg_[S]/IDs")
require("scripts/globals/mobs")
require("scripts/globals/world")
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
    tpz.mob.phOnDespawn(mob, ID.mob.GLOOMANITA_PH, 10, 3600) -- 1 hour
end