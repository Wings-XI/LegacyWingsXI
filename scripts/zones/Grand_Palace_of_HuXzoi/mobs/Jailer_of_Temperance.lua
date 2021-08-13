-----------------------------------
-- Area: Grand Palace of Hu'Xzoi
--   NM: Jailer of Temperance
-----------------------------------
local ID = require("scripts/zones/Grand_Palace_of_HuXzoi/IDs")
require("scripts/zones/Grand_Palace_of_HuXzoi/globals")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------

function onMobSpawn(mob)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {
                id = tpz.jsa.MEIKYO_SHISUI, 
                hpp = math.random(65, 75),
                endCode = function(mob)
                    mob:setLocalVar("twoHour", 1)
                end
            },
        },
    })
    mob:SetAutoAttackEnabled(true)
    mob:SetMobAbilityEnabled(true)
    mob:AnimationSub(0) -- Change animation to pot
    -- Set the damage resists
    mob:setMod(tpz.mod.HTHRES, 1000)
    mob:setMod(tpz.mod.SLASHRES, 0)
    mob:setMod(tpz.mod.PIERCERES, 0)
    mob:setMod(tpz.mod.IMPACTRES, 1000)
    -- Set the magic resists. It always takes no damage from direct magic
    for n =1, #tpz.magic.resistMod, 1 do
        mob:setMod(tpz.magic.resistMod[n], 0)
    end
    for n =1, #tpz.magic.defenseMod, 1 do
        mob:setMod(tpz.magic.defenseMod[n], 1000)
    end
end

function onMobEngaged(mob, target)
    mob:setLocalVar("changeTime", 0)
end

function onMobFight(mob)
    -- Forms: 0 = Pot  1 = Pot  2 = Poles  3 = Rings
    local randomTime = math.random(30, 180)
    local changeTime = mob:getLocalVar("changeTime")

    local isBusy = false
    local act = mob:getCurrentAction()
    if act == tpz.act.MOBABILITY_START or act == tpz.act.MOBABILITY_USING or act == tpz.act.MOBABILITY_FINISH then
            isBusy = true -- we don't want to change forms while charging optic induration
    end

    -- If we're in a pot form, but going to change to either Rings/Poles
    if (mob:AnimationSub() <= 1 and mob:getBattleTime() - changeTime > randomTime and not isBusy) then
        local aniChange = math.random(2, 3)
        mob:AnimationSub(aniChange)

        -- We changed to Poles. Make it only take piercing.
        if (aniChange == 2) then
            mob:setMod(tpz.mod.HTHRES, 0)
            mob:setMod(tpz.mod.SLASHRES, 0)
            mob:setMod(tpz.mod.PIERCERES, 1000)
            mob:setMod(tpz.mod.IMPACTRES, 0)
            mob:setLocalVar("changeTime", mob:getBattleTime())
        else -- We changed to Rings. Make it only take slashing.
            mob:setMod(tpz.mod.HTHRES, 0)
            mob:setMod(tpz.mod.SLASHRES, 1000)
            mob:setMod(tpz.mod.PIERCERES, 0)
            mob:setMod(tpz.mod.IMPACTRES, 0)
            mob:setLocalVar("changeTime", mob:getBattleTime())
        end
    -- We're in poles, but changing
    elseif (mob:AnimationSub() == 2 and mob:getBattleTime() - changeTime > randomTime and not isBusy) then
        local aniChange = math.random(0, 1)

        -- Changing to Pot, only take Blunt damage
        if (aniChange == 0) then
            mob:AnimationSub(0)
            mob:setMod(tpz.mod.HTHRES, 1000)
            mob:setMod(tpz.mod.SLASHRES, 0)
            mob:setMod(tpz.mod.PIERCERES, 0)
            mob:setMod(tpz.mod.IMPACTRES, 1000)
            mob:setLocalVar("changeTime", mob:getBattleTime())
        else -- Going to Rings, only take slashing
            mob:AnimationSub(3)
            mob:setMod(tpz.mod.HTHRES, 0)
            mob:setMod(tpz.mod.SLASHRES, 1000)
            mob:setMod(tpz.mod.PIERCERES, 0)
            mob:setMod(tpz.mod.IMPACTRES, 0)
            mob:setLocalVar("changeTime", mob:getBattleTime())
        end
    -- We're in rings, but going to change to pot or poles
    elseif (mob:AnimationSub() == 3 and mob:getBattleTime() - changeTime > randomTime and not isBusy) then
        local aniChange = math.random(0, 2)
        mob:AnimationSub(aniChange)

        -- We're changing to pot form, only take blunt damage.
        if (aniChange == 0 or aniChange == 1) then
            mob:setMod(tpz.mod.HTHRES, 1000)
            mob:setMod(tpz.mod.SLASHRES, 0)
            mob:setMod(tpz.mod.PIERCERES, 0)
            mob:setMod(tpz.mod.IMPACTRES, 1000)
            mob:setLocalVar("changeTime", mob:getBattleTime())
        else -- Changing to poles, only take piercing
            mob:setMod(tpz.mod.HTHRES, 0)
            mob:setMod(tpz.mod.SLASHRES, 0)
            mob:setMod(tpz.mod.PIERCERES, 1000)
            mob:setMod(tpz.mod.IMPACTRES, 0)
            mob:setLocalVar("changeTime", mob:getBattleTime())
        end
    end

    if mob:getHPP() < 40 and mob:getLocalVar("twoHour") == 1 then -- Jailer of Temperance uses second two hour around 40%
        mob:useMobAbility(730)
        mob:setLocalVar("twoHour", 2)
    end

end

function onMobWeaponSkill(target, mob, skill)
    local skill = skill:getID()
    local charge = mob:getLocalVar("charge")
    if skill == 1464 then
        local opticCounter = mob:getLocalVar("opticCounter")

        opticCounter = opticCounter +1
        mob:setLocalVar("opticCounter", opticCounter)

        if (opticCounter > 0) then
            mob:setLocalVar("opticCounter", 0)
            mob:setLocalVar("opticInduration", 1)
            chargeOptic(mob)
        end

    elseif id == 1465 and charge == 0 then
        mob:timer(3000, function(mob)
            mob:useMobAbility(1465) -- JoT will use another Optic Induration shortly after using the first one.
            mob:setLocalVar("charge", 1)
            mob:timer(2000, function(mob)
                mob:setLocalVar("charge", 0)
            end)
        end)
    end
end

function chargeOptic(mob)
    mob:SetAutoAttackEnabled(false)
    mob:SetMobAbilityEnabled(false)

    if mob:getLocalVar("opticInduration") ~= 1 then
        mob:timer(3500, function(mob)
            mob:useMobAbility(1464)
        end)
    elseif mob:getLocalVar("opticInduration") == 1 then
        mob:useMobAbility(1465)
        mob:setLocalVar("opticInduration", 0)
        mob:SetAutoAttackEnabled(true)
        mob:SetMobAbilityEnabled(true)
        mob:timer(3000, function(mob)
            mob:useMobAbility(1465) -- JoT will use another Optic Induration shortly after using the first one.
        end)
    end
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    local ph = mob:getLocalVar("ph")
    DisallowRespawn(mob:getID(), true)
    DisallowRespawn(ph, false)
    GetMobByID(ph):setRespawnTime(GetMobRespawnTime(ph))
    mob:setLocalVar("pop", os.time() + 900) -- 15 mins
    GRAND_PALACE_OF_HUXZOI.pickTemperancePH()
end
