-----------------------------------
-- Area: Riverne Site A01
-- Note: Ouryu Cometh
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/status")
require("scripts/globals/magic")
mixins = {require("scripts/mixins/families/wyrm_wakeup")}
-----------------------------------


function onMobSpawn(mob)
    mob:SetMobSkillAttack(0)            
    mob:AnimationSub(0)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:setMobMod(tpz.mobMod.NO_STANDBACK, 1)
    mob:setLocalVar("savageDmgMultipliers", 1)
    mob:setLocalVar("twoHour", 0)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 50)
    mob:addMod(tpz.mod.EARTHRES, 1000)
    mob:addMod(tpz.mod.BLINDRESTRAIT, 25)
    mob:addMod(tpz.mod.PARALYZERESTRAIT, 25)
    mob:addMod(tpz.mod.STUNRES, 100)
    mob:addMod(tpz.mod.SLOWRES, 100)
    mob:setMod(tpz.mod.UDMGRANGE, -50)
    mob:setMod(tpz.mod.MATT, -25)
    mob:setMod(tpz.mod.ATT, -50)
    mob:setMod(tpz.mod.UFASTCAST, 90)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 1)
    mob:setMobMod(tpz.mobMod.DRAW_IN_CUSTOM_RANGE, 15)
    mob:setMobMod(tpz.mobMod.DRAW_IN_FRONT, 1)
end

function onMobEngaged(mob)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
end

function onMobFight(mob, target)
    local twohourTime = mob:getLocalVar("twohour")
    -- use 2hr on 10 min cooldown
    if (mob:getBattleTime()/15 > twohourTime) then
        mob:useMobAbility(694)
        mob:setLocalVar("twohour", math.random((mob:getBattleTime()/15)+36, (mob:getBattleTime()/15)+40))
    end

    if (mob:actionQueueEmpty() == true) then
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

-- Prevents any stuck logic due to wipes
function onMobDisengage(mob)
    mob:setLocalVar("changeTime", 0) 
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENSTONE, {power = math.random(45, 90), chance = 10})
end

function onMobDeath(mob, player, isKiller)
end
