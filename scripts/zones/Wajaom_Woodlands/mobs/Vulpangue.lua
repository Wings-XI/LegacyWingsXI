-----------------------------------
-- Area: Wajaom Woodlands
--  ZNM T1: Vulpangue
-----------------------------------
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/status")
-----------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 3000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 5000)
end

function onMobSpawn(mob)
    mob:addMod((tpz.mod.FIRE_ABSORB + VanadielDayElement() - 1), 100)
    mob:addMod(tpz.mod.WIND_ABSORB, 100)
    mob:setMod(tpz.mod.ATT, 350) -- hits notably hard
    mob:setLocalVar("HPP", 90)
end

function onMobFight(mob, target)
    local defUpHPP = mob:getLocalVar("HPP")
    if mob:getHPP() <= defUpHPP then
        if mob:getHPP() > 10 then
            mob:addMod(tpz.mod.ACC, 10)
            mob:addMod(tpz.mod.ATT, 10)
            mob:setLocalVar("HPP", mob:getHPP() - 10)
        end
    end
end

function onMobDeath(mob, killer)
end
