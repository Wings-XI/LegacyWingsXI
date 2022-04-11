-------------------------------------
-- Area: Alzadaal Undersea Ruins
--  ZNM T1: Ob
-------------------------------------
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/status")
-------------------------------------
local harlequinFrameModelId = 1977
local valoredgeFrameModelId = 1983
local sharpshotFrameModelId = 1990
local stormwalkerFrameModelId = 1994
-------------------------------------

-- used to remove rage following an overload
local function overloadRageDisengage(mob)
    -- Dont allow an un-rage from actual rage
    if mob:getLocalVar("[rage]started") == 0 then
        -- Pulled from Rage.lua - may need tweaking
        mob:delMod(tpz.mod.DELAY, 2600)
        mob:delMod(tpz.mod.ATTP, 60)
        mob:delMod(tpz.mod.ACC, 500)
        mob:delMod(tpz.mod.MAIN_DMG_RATING, 75)
        mob:delMod(tpz.mod.CRITHITRATE, 30)
        mob:delMod(tpz.mod.MEVA, 500)
        mob:delMod(tpz.mod.BINDRESTRAIT, 100)
        mob:delMod(tpz.mod.GRAVITYRESTRAIT, 100)
        mob:delMod(tpz.mod.MOVE, 200)

        -- intense regain, uses TP moves at will when raged
        mob:delMod(tpz.mod.REGAIN, 2000)

    end
end

-- used to begin rage due to overload
local function overloadRageEngage(mob)
    -- Pulled from Rage.lua - may need tweaking
    mob:addMod(tpz.mod.DELAY, 2600)
    mob:addMod(tpz.mod.ATTP, 60)
    mob:addMod(tpz.mod.ACC, 500)
    mob:addMod(tpz.mod.MAIN_DMG_RATING, 75)
    mob:addMod(tpz.mod.CRITHITRATE, 30)
    mob:addMod(tpz.mod.MEVA, 500)
    mob:addMod(tpz.mod.BINDRESTRAIT, 100)
    mob:addMod(tpz.mod.GRAVITYRESTRAIT, 100)
    mob:addMod(tpz.mod.MOVE, 200)

    -- intense regain, uses TP moves at will when raged
    mob:addMod(tpz.mod.REGAIN, 2000)
end

local function changeToValoredge(mob, percent)
    if(mob:getLocalVar("CurrentFrame") == valoredgeFrameModelId) then
        return
    end

    mob:setLocalVar("CurrentFrame", valoredgeFrameModelId)
    mob:setMod(tpz.mod.UDMGPHYS, -75)
    mob:setMod(tpz.mod.UDMGRANGE, -75)
    mob:setMod(tpz.mod.UDMGMAGIC, -50)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, 0)
    mob:setMobMod(tpz.mobMod.SPECIAL_SKILL, 1944) -- shield bash
    mob:setMobMod(tpz.mobMod.SPECIAL_COOL, 120) -- cooldown
    mob:setMod(tpz.mod.DELAY, 2400) -- high attack speed
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 10) -- has double attack
    mob:setMobMod(tpz.mobMod.SKILL_LIST, 2029)

    mob:SetMagicCastingEnabled(false)
    mob:useMobAbility(2018)
end

local function changeToStormwaker(mob)
    if(mob:getLocalVar("CurrentFrame") == stormwalkerFrameModelId) then
        return
    end

    mob:setLocalVar("CurrentFrame", stormwalkerFrameModelId)
    mob:setMod(tpz.mod.UDMGPHYS, 50)
    mob:setMod(tpz.mod.UDMGRANGE, 50)
    mob:setMod(tpz.mod.UDMGMAGIC, -75)
    mob:setSpellList(2) -- generic blm
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 20)
    mob:setMod(tpz.mod.UFASTCAST, 25)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, 66)
    mob:setMobMod(tpz.mobMod.SPECIAL_SKILL, 0) -- ranged attacks disabled
    mob:setMod(tpz.mod.DELAY, 0) -- remove high attack speed
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 0)
    mob:setMobMod(tpz.mobMod.SKILL_LIST, 2027)

    mob:SetMagicCastingEnabled(false)
    mob:useMobAbility(2018)
end

local function changeToSharpshot(mob)
    if(mob:getLocalVar("CurrentFrame") == sharpshotFrameModelId) then
        return
    end

    mob:setLocalVar("CurrentFrame", sharpshotFrameModelId)
    mob:setMod(tpz.mod.UDMGPHYS, 0)
    mob:setMod(tpz.mod.UDMGRANGE, 0)
    mob:setMod(tpz.mod.UDMGMAGIC, 50)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, 66)
    mob:setMobMod(tpz.mobMod.SPECIAL_SKILL, 272) -- ranged attacks enabled
    mob:setMobMod(tpz.mobMod.SPECIAL_COOL, 14) -- ranged attack speed
    mob:setMod(tpz.mod.DELAY, 0) -- remove high attack speed
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 0)
    mob:setMobMod(tpz.mobMod.SKILL_LIST, 2028)

    mob:SetMagicCastingEnabled(false)
    mob:useMobAbility(2018)
end

