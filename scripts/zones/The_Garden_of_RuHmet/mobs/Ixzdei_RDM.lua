-----------------------------------
-- Area: The Garden of Ru'Hmet
--  Mob: Ix'zdei (Red Mage)
-- Note: CoP Mission 8-3
-----------------------------------
local ID = require("scripts/zones/The_Garden_of_RuHmet/IDs")
require("scripts/globals/magic")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 60)
    mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 12)
    mob:setMobMod(tpz.mobMod.SOUND_RANGE, 12)
    mob:setMobMod(tpz.mobMod.LINK_RADIUS, 30)
    mob:AnimationSub(0)
    mob:SetAutoAttackEnabled(true)
    mob:SetMobAbilityEnabled(true)
    mob:setLocalVar("healpercent", math.random(15, 25))
end

function onMobEngaged(mob, target)
    local mobId = mob:getID()
    -- each pot steps off the pedastal after casting initial spell and engaging target
    switch (mobId): caseof {
        [16921011] = function() mob:pathTo(422.085, 0.000, 426.928) end,
        [16921012] = function() mob:pathTo(417.964, 0.000, 426.938) end,
    }
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
    mob:setLocalVar("changeTime", 0)
    local firstCast = { 216, 221, 232, 258, 59, 25 } -- gravity, poison II, bio III, bind, silence, dia III
    mob:castSpell(firstCast[math.random(#firstCast)]) -- casts a random enfeebling spell upon engaging
end

function onMobFight(mob, target)
    local isBusy = false
    local act = mob:getCurrentAction()
    local randomTime = math.random(15, 45)
    local changeTime = mob:getLocalVar("changeTime")
    if act == tpz.act.MOBABILITY_START or act == tpz.act.MOBABILITY_USING or act == tpz.act.MOBABILITY_FINISH then
            isBusy = true
    end

    if mob:actionQueueEmpty() == true and not isBusy then -- dont change forms while charging Optic Induration
        if (mob:AnimationSub() == 0 and mob:getBattleTime() - changeTime > randomTime) then
            mob:AnimationSub(math.random(2, 3))
            mob:setLocalVar("changeTime", mob:getBattleTime())
        elseif (mob:AnimationSub() == 1 and mob:getBattleTime() - changeTime > randomTime) then
            mob:AnimationSub(math.random(2, 3))
            mob:setLocalVar("changeTime", mob:getBattleTime())
        elseif (mob:AnimationSub() == 2 and mob:getBattleTime() - changeTime > randomTime) then
            local aniChance = math.random(0, 1)
            if (aniChance == 0) then
                mob:AnimationSub(0)
                mob:setLocalVar("changeTime", mob:getBattleTime())
            else
                mob:AnimationSub(3)
                mob:setLocalVar("changeTime", mob:getBattleTime())
            end
        elseif (mob:AnimationSub() == 3 and mob:getBattleTime() - changeTime > randomTime) then
            mob:AnimationSub(math.random(0, 2))
            mob:setLocalVar("changeTime", mob:getBattleTime())
        end
    end
end

function onMobWeaponSkill(target, mob, skill)
    local skill = skill:getID()
    local charge = mob:getLocalVar("charge")
    if skill == 1464 then
        mob:AnimationSub(0)
        local opticCounter = mob:getLocalVar("opticCounter")

        opticCounter = opticCounter +1
        mob:setLocalVar("opticCounter", opticCounter)

        if (opticCounter > 2) then
            mob:setLocalVar("opticCounter", 0)
            mob:setLocalVar("opticInduration", 1)
            chargeOptic(mob)
        else
            chargeOptic(mob)
        end
    end
end

function chargeOptic(mob)
    mob:SetAutoAttackEnabled(false)
    mob:SetMobAbilityEnabled(false)

    if mob:getLocalVar("opticInduration") ~= 1 then
        mob:timer(5000, function(mob)
            mob:useMobAbility(1464)
        end)
    elseif mob:getLocalVar("opticInduration") == 1 then
        mob:useMobAbility(1465)
        mob:setLocalVar("opticInduration", 0)
        mob:SetAutoAttackEnabled(true)
        mob:SetMobAbilityEnabled(true)
    end
end

function onMobDisengage(mob)
    mob:AnimationSub(0)
end

function onMobDeath(mob, isKiller, player)
end