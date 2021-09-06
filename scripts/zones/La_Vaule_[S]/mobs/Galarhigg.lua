-----------------------------------
-- Area: La Vaule [S]
--  Mob: Galarhigg
--  BCNM: Purple the New Black
-----------------------------------
require("scripts/globals/status")
-----------------------------------

-- skill 624, animation ID 434 = 2 hour and green - wind breath
-- skill 626, animation ID 437 = 2 hour and white - poison breath
-- skill 603, animation ID 432 = 2 hour and blue - flame breath
-- sub 20%, trigger
-- skill 307, animation ID 439 = 2 hour and blue - chaos blade
function triggerStanceChange(mob)
    
    local currentEleAbsorb = mob:getLocalVar("CurrentAbsorb")
    if (mob:getHPP() <= 20 and math.random() < 0.75) then
        mob:useMobAbility(307)
        return
    end

    -- dont change to the currently active mode
    if (currentEleAbsorb ~= 0) then
        if currentEleAbsorb == tpz.mod.WIND_ABSORB then
            if (math.random(1, 2) == 1) then
                mob:useMobAbility(626)
            else
                mob:useMobAbility(603)
            end
        elseif currentEleAbsorb == tpz.mod.WATER_ABSORB then
            if (math.random(1, 2) == 1) then
                mob:useMobAbility(624)
            else
                mob:useMobAbility(603)
            end
        elseif currentEleAbsorb == tpz.mod.FIRE_ABSORB then
            if (math.random(1, 2) == 1) then
                mob:useMobAbility(626)
            else
                mob:useMobAbility(624)
            end
        end
    else
        -- pick one at random - no current absorb
        local random = math.random(1, 3)

        if random == 1 then
             mob:useMobAbility(624)
        elseif random == 2 then
            mob:useMobAbility(626)
        else
            mob:useMobAbility(603)
        end
    end
    
end

function onMobInitialize(mob)
    mob:setMod(tpz.mod.SLEEPRESTRAIT, 100)
    mob:setMod(tpz.mod.LULLABYRESTRAIT, 100)
    mob:setMod(tpz.mod.PETRIFYRESTRAIT, 100)
    mob:setMod(tpz.mod.BINDRESTRAIT, 100)
    mob:setMod(tpz.mod.GRAVITYRESTRAIT, 100)
    mob:setMod(tpz.mod.REGAIN, 100) -- slight regain evident by immediate tp move if people take a long time to engage (not the initial breath-2hour, another move)
    mob:setMod(tpz.mod.ACC, 200) -- this thing rarely misses

    mob:setMobMod(tpz.mobMod.GIL_MAX, -1);
    mob:setMobMod(tpz.mobMod.MUG_GIL, -1);
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100);

    mob:setMobMod(tpz.mobMod.DRAW_IN, 1) -- has draw in


    -- From the captures I've watched (especially https://www.youtube.com/watch?v=wcyu2YN8Tyg) everything points to Galarhigg triggering his stance change per amount of damage taken
    -- its absolutely not time based and its absolutely not HPP based.  However, every 15% or so dmg taken, it triggers
    -- Also, I've only ever observerd the Chaos Blade 2hour trigger sub 20%.  That observation may only be RNG based, however with an 80% curse its reasonable to assume there is some gating
    mob:addListener("TAKE_DAMAGE", "GALARHIGG_TAKE_DAMAGE", function(mob, amount, attacker, attackType, damageType)
        if(amount > mob:getHP()) then
            return
        end

        if (amount > 0) then
            local newDamageAmount = mob:getLocalVar("DamageTaken") + amount
            if newDamageAmount >= 1650 then
                -- Galarhigg has taken 15% of its health - trigger a stance change and a breath.  Wiki says 12k heath - captures have ~11k
                mob:setLocalVar("DamageTaken", 0)
                triggerStanceChange(mob)
            else
                mob:setLocalVar("DamageTaken", newDamageAmount)
            end
        end
    end)
end

function onMobEngaged(mob, target)
    triggerStanceChange(mob)
end

function onMobWeaponSkill(target, mob, skill)
    local skillID = skill:getID()
        
    if (skillID == 624 or skillID == 626 or skillID == 603 or skillID == 307) then
        -- first clean up any old ele absorb
        local currentEleAbsorb = mob:getLocalVar("CurrentAbsorb")
        if (currentEleAbsorb) then
            mob:delMod(currentEleAbsorb, 100)
        end

        -- then apply new ele absorb and trigger breath
        if skillID == 624 then
            currentEleAbsorb = tpz.mod.WIND_ABSORB
            mob:useMobAbility(644) -- wind breath
        elseif skillID == 626 then
            currentEleAbsorb = tpz.mod.WATER_ABSORB
            mob:useMobAbility(643) -- poison breath
        elseif skillID == 603 then
            currentEleAbsorb = tpz.mod.FIRE_ABSORB
            mob:useMobAbility(642) -- fire breath
        elseif skillID == 307 then
            currentEleAbsorb = tpz.mod.NONE
            -- capture tested all elements - nothing absrobed
            mob:useMobAbility(647) -- chaos blade
        end

        mob:addMod(currentEleAbsorb, 100)
        mob:setLocalVar("CurrentAbsorb", currentEleAbsorb)
    end
end

function onMobWeaponSkillPrepare(mob, target)
end

function onMobFight(mob, target)

end

function onMobDeath(mob, player, isKiller)
   
end