local function setupHarlequin(mob)
    mob:setLocalVar("CurrentFrame", harlequinFrameModelId)
    mob:setModelId(mob:getLocalVar("CurrentFrame"))
    mob:SetMagicCastingEnabled(true)
    mob:setMod(tpz.mod.UDMGPHYS, -50)
    mob:setMod(tpz.mod.UDMGRANGE, -50)
    mob:setMod(tpz.mod.UDMGMAGIC, -50)
    mob:setSpellList(536)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 35)
    mob:setMod(tpz.mod.UFASTCAST, 25)
    mob:setBehaviour(0) -- Standback disabled
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, 0)
    mob:setMobMod(tpz.mobMod.SPECIAL_SKILL, 0) -- ranged attacks disabled
    mob:setMod(tpz.mod.DELAY, 0) -- remove high attack speed
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 0)
end

local function scanForManeuvers(mob, target)
    local sharpshotCount = 0
    local valoredgeCount = 0
    local stormwalkerCount = 0
    local currentFrame = mob:getLocalVar("CurrentFrame")

    local overloadCount = 0

    local zoneID = mob:getZoneID()
    local enmityList = mob:getEnmityList()
    for _, member in pairs(target:getAlliance()) do
        if (member:getMainJob() == tpz.job.PUP or member:getSubJob() == tpz.job.PUP) then -- filter by Puppetmasters
            if (member:getZoneID() == zoneID and mob:checkDistance(member) < 50) then -- filter by zone and distance

                -- Different number of maneuversRequired for main vs sub pup
                local maneuversRequired = 3
                if member:getMainJob() == tpz.job.PUP then
                    maneuversRequired = 2
                end

                -- Determine the player's "vote"
                if (member:countEffect(tpz.effect.WIND_MANEUVER) + member:countEffect(tpz.effect.THUNDER_MANEUVER)) >= maneuversRequired then
                    sharpshotCount = sharpshotCount + 1
                elseif (member:countEffect(tpz.effect.FIRE_MANEUVER) + member:countEffect(tpz.effect.EARTH_MANEUVER) + member:countEffect(tpz.effect.LIGHT_MANEUVER)) >= maneuversRequired then
                    valoredgeCount = valoredgeCount + 1
                elseif (member:countEffect(tpz.effect.ICE_MANEUVER) + member:countEffect(tpz.effect.WATER_MANEUVER) + member:countEffect(tpz.effect.DARK_MANEUVER)) >= maneuversRequired then
                    stormwalkerCount = stormwalkerCount + 1
                end

                -- Catch overloads
                overloadCount = overloadCount + member:countEffect(tpz.effect.OVERLOAD)
            end
        end
    end

    -- [rage]started is from rage.lua - we dont need to overload rage when actually raging
    if (overloadCount > 0 and mob:getLocalVar("OverloadRage") == 0 and mob:getLocalVar("[rage]started") == 0) then
         -- ya done goofed
        mob:setLocalVar("OverloadRage", os.time() + math.random(45,180)) -- how long does Ob Rage for when a Puppetmaster screws up? 5mins?  I'm guessing here.
        mob:useMobAbility(603) -- 603, 604, 624-627  -- 2 hour dust clouds - which does Ob use?
        overloadRageEngage(mob)
    end

    if (sharpshotCount > valoredgeCount) and (sharpshotCount > stormwalkerCount) and (sharpshotCount > 0) then
        changeToSharpshot(mob)
    elseif (valoredgeCount > sharpshotCount) and (valoredgeCount > stormwalkerCount) and (valoredgeCount > 0) then
        changeToValoredge(mob)
    elseif (stormwalkerCount > sharpshotCount) and (stormwalkerCount > valoredgeCount) and (stormwalkerCount > 0) then
        changeToStormwaker(mob)
    end
    -- does not change back to Harlequin see https://www.youtube.com/watch?v=12nNGdEicUE for a scenario with 0 manuevers up after setting valor

end

function onMobWeaponSkill(target, mob, skill)
    -- 2018 is the puppet frame change dance
    if(skill:getID()==2018) then
        mob:timer(2000, function(mob)
            if mob:isAlive() then
                mob:setModelId(mob:getLocalVar("CurrentFrame"))
                mob:sendUpdateToZoneCharsInRange()
                if(mob:getLocalVar("CurrentFrame") == stormwalkerFrameModelId) then
                    mob:SetMagicCastingEnabled(true)
                end
            end
        end)
    end
end

function onMobEngaged(mob, target)
    scanForManeuvers(mob, target)
    mob:setLocalVar("ScanTime", os.time() + 15)
end

function onMobFight(mob, target)
    if (os.time() > mob:getLocalVar("ScanTime")) then
        mob:setLocalVar("ScanTime", os.time() + 15)
        scanForManeuvers(mob, target)
    end

    if (mob:getLocalVar("OverloadRage") > 0 and mob:getLocalVar("OverloadRage") < os.time()) then
        mob:setLocalVar("OverloadRage", 0)
        overloadRageDisengage(mob)
    end
end

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 3000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 5000)
    mob:setMobMod(tpz.mobMod.MP_BASE, 5000)
    setupHarlequin(mob)
end

function onMobSpawn(mob)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
    mob:setMod(tpz.mod.LULLABYRES, 100)
    mob:setMod(tpz.mod.SLEEPRES, 100)
    setupHarlequin(mob)
end

function onMobDeath(mob, player, isKiller)
end
