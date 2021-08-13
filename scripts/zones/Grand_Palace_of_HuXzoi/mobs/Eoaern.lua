-----------------------------------
-- Area: Grand Palace of Hu'Xzoi
--  Mob: Eo'aern
-----------------------------------
mixins = {require("scripts/mixins/families/aern")}
require("scripts/globals/status")
-----------------------------------

function onMobEngaged(mob, target)
    mob:setLocalVar("changeTime", 0)
end

function onMobFight(mob, target)
    local battleTime = mob:getBattleTime()
    local changeTime = mob:getLocalVar("changeTime")

    if mob:getHPP() < 100 then
        if mob:AnimationSub() == 0 then -- bracers trigger initially upon taking damage
            mob:AnimationSub(2)
            mob:addMod(tpz.mod.ATTP, 30)
            mob:setLocalVar("changeTime", mob:getBattleTime())
        elseif mob:AnimationSub() == 2 and battleTime - changeTime >= 30 then -- bracer mode lasts 30 seconds
            mob:AnimationSub(1)
            mob:delMod(tpz.mod.ATTP, 30)
            mob:setLocalVar("changeTime", mob:getBattleTime())
        elseif mob:AnimationSub() == 1 and battleTime - changeTime >= 120 then -- bracemode 2 minute cooldown
            mob:AnimationSub(2)
            mob:addMod(tpz.mod.ATTP, 30)
            mob:setLocalVar("changeTime", mob:getBattleTime())
        end
    end
end

function onMobDisengage(mob)
    mob:AnimationSub(0)
end

function onMobDeath(mob, player, isKiller)
end
