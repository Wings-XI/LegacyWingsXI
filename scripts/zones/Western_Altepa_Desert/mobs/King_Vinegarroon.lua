-----------------------------------
-- Area: Western Altepa Desert
--   NM: King Vinegarroon
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/world")
require("scripts/globals/mobs")
require("scripts/globals/status")
local ID = require("scripts/zones/Western_Altepa_Desert/IDs")
-----------------------------------

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.CLAIM_SHIELD, 1)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 1)
    mob:setMobMod(tpz.mobMod.DRAW_IN_INCLUDE_PARTY, 1)
    mob:setMobMod(tpz.mobMod.DRAW_IN_CUSTOM_RANGE, 25)
end

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onMobDrawIn(mob, target)
    local battleTarget = mob:getTarget()
    local drawInWait = mob:getLocalVar("DrawInWait")

    if target:getID() == battleTarget:getID() and os.time() > drawInWait then
        mob:addTP(3000)
    end
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.PETRIFY, {chance = 100})
end

function onMobDisengage(mob, weather)
    if not (mob:getWeather() == tpz.weather.DUST_STORM or mob:getWeather() == tpz.weather.SAND_STORM) then
        DespawnMob(mob:getID())
    end
end

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.VINEGAR_EVAPORATOR)
end

function onMobWeaponSkill(target, mob, skill)
    local drawInWait = mob:getLocalVar("DrawInWait")

    if (skill:getID() == 354 or skill:getID() == 355 or skill:getID() == 722 or skill:getID() == 723) and os.time() > drawInWait then
        local chance = math.random(1,2)
        if chance == 1 then
            for _, member in pairs(target:getAlliance()) do
                mob:triggerDrawIn(false, 1, 35, member)
            end
        else
            mob:triggerDrawIn(false, 1, 35, target)
        end

        mob:useMobAbility(({353,350,720})[math.random(1,3)])
        mob:setLocalVar("DrawInWait", os.time() + 2)
    end
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    local KingVine = GetMobByID(ID.mob.KING_VINEGARROON)
	local respawn = 75600 -- 21h
    mob:setRespawnTime(respawn)
	SetServerVariable("KVRespawn",(os.time() + respawn))
    DisallowRespawn(KingVine:getID(), true)
end

function updateRegen(mob)
    local hour = VanadielHour()
    local regen = mob:getMod(tpz.mod.REGEN)

    if hour > 3 and hour < 20 then -- daytime between 4:00 and 20:00
        if regen ~= 125 then
            mob:setMod(tpz.mod.REGEN, 125)
        end
    else
        if regen ~= 250 then
            mob:setMod(tpz.mod.REGEN, 250)
        end
    end
end

function onMobFight(mob, target)
    updateRegen(mob)

    local drawInWait = mob:getLocalVar("DrawInWait")

    if target:getZPos() > -540 and os.time() > drawInWait then -- Northern Draw In
        local rot = target:getRotPos()
        target:setPos(target:getXPos(),target:getYPos(),-542,rot)
        mob:messageBasic(232, 0, 0, target)
        mob:setLocalVar("DrawInWait", os.time() + 2)
    elseif target:getXPos() < -350 and os.time() > drawInWait then  -- Southern Draw In
        local rot = target:getRotPos()
        target:setPos(-348,target:getYPos(),target:getZPos(),rot)
        mob:messageBasic(232, 0, 0, target)
        mob:setLocalVar("DrawInWait", os.time() + 2)
    end
end

function onMobRoam(mob)
    updateRegen(mob)

    if not (mob:getWeather() == tpz.weather.DUST_STORM or mob:getWeather() == tpz.weather.SAND_STORM) then
        DespawnMob(mob:getID())
    end
end
