-- Puk family mixin
require("scripts/globals/mixins")
require("scripts/globals/status")
require("scripts/globals/world")
-----------------------------------

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.puk = function(mob)
    mob:addListener("SPAWN", "PUK_SPAWN", function(mob)
        mob:setMod(tpz.mod.WIND_ABSORB, 100)
    end)

    mob:addListener("TAKE_DAMAGE", "PUK_TAKE_DAMAGE", function(mob, amount, attacker, attackType, damageType)
        -- If the element corresponding to the elemental day of the in-game Vana'diel week is used on a Puk, it will get 100% TP instantly. 
        if damageType == FIRE and VanadielDayOfTheWeek() == tpz.day.FIRESDAY then
            mob:addTP(3000)
        elseif damageType == EARTH and VanadielDayOfTheWeek() == tpz.day.EARTHSDAY then
            mob:addTP(3000)
        elseif damageType == WATER and VanadielDayOfTheWeek() == tpz.day.WATERSDAY then
            mob:addTP(3000)
        elseif damageType == WIND and VanadielDayOfTheWeek() == tpz.day.WINDSDAY then
            mob:addTP(3000)
        elseif damageType == ICE and VanadielDayOfTheWeek() == tpz.day.ICEDAY then
            mob:addTP(3000)
        elseif damageType == LIGHTNING and VanadielDayOfTheWeek() == tpz.day.LIGHTNINGSDAY then
            mob:addTP(3000)
        elseif damageType == LIGHT and VanadielDayOfTheWeek() == tpz.day.LIGHTSDAY then
            mob:addTP(3000)
        elseif damageType == DARK and VanadielDayOfTheWeek() == tpz.day.DARKSDAY then
            mob:addTP(3000)
        end
    end)

    mob:addListener("ROAM_TICK", "PUK_ROAM_TICK", function(mob)
        if VanadielDayOfTheWeek() == tpz.day.WINDSDAY and mob:getMod(tpz.mod.REGAIN) == 0 then
            mob:setMod(tpz.mod.REGAIN, 30)
        elseif VanadielDayOfTheWeek() ~= tpz.day.WINDSDAY and mob:getMod(tpz.mod.REGAIN) ~= 0 then
            mob:setMod(tpz.mod.REGAIN, 0)
        end
    end
end

return g_mixins.families.puk