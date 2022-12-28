-----------------------------------
-- Area: Wajaom Woodlands
--  ZNM: Tinnin
-- !pos 276 0 -694 51
-- Spawned with Monkey Wine: !additem 2573
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

--[[
    Serpentine Tail: Heavy damage single target or cone attack triggered when someone gets hate from behind.
    If drawn in, you are not automatically the target of the TP move, so it is still important not to get hate from behind as this can result in a Serpentine Tail
      -- seems pretty likely there needs to be explicit code to serp tail if target is behind
      -- could do this in the onmobskillprepare, if target behind then use tail move. Hydra does not have this functionality currently

    Because Tinnin is generally more aggressive while at lower HP, it is advisable to not engage upon spawning in order to allow it to regenerate both of its heads before starting to attack it.
      -- i set him to not claim on trade, but this may be exploitable?

    Has Alliance Hate.
]]

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
        mob:useMobAbility(1832) -- Barofield
        mob:useMobAbility(1830) -- Polar Blast

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
        mob:useMobAbility(1832) -- Barofield
        mob:useMobAbility(1830) -- Polar Blast
        mob:useMobAbility(1828) -- Pyric Blast
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
