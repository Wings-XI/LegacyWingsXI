-----------------------------------
-- Area: Bhaflau Thickets
--  ZNM: Dea(T3ZNM)
-- Author: Chiefy
-- To do:   As HP decreases, the effective range of "Demoralizing Roar" and "Crippling Slam" expands. -- Need more evidence.
--          Dispel message for boiling blood needs to fixed.
-- Issues:  If mob is never moved after spawning the target:isBehind/isInFront can react weirdly.
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
    mob:setLocalVar("QueuedAbility", 0)
    mob:setLocalVar("[rage]timer", 5400)
end

function onMobWeaponSkillPrepare(mob, target)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local QueuedAbility = mob:getLocalVar("QueuedAbility")

    if skill:getID() == 2101 then
        mob:useMobAbility(2104)
    end
    if skill:getID() == 2102 then
        mob:setLocalVar("QueuedAbility", math.random(1,3))
        if QueuedAbility == 1 then
            mob:useMobAbility(2104)
        elseif QueuedAbility == 2 or 3 then
            if target:isBehind(mob, 96) then
                mob:useMobAbility(2099)
            elseif target:isInfront(mob, 90) then
                mob:useMobAbility(2100)
            else
                mob:useMobAbility(2104)
            end
        end
    end
    local skillID = skill:getID()
    if skillID == 2099 or skillID == 2100 or skillID == 2104 then
        mob:setLocalVar("QueuedAbility", 0)
    end   
end

function onMobFight(mob, target)
    if mob:hasStatusEffect(tpz.effect.PHYSICAL_SHIELD) then
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 100)
    else
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 10)
    end
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
end