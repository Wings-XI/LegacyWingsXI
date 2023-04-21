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
    local skillID = skill:getID()

    if skillID == 2101 then
        -- Crippling slam after Demoralizing Roar
        mob:setLocalVar("QueuedAbility", 1)
    elseif skillID == 2102 then
        -- Random skill based on target's position after boiling blood
        mob:setLocalVar("QueuedAbility", 2)
    else
        -- Ensure we don't have a queued ability
        mob:setLocalVar("QueuedAbility", 0)
    end
end

function onMobFight(mob, target)
    local QueuedAbility = mob:getLocalVar("QueuedAbility")
    if QueuedAbility > 0 and mob:actionQueueEmpty() then
        mob:setLocalVar("QueuedAbility", 0)
        -- queue ability (only one) in one place to avoid a race condition in spamming TP moves

        if QueuedAbility == 1 then
            mob:useMobAbility(2104)
        elseif QueuedAbility == 2 then
            if math.random(1,3) == 1 then
                mob:useMobAbility(2104)
            else
                if target:isBehind(mob, 96) then
                    mob:useMobAbility(2099)
                elseif target:isInfront(mob, 90) then
                    mob:useMobAbility(2100)
                else
                    mob:useMobAbility(2104)
                end
            end
        end
    end

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