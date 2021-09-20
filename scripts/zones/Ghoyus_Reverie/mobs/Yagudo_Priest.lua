-----------------------------------
-- Area: Ghoyus_Reverie
--  Mob: Yagudo Priest
-----------------------------------
require("scripts/globals/instance")
-----------------------------------

function onMobInitialize(mob)
    mob:setMod(tpz.mod.SLEEPRESTRAIT, 100) -- immune to sleep
    mob:setMod(tpz.mod.LULLABYRESTRAIT, 100)
    mob:setMod(tpz.mod.ATT, -100) -- mobs are very weak
    mob:setMod(tpz.mod.RATT, -100) 
    mob:setMod(tpz.mod.MATT, -90)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.MUG_GIL, -1)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setTrueDetection(1)
    mob:addListener("TAKE_DAMAGE", "PRIEST_TAKE_DAMAGE", function(mob, amount, attacker, attackType, damageType)
        if amount >= mob:getHP() then
            local random = math.random(1, 100)

            if random <= 5 then
                forceTPMove(mob, 1)
            elseif random <= 10 then
                forceTPMove(mob, 2)
            elseif random <= 15 then
                forceTPMove(mob, 3)
            end
        end
    end)
end

function onMobRoam(mob)
end

function onMobFight(mob)
    -- Due to what I believe to be a timing issue - the ability will not always trigger in the listener
    -- To ensure at least once delivery of a tp move - set ability usage in onFight
    if mob:getLocalVar("Regain") == 1 then
         mob:useMobAbility(1124) -- restore hp for those within 25 yalms
    elseif mob:getLocalVar("Regain") == 2 then
         mob:useMobAbility(1125) -- restore mp for those within 25 yalms
    elseif mob:getLocalVar("Regain") == 3 then
         mob:useMobAbility(1126) -- restore tp for those within 25 yalms
    end

    -- trigger stage 1 on aggro as well
    local instance = mob:getInstance()
    if instance:getStage() == 0 then
        instance:setStage(1)
    end
end

function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 1124 or skill:getID() == 1125 or skill:getID() == 1126 then
        mob:setUnkillable(false)
        mob:setLocalVar("Regain", 0)
        mob:setHP(0)
        mob:SetAutoAttackEnabled(true)
        mob:SetMagicCastingEnabled(true)
        mob:SetMobAbilityEnabled(true)
    end
end

function onMobDespawn(mob)
    local instance = mob:getInstance()
    instance:setProgress(instance:getProgress()+1)
    mob:setSpawn(-141.111, -0.420, 163.878)
end

function onMobDeath(mob, player, isKiller)
end

function forceTPMove(mob, move)
    mob:setUnkillable(true)
    mob:SetAutoAttackEnabled(false)
    mob:SetMagicCastingEnabled(false)
    mob:SetMobAbilityEnabled(false)
    mob:setLocalVar("Regain", move)
end