-------------------------------------------------------
-- Area: Lufaise Meadows
--   NM: Kurrea
-------------------------------------------------------
local ID = require("scripts/zones/Lufaise_Meadows/IDs")
require("scripts/globals/status")
require("scripts/globals/msg")
-------------------------------------------------------
local hutPosition = { x = -247.06, y = -16.05, z = 41.40}

local function drinkTheSoup(mob, target)
    local effect = math.random(1,9)
    if (target:isPet()) then
        target = target:getMaster()
    end
    for _,member in pairs(target:getAlliance()) do
        if (member:getZoneID() == mob:getZoneID()) then
            member:messageSpecial(ID.text.KURREA_SLURPS)
            member:messageSpecial(ID.text.KURREA_SLURPS + effect)
        end
    end
    if (effect == 1) then
        mob:useMobAbility(603)
        local value = mob:getMod(tpz.mod.UDMGPHYS)
        if (value == 0) then
            mob:setMod(tpz.mod.UDMGPHYS, -50)
        elseif (value == -50) then
            mob:setMod(tpz.mod.UDMGPHYS, -75)
        elseif (value == -75) then
            mob:setMod(tpz.mod.UDMGPHYS, -100)
        end
    elseif (effect == 2) then
        mob:useMobAbility(604)
        mob:setMod(tpz.mod.UDMGMAGIC, -100)
    elseif (effect == 3) then
        mob:useMobAbility(624)
        mob:addMod(tpz.mod.MATT, 50)
    elseif (effect == 4) then
        mob:useMobAbility(404)
        mob:setMod(tpz.mod.UDMGPHYS, -100)
    elseif (effect == 5) then
        mob:useMobAbility(625)
        mob:addMod(tpz.mod.ATTP, 50)
    elseif (effect == 6) then
        mob:useMobAbility(626)
        local value = mob:getMod(tpz.mod.UDMGRANGE)
        if (value == 0) then
            mob:setMod(tpz.mod.UDMGRANGE, -50)
        elseif (value == -50) then
            mob:setMod(tpz.mod.UDMGRANGE, -75)
        elseif (value == -75) then
            mob:setMod(tpz.mod.UDMGRANGE, -100)
        end
    elseif (effect == 7) then
        mob:useMobAbility(627)
        mob:setHP(mob:getHP() + (mob:getMaxHP() * (math.random(25,33)/100)))
    elseif (effect == 8) then
        mob:useMobAbility(307)
        local value = mob:getMod(tpz.mod.UDMGMAGIC)
        if (value == 0) then
            mob:setMod(tpz.mod.UDMGMAGIC, -50)
        elseif (value == -50) then
            mob:setMod(tpz.mod.UDMGMAGIC, -75)
        elseif (value == -75) then
            mob:setMod(tpz.mod.UDMGMAGIC, -100)
        end
    elseif (effect == 9) then
        mob:setMod(tpz.mod.UDMGPHYS, 0)
        mob:setMod(tpz.mod.UDMGRANGE, 0)
        mob:setMod(tpz.mod.UDMGMAGIC, 0)
        mob:setMod(tpz.mod.ATTP, 0)
        mob:setMod(tpz.mod.MATT, 32) -- base value
    end
end

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 15000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 18000)
    mob:setMod(tpz.mod.MOVE, 25)
    mob:setMod(tpz.mod.BINDRES, 100)
    mob:setMod(tpz.mod.STUNRES, 100)
    mob:setMod(tpz.mod.SLEEPRES, 100)
    mob:setMod(tpz.mod.LULLABYRES, 100)
    mob:setMod(tpz.mod.SILENCERES, 100)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(tpz.mobMod.NO_STANDBACK, 1)
end

function onCastStarting(mob, spell)
    if spell:getID() == 208 then -- Tornado
        spell:castTime(1) -- insta cast
    end
end

function onMobSpawn(mob)
    -- ensure that if Kurrea died with these set to false, that they are enabled
    mob:SetMagicCastingEnabled(true)
    mob:SetAutoAttackEnabled(true)
    mob:SetMobAbilityEnabled(true)
end

function onMobEngaged(mob, target)
    mob:setLocalVar("TimeToRun", os.time() + 30)
end

function onMobFight(mob, target)
    local now = os.time()
    
    if (mob:getLocalVar("RunningToTarget") == 1 and mob:checkDistance(target) < 5) then
        mob:setLocalVar("RunningToTarget", 0)
        mob:setLocalVar("TimeToRun", os.time() + 30)
    end

    if (mob:getLocalVar("RunningToHut") == 0 and mob:getLocalVar("RunningToTarget") == 0) then -- not running
        printf("not running")
        if (now > mob:getLocalVar("TimeToRun")) then
            mob:setLocalVar("RunningToHut", 1)
            mob:SetMagicCastingEnabled(false)
            mob:SetAutoAttackEnabled(false)
            mob:SetMobAbilityEnabled(false)
            mob:pathTo(hutPosition.x, hutPosition.y, hutPosition.z, 9)
        end
    else -- running
        if (mob:getLocalVar("RunningToHut") == 1 and mob:checkDistance(hutPosition.x, hutPosition.y, hutPosition.z) < 5) then
            mob:setLocalVar("RunningToHut", 0)
            mob:setLocalVar("RunningToTarget", 1)
            drinkTheSoup(mob, target)
            mob:SetMagicCastingEnabled(true)
            mob:SetAutoAttackEnabled(true)
            mob:SetMobAbilityEnabled(true)
        end
    end
end

function onMobDeath(mob, player, isKiller)
end
