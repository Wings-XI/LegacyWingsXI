-----------------------------------
-- Area: Spire of Vahzl
--  Mob: Memory Receptacles
-----------------------------------
local ID = require("scripts/zones/Spire_of_Vahzl/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/battlefield")
require("scripts/globals/utils")
-----------------------------------

function onMobSpawn(mob)
    local position = math.random(1,8)

    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:setMod(tpz.mod.DEF, 300)
    mob:setMod(tpz.mod.UDMGRANGE, -101)
    mob:setMod(tpz.mod.UDMGMAGIC, -101)
    mob:setMod(tpz.mod.UDMGPHYS, -101)

    mob:SetAutoAttackEnabled(false)
    mob:setLocalVar("positionNum", 0)
    mob:setLocalVar("tpNumber", 0)
    mob:setLocalVar("tpDelay", 0)
    mob:setLocalVar("positionNum", position)
end

function onMobEngaged(mob, target)
    local bfID = mob:getBattlefield():getArea()
    GetMobByID(ID.pullingThePlug[bfID].GREEN_ID):spawn()
    GetMobByID(ID.pullingThePlug[bfID].BLUE_ID):spawn()
    GetMobByID(ID.pullingThePlug[bfID].TEAL_ID):spawn()

    mob:setMod(tpz.mod.REGAIN, 400)
    mob:setLocalVar("drawInTime", os.time() + 20)
    mob:setLocalVar("moveTime", os.time() + 30)
end

function onMobWeaponSkill(target, mob, skill)
    local bfID = mob:getBattlefield():getArea()
    local tpNumber = mob:getLocalVar("tpNumber")
    local tpDelay = mob:getLocalVar("tpDelay")

    if tpNumber < 2 then
        local addTP = tpNumber + 1
        mob:setLocalVar("tpNumber", addTP)
    elseif tpNumber >= 2 and os.time() > tpDelay then
        GetMobByID(ID.pullingThePlug[bfID].GREEN_ID):useMobAbility(542)
        GetMobByID(ID.pullingThePlug[bfID].BLUE_ID):useMobAbility(542)
        GetMobByID(ID.pullingThePlug[bfID].TEAL_ID):useMobAbility(542)
        mob:setLocalVar("tpNumber", 0)
        mob:setLocalVar("tpDelay", os.time() + 10)
    end
end

function onMobFight(mob, target)
    -- Draws in random party member every 20 seconds
    local drawInTime = mob:getLocalVar("drawInTime")
    local partyNum = target:getPartySize()
    local party = target:getParty()

    if os.time() > drawInTime then
        local victim = math.random(1,partyNum)
        local i = 1
        for _, partyMember in pairs(party) do
            if partyMember:isAlive() and i == victim and mob:checkDistance(partyMember) < 35 then
                mob:triggerDrawIn(true, 1, 35, partyMember)
                drawInTime = mob:setLocalVar("drawInTime", os.time() + 20)
                break
            else
                i = i + 1
            end
        end
    end

    -- Spawned orbs move to a random location every 30 seconds
    local battlefield = mob:getBattlefield()
    local moveTime = battlefield:getLocalVar("moveTime")

    if os.time() > moveTime then
        local i = math.random(1,8)
        print(i)
        battlefield:setLocalVar("moveTime", os.time() + 10)
        battlefield:setLocalVar("positionNum", i)
    end

    -- If an orb dies, remove its associated immunity
    if mob:getBattlefield():getLocalVar("GreenDead") == 1 then
        mob:setMod(tpz.mod.UDMGMAGIC, 0) -- Remove magic immunity
    end
    if mob:getBattlefield():getLocalVar("BlueDead") == 1 then
        mob:setMod(tpz.mod.UDMGRANGE, 0) -- Remove ranged immunity
    end
    if mob:getBattlefield():getLocalVar("TealDead") == 1 then
        mob:setMod(tpz.mod.UDMGPHYS, 0) -- Remove melee immunity
    end
end

function onMobDeath(mob, player, isKiller)
    -- Despawn all other mobs
    for i = mob:getID() + 1, mob:getID() + 8 do
        DespawnMob(i)
    end
end
