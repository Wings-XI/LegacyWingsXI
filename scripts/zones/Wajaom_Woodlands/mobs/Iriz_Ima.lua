-----------------------------------
-- Area: Wajaom Woodlands
--  ZNM: Iriz Ima
-----------------------------------
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 4500)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 7500)
end

function onMobSpawn(mob)
    mob:setLocalVar("[rage]timer", 4500)
    mob:setLocalVar("BreakChance", 5)
    mob:setMod(tpz.mod.MOVE, -15)
end

function onMobWeaponSkillPrepare(mob, target)
    if mob:getHPP() <= 50 and math.random() < 0.2 then
        return 1708
    end
end

function onMobWeaponSkill(target, mob, skill)
    if  skill:getID() == 1704 then -- (Onrush)
        mob:lowerEnmity(target, 20)
    end

    if skill:getID() == 1704 then
        local OnrushCounter = mob:getLocalVar("OnrushCounter")
        local OnrushMax = mob:getLocalVar("OnrushMax")

        if OnrushCounter == 0 and OnrushMax == 0 then
            OnrushMax = math.random(3, 5)
            mob:setLocalVar("OnrushMax", OnrushMax)
        end

        OnrushCounter = OnrushCounter + 1
        mob:setLocalVar("OnrushCounter", OnrushCounter)

        if OnrushCounter > OnrushMax then
            mob:setLocalVar("OnrushCounter", 0)
            mob:setLocalVar("OnrushMax", 0)
        else
            mob:useMobAbility(1704)
        end
    end
end

function onCriticalHit(mob, attacker)
    if math.random(100) <= mob:getLocalVar("BreakChance") then
        local animationSub = mob:AnimationSub()
        if animationSub == 4 then
            mob:AnimationSub(1) -- 1 horn broken
        elseif animationSub == 1 then
            mob:AnimationSub(2) -- both horns broken
        end
    end
end

function onMobDeath(mob, player, isKiller)
end