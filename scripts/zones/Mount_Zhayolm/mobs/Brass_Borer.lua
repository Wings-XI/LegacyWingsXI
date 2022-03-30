-----------------------------------
-- Area: Mount Zhayolm
--  ZNM T1: Brass Borer
-- TODO: Halting movement during stance change.
-----------------------------------
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
    mob:setMod(tpz.mod.MOVE, -15)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 3000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 5000)
end

function onMobSpawn(mob)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
    mob:setLocalVar("formTime", os.time() + math.random(43, 47))
    mob:setLocalVar("defUp", math.random(25, 40))
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setLocalVar("usedDefBoost", 1)
end

function onMobRoam(mob)
    local roamTime = mob:getLocalVar("formTime")

    if mob:AnimationSub() == 0 and os.time() > roamTime then
        mob:AnimationSub(1)
        mob:addMod(tpz.mod.MDEF, 10)
        mob:setLocalVar("formTime", os.time() + math.random(43, 47))
    elseif mob:AnimationSub() == 1 and os.time() > roamTime then
        mob:AnimationSub(0)
        mob:delMod(tpz.mod.MDEF, 10)
        mob:setLocalVar("formTime", os.time() + math.random(43, 47))
    end
end

function onMobFight(mob, target)
    local fightTime = mob:getLocalVar("formTime")

    -- per videos on youtube - eventually enters a mode where it spams cannonballs -- https://www.youtube.com/watch?v=QI_a0-eybYY
    if mob:getHPP() > mob:getLocalVar("defUp") then
        if mob:AnimationSub() == 0 and os.time() > fightTime then
            mob:AnimationSub(1)
            mob:addMod(tpz.mod.MDEF, 10)
            mob:setLocalVar("formTime", os.time() + math.random(43, 47))
        elseif mob:AnimationSub() == 1 and os.time() > fightTime then
            mob:AnimationSub(0)
            mob:delMod(tpz.mod.MDEF, 10)
            mob:setLocalVar("formTime", os.time() + math.random(43, 47))
        end
        if (mob:getMobMod(tpz.mobMod.SPECIAL_SKILL) ~= 0) then
            mob:setMobMod(tpz.mobMod.SPECIAL_SKILL, 0)
        end
    else
        -- Cannonball Mode
        if mob:AnimationSub() == 0 then -- ball up
            mob:AnimationSub(1)
            mob:addMod(tpz.mod.MDEF, 10)
        end

        local status = mob:getStatusEffect(tpz.effect.DEFENSE_BOOST)
        if (status == nil and mob:getLocalVar("usedDefBoost") > 0) then -- lost def boost 
            mob:setLocalVar("usedDefBoost", 0)
            for i=1, math.random(3,5) do
                mob:useMobAbility(1815) -- Amber
            end
        elseif (status ~= nil) then
            mob:setLocalVar("usedDefBoost", 1)
        end

        -- Cannonball Mode attacks with Cannonball
        if (mob:getMobMod(tpz.mobMod.SPECIAL_SKILL) ~= 1818) then
            mob:setMobMod(tpz.mobMod.SPECIAL_SKILL, 1818)
        end
    end

    
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENFIRE)
end

function onMobDeath(mob)
end
