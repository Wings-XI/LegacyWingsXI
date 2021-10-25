-----------------------------------
-- Area: The Garden of Ru'Hmet
--  Mob: Ix'zdei (Black Mage)
-- Note: CoP Mission 8-3
-----------------------------------
local ID = require("scripts/zones/The_Garden_of_RuHmet/IDs")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/magic")
require("scripts/globals/pathfind")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.MANAFONT, hpp = math.random(50, 80)},
        },
    })
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 60)
    mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 15)
    mob:setMobMod(tpz.mobMod.SOUND_RANGE, 15)
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
        [16921013] = function() mob:pathTo(422.261, 0.000, 412.931) end,
        [16921014] = function() mob:pathTo(417.937, 0.000, 413.019) end,
    }
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
    mob:setLocalVar("changeTime", 0)
    local firstCast = { 144, 149, 154, 164, 169 } -- fire, blizzard, aero, thunder, water
    mob:castSpell(firstCast[math.random(#firstCast)]) -- casts a random weak elemental spell upon engaging
end

function onMobFight(mob, target)

    local randomTime = math.random(15, 45)
    local changeTime = mob:getLocalVar("changeTime")

    local isBusy = false
    local act = mob:getCurrentAction()
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

    local hpp = mob:getHPP()
    local healpercent = mob:getLocalVar("healpercent")
    local heal = mob:getLocalVar("heal")
    local zdeiOne = GetMobByID(ID.mob.IXZDEI_BLM_1)
    local zdeiTwo = GetMobByID(ID.mob.IXZDEI_BLM_2)
    if hpp < healpercent and heal == 0 then -- if zdei is under the hp threshold and hasn't run to it's spawnpoint yet then
        local mobID = mob:getID()
        switch (mobID): caseof {
            [16921013] = function()
                mob:pathTo(428.593, -1.500, 412.980) -- go back to pedastal to heal
                mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
                mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.STANDBACK))
                local SpawnPos = zdeiOne:getSpawnPos()
                local pos = zdeiOne:getPos()
                mob:timer(5000, function(mob) -- roughly 8 seconds after going back to their spot they will heal to fullHP
                    if pos.x == SpawnPos.x and pos.z == SpawnPos.z and zdeiOne:getLocalVar("healed") == 0 then
                        mob:useMobAbility(626)
                        mob:setHP(6500)
                        mob:setLocalVar("healed", 1)
                        mob:setLocalVar("heal", 1)
                        mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
                    end
                end)
            end,
            [16921014] = function()
                mob:pathTo(411.333, -1.500, 412.997)
                mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
                mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.STANDBACK))
                local SpawnPos = zdeiTwo:getSpawnPos()
                local pos = zdeiTwo:getPos()
                mob:timer(5000, function(mob)
                    if pos.x == SpawnPos.x and pos.z == SpawnPos.z and zdeiTwo:getLocalVar("healed") == 0 then
                        mob:useMobAbility(626)
                        mob:setHP(6500)
                        mob:setLocalVar("healed", 1)
                        mob:setLocalVar("heal", 1)
                        mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
                    end
                end)
            end,
        }
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