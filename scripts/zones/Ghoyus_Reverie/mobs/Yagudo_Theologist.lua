-----------------------------------
-- Area: Ghoyus_Reverie
--  Mob: Yagudo Theologist
-----------------------------------
require("scripts/globals/instance")
-----------------------------------

function onMobInitialize(mob)
    mob:setMod(tpz.mod.SLEEPRESTRAIT, 100) -- immune to sleep
    mob:setMod(tpz.mod.ATT, -100) -- mobs are very weak
    mob:setMod(tpz.mod.RATT, -100) 
    mob:setMod(tpz.mod.MATT, -90)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.MUG_GIL, -1)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setTrueDetection(1)
    mob:addListener("TAKE_DAMAGE", "THEOLOGIST_TAKE_DAMAGE", function(mob, amount, attacker, attackType, damageType)
        if amount >= mob:getHP() then

            local random = math.random(1, 100)

            if random <= 5 then
                mob:setUnkillable(true)
                mob:setLocalVar("Regain", 1)
            elseif random <= 10 then
                mob:setUnkillable(true)
                mob:setLocalVar("Regain", 2)
            elseif random <= 15 then
                mob:setUnkillable(true)
                mob:setLocalVar("Regain", 3)
            end
        end
    end)
end

function onMobRoam(mob)
end

function onMobFight(mob)
    -- Due to what I believe to be a timing issue - the ability will not always trigger in the listener
    -- To ensure at least once delivery of a tp move - set ability usage in onFight
    -- Due to animation delay and the quick killing of the mob on skill usage - ability will not double trigger
    if mob:getLocalVar("Regain") == 1 then
         mob:useMobAbility(1124) -- restore hp for those within 25 yalms
    elseif mob:getLocalVar("Regain") == 2 then
         mob:useMobAbility(1125) -- restore mp for those within 25 yalms
    elseif mob:getLocalVar("Regain") == 3 then
         mob:useMobAbility(1126) -- restore tp for those within 25 yalms
    end
end

function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 1124 or skill:getID() == 1125 or skill:getID() == 1126 then
        mob:setUnkillable(false)
        mob:setLocalVar("Regain", 0)
        mob:setHP(0)
    end
end

function onMobDespawn(mob)
    local instance = mob:getInstance()
    instance:setProgress(instance:getProgress()+1)
    mob:setSpawn(-141.111, -0.420, 163.878)
end

function onMobDeath(mob, player, isKiller)
end