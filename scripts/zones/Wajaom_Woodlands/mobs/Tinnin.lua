-----------------------------------
-- Area: Wajaom Woodlands
--  ZNM: Tinnin
-- !pos 276 0 -694
-- Spawned with Monkey Wine: @additem 2573
-- Wiki: http://ffxiclopedia.wikia.com/wiki/Tinnin
-----------------------------------
mixins =
{
    require("scripts/mixins/job_special"),
    require("scripts/mixins/rage")
}
require("scripts/globals/magic")
require("scripts/globals/status")
-----------------------------------

--[[ used only when second (Hydra's right-- our left) head is alive:

    Polar Blast: Ice-based Breath Attack Resist Vs. Ice and Paralyze Paralyze; wipes shadows
    Pyric Blast: Fire-based Breath Attack Resist Vs. Fire and Plague Plague; wipes shadows]]

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 12000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 30000)
    mob:setMobMod(tpz.mobMod.MUG_GIL, 8000)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 1)
    mob:setMod(tpz.mod.UDMGBREATH, -100) -- immune to breath damage
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
end

function onMobSpawn(mob)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
    mob:setHP(mob:getMaxHP()/2)
    mob:setUnkillable(true)
    mob:setMod(tpz.mod.REGEN, 50)

    -- Regen Head every 1.5-4 minutes 90-240
    mob:setLocalVar("headTimer", os.time() + math.random(60, 190))

    -- Number of crits to lose a head
    mob:setLocalVar("CritToTheFace", math.random(10, 30))
    mob:setLocalVar("crits", 0)
end

function onMobRoam(mob)
    -- Regen head
    local headTimer = mob:getLocalVar("headTimer")
    if (mob:AnimationSub() == 2 and os.time() > headTimer) then
        mob:AnimationSub(1)
        mob:setLocalVar("headTimer", os.time() + math.random(60, 190))

        -- First time it regens second head, 25%. Reduced afterwards.
        if (mob:getLocalVar("secondHead") == 0) then
            mob:addHP(mob:getMaxHP() * .25)
            mob:setLocalVar("secondHead", 1)
        else
            mob:addHP(mob:getMaxHP() * .05)
        end

    elseif (mob:AnimationSub() == 1 and os.time() > headTimer) then
        mob:AnimationSub(0)
        mob:setLocalVar("headTimer", os.time() + math.random(60, 190))

        -- First time it regens third head, 25%. Reduced afterwards.
        if (mob:getLocalVar("thirdHead") == 0) then
            mob:addHP(mob:getMaxHP() * .25)
            mob:setMod(tpz.mod.REGEN, 10)
            mob:setLocalVar("thirdHead", 1)
            mob:setUnkillable(false) -- It can be killed now that has all his heads
        else
            mob:addHP(mob:getMaxHP() * .05)
        end
    end
end

function onMobFight(mob, target)
    -- Mowford, I cant test locally right away if you can help me with the animation subs below
    -- There are two skill lists Hyrda can do depending on if Hydra's right-- our left) head is alive

    if mob:AnimationSub() == 1 then -- I want this to be the case if the above head is DEAD (check animaiton sub please)
        -- There may be 2 animation subs (one for all heads dead, one for only the left being dead)
        mob:setSkillList(5307) 
    else -- Any other animation sub, but the left head is alive (meaning all heads up, or right head only is dead)
        mob:setSkillList(313)
    end



    -- Mowford, the stuff i added is above this line :)
    local headTimer = mob:getLocalVar("headTimer")
    if (mob:AnimationSub() == 2 and os.time() > headTimer) then
        mob:AnimationSub(1)
        mob:setLocalVar("headTimer", os.time() + math.random(60, 190))

        -- First time it regens second head, 25%. Reduced afterwards.
        if (mob:getLocalVar("secondHead") == 0) then
            mob:addHP(mob:getMaxHP() * .25)
            mob:setLocalVar("secondHead", 1)
        else
            mob:addHP(mob:getMaxHP() * .05)
        end
        if (bit.band(mob:getBehaviour(), tpz.behavior.NO_TURN) > 0) then -- disable no turning for the forced mobskills upon head growth
            mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(tpz.behavior.NO_TURN)))
        end
        -- These need to be listed in reverse order as forced moves are added to the top of the queue.
        mob:useMobAbility(1830) -- Polar Blast
        mob:useMobAbility(1832) -- Barofield

    elseif (mob:AnimationSub() == 1 and os.time() > headTimer) then
        mob:AnimationSub(0)
        mob:setLocalVar("headTimer", os.time() + math.random(60, 190))

        -- First time it regens third head, 25%. Reduced afterwards.
        if (mob:getLocalVar("thirdHead") == 0) then
            mob:setMod(tpz.mod.REGEN, 10)
            mob:addHP(mob:getMaxHP() * .25)
            mob:setLocalVar("thirdHead", 1)
            mob:setUnkillable(false) -- It can be killed now that has all his heads
        else
            mob:addHP(mob:getMaxHP() * .05)
        end
        if (bit.band(mob:getBehaviour(), tpz.behavior.NO_TURN) > 0) then -- disable no turning for the forced mobskills upon head growth
            mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(tpz.behavior.NO_TURN)))
        end
        -- Reverse order, same deal.
        mob:useMobAbility(1828) -- Pyric Blast
        mob:useMobAbility(1830) -- Polar Blast
        mob:useMobAbility(1832) -- Barofield
    end
end

function onCriticalHit(mob)
    local critNum = mob:getLocalVar("crits")

    if ((critNum+1) > mob:getLocalVar("CritToTheFace")) then  -- Lose a head
        if (mob:AnimationSub() == 0) then
            mob:AnimationSub(1)
            mob:setLocalVar("headTimer", os.time() + math.random(60, 190))
        elseif (mob:AnimationSub() == 1) then
            mob:AnimationSub(2)
            mob:setLocalVar("headTimer", os.time() + math.random(60, 190))
        else
            -- Meh
        end

        -- Number of crits to lose a head, re-randoming
        mob:setLocalVar("CritToTheFace", math.random(10, 30))

        critNum = 0 -- reset the crits on the NM
    else
        critNum = critNum + 1
    end
    mob:setLocalVar("crits", critNum)
end

function onMobDrawIn(mob, target)
    mob:addTP(3000) -- Uses a mobskill upon drawing in a player. Not necessarily on the person drawn in.
end

function onMobDeath(mob, player, isKiller)
end
