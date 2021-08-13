-----------------------------------
-- Area: The Garden of Ru'Hmet
--  Mob: Kf'ghrah BLM
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------

function onMobSpawn(mob)
    -- Set core Skin and mob elemental bonus
    mob:AnimationSub(0)
    mob:setLocalVar("roamTime", os.time())
    mob:setModelId(1168) -- Dark
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 60)
end

function onMobRoam(mob)
    local roamTime = mob:getLocalVar("roamTime")
    local roamForm
    if (os.time() - roamTime > 60) then
        roamForm = math.random(1, 3) -- forms 2 and 3 are spider and bird; can change forms at will
        if (roamForm == 1) then
            roamForm = 0 -- We don't want form 1 as that's humanoid - make it 0 for ball
        end
        mob:AnimationSub(roamForm)
        mob:setLocalVar("roamTime", os.time())
    end
end

function onMonsterMagicPrepare(mob, target)
    local rnd = math.random()
    if rnd < 0.2 then
        return 274 -- sleepga II
    elseif rnd < 0.6 then
        return 254 -- blind
    else
        return 232 -- bio III
    end
end

function onMobFight(mob, target)
    local changeTime = mob:getLocalVar("changeTime")
    local battleForm

    if (mob:getBattleTime() - changeTime > 60) then
        battleForm = math.random(1, 3) -- same deal as above
        if (battleForm == 1) then
            battleForm = 0
        end
        mob:AnimationSub(battleForm)
        mob:setLocalVar("changeTime", mob:getBattleTime())
        if mob:AnimationSub() == 0 then
            mob:SetMagicCastingEnabled(true) -- will only cast magic in ball form
        else
            mob:SetMagicCastingEnabled(false)
        end
    end
end

function onMobDeath(mob, player, isKiller)
end
