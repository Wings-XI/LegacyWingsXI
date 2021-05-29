-----------------------------------
-- Area: Monarch Linn
--  Mob: Ouryu
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/status")
require("scripts/globals/magic")
mixins = {require("scripts/mixins/families/wyrm_wakeup")}
-----------------------------------

function onMobSpawn(mob)
    mob:SetMobSkillAttack(0)            
    mob:AnimationSub(0)
    mob:setMobMod(tpz.mobMod.NO_STANDBACK, 1)
    mob:setLocalVar("savageDmgMultipliers", 1)
    mob:setLocalVar("twoHour", 0)
    
    mob:setMobMod(tpz.mobMod.DRAW_IN, 1)
    mob:setMobMod(tpz.mobMod.DRAW_IN_INCLUDE_PARTY, 1)
    mob:setMobMod(tpz.mobMod.DRAW_IN_CUSTOM_RANGE, 15)

    -- mods put fight in line with retail difficulty
    mob:addMod(tpz.mod.SLEEPRESTRAIT, 25)
    mob:addMod(tpz.mod.LULLABYRESTRAIT, 25)
    mob:addMod(tpz.mod.EARTHRES, 1000)
    mob:addMod(tpz.mod.BLINDRESTRAIT, 25)
    mob:addMod(tpz.mod.PARALYZERESTRAIT, 25)
    mob:addMod(tpz.mod.STUNRESTRAIT, 99)
    mob:addMod(tpz.mod.MDEF, 20)
end

function onMobFight(mob, target)
    local bf = mob:getBattlefield()

    -- give up
    if (bf:getID() == 961 and mob:getHPP() < 30) then
        bf:win()
        return
    end

    -- use 2hr
    if (mob:AnimationSub() == 2 and mob:getLocalVar("twoHour") == 0 and mob:getHPP() < 75) then
        mob:useMobAbility(694)
        mob:setLocalVar("twoHour", 1)
    end

    if (mob:hasStatusEffect(tpz.effect.INVINCIBLE) == false and mob:actionQueueEmpty() == true) then
        local changeTime = mob:getLocalVar("changeTime")
        
        -- first flight
        if (mob:AnimationSub() == 0 and not hasSleepEffects(mob) and mob:getBattleTime() - changeTime > 60) then   
            mob:AnimationSub(1)
            mob:addStatusEffectEx(tpz.effect.TOO_HIGH, 0, 1, 0, 0)
            mob:SetMobSkillAttack(731)
            mob:setLocalVar("changeTime", mob:getBattleTime())
        -- land
        elseif (mob:AnimationSub() == 1 and mob:getBattleTime() - changeTime > 120) then
            mob:useMobAbility(1302)                
            mob:setLocalVar("changeTime", mob:getBattleTime())
        -- fly
        elseif (mob:AnimationSub() == 2 and not hasSleepEffects(mob) and mob:getBattleTime() - changeTime > 120) then   
            mob:AnimationSub(1)
            mob:addStatusEffectEx(tpz.effect.TOO_HIGH, 0, 1, 0, 0)
            mob:SetMobSkillAttack(731)
            mob:setLocalVar("changeTime", mob:getBattleTime())
        end
    end
end

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.MIST_MELTER)
end
