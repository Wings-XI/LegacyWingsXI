-----------------------------------
-- Area: Pashhow Marshlands [S]
--  Mob: Electrumcap
-- Note: Items stolen removes caps from head
-----------------------------------
require("scripts/globals/mobs")
require("scripts/globals/world")
-----------------------------------

function onMobSpawn(mob)
    mob:setStealItemID(4373) -- Woozyshroom
    updateRegen(mob)
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

function onMobFight(mob)
    updateRegen(mob)
end

function onMobRoam(mob)
    updateRegen(mob)
end

function updateRegen(mob)
    if mob:getWeather() == tpz.weather.RAIN or mob:getWeather() == tpz.weather.SQUALL then
        mob:setMod(tpz.mod.REGEN, 9) -- 1% per 12s from retail capture
    else
        mob:setMod(tpz.mod.REGEN, 0)
    end
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
end