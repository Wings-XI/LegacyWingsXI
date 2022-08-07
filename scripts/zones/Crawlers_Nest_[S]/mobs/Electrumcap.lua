-----------------------------------
-- Area: Crawlers' Nest [S]
--  Mob: Electrumcap
-- Note: Items stolen removes caps from head
-----------------------------------
require("scripts/globals/mobs")
require("scripts/globals/world")
-----------------------------------

function onMobSpawn(mob)
    updateRegen(mob)
    mob:AnimationSub(0)
    mob:setStealItemID(4373) -- Woozyshroom is default steal item, needed here in case first action on the mob is steal
    mob:addListener("ITEM_STOLEN", "SHROOM_ITEM_STOLEN", function(mob, player, itemId)
        if mob:AnimationSub() == 0 then
            mob:AnimationSub(1)
        elseif mob:AnimationSub() == 1 then
            mob:AnimationSub(2)
        elseif mob:AnimationSub() == 2 then
            mob:AnimationSub(3)
        end
    end)
end

function onMobInitialize(mob)
end

function onMobEngaged(mob, target)
end

function onMobFight(mob)
    updateRegen(mob)
    
    -- adjust steal item based on the animationsub. This is adjusted by either successfully stealing or by the mob using numbshroom or queezyshroom
    if mob:AnimationSub() == 0 then
        mob:setStealItemID(4373) -- Woozyshroom
    elseif mob:AnimationSub() == 1 then
        mob:setStealItemID(4375) -- Danceshroom
    elseif mob:AnimationSub() == 2 then
        mob:setStealItemID(5680) -- Agaricus
    elseif mob:AnimationSub() == 3 then
        mob:itemStolen() -- Nothing left to steal
    end
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

function onMobDisengage(mob)
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    mob:removeListener("SHROOM_ITEM_STOLEN")
end