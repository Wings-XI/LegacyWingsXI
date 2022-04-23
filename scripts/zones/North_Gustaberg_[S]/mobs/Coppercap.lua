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
    mob:setStealItemID(4373) -- Woozyshroom
end

function onMobEngaged(mob, target)
    mob:addListener("ITEM_STOLEN", "ITEM_STOLEN", function(mob, player, itemId)
        if itemId == 4373 then
            mob:AnimationSub(1)
            mob:setStealItemID(4375) -- Danceshroom
        elseif itemId == 4375 then
            mob:AnimationSub(2)
            mob:setStealItemID(5680) -- Agaricus
        elseif itemId == 5680 then
            mob:AnimationSub(3)
        end
    end)
end

function onMobDisengage(mob)
    mob:removeListener("ITEM_STOLEN")
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.GLOOMANITA_PH, 10, 3600) -- 1 hour
end