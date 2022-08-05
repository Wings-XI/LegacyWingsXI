-----------------------------------
-- Area: Bhaflau Thickets
--  ZNM: Dea(T3ZNM)
-- To do: As HP decreases, the effective range of "Demoralizing Roar" and "Cripling Slam" expands. -- Need more evidence.
-----------------------------------
--mixins = {require("scripts/mixins/rage")}
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:setLocalVar("SetAbility", math.random(1,3))
    mob:setLocalVar("QuedAbility", 0)
    mob:setLocalVar("Crippling", 0)
end

function onMobWeaponSkillPrepare(mob, target)
    local SetAbility = mob:getLocalVar("SetAbility")
    local QuedAbility = mob:getLocalVar("QuedAbility")
    local Crippling = mob:getLocalVar("Crippling")

    if skill:getID() == 2101 then
        Crippling = 1
    end
    if skill:getID() == 2102 then
        if SetAbility = 1 then
            QuedAbility = 1
        elseif SetAbility = 2 or 3 then
            QuedAbility = 2
        end
        --mob:setLocalVar("SetAbility", math.random(1,3))
        --mob:useMobAbility(QuedAbility)
    end
    return 2101
end

function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 2099 or 2100 or 2104 then
        Crippling = 0
        QuedAbility = 0
        SetAbility = math.random(1,3)
end

function onMobFight(mob, target)
    if mob:hasStatusEffect(tpz.effect.PHYSICAL_SHIELD) then
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 100)
    else
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 10)
    end

    if Crippling = 1 then
        mob:useMobAbility(2104)
    end
    if QuedAbility = 1 then
        mob:useMobAbility(2104)
    elseif QuedAbility = 2 then
        if target:isBehind(mob, 96) then
            mob:useMobAbility(2100)
        elseif target:isInfront(mob, 90) then
            mob:useMobAbility(2099)
        end
    end
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
end