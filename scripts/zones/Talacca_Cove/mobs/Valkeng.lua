-----------------------------------
-- Area: Talacca Cove
--  Mob: Velkeng
-----------------------------------
local ID = require("scripts/zones/Talacca_Cove/IDs")
require("scripts/globals/status")
-----------------------------------

local harlequinFrameModelId = 1977
local valoredgeFrameModelId = 1983
local sharpshotFrameModelId = 1990
local stormwalkerFrameModelId = 1994

local function changeToValoredge(mob, percent)
    if(mob:getLocalVar("CurrentFrame") == valoredgeFrameModelId) then
        local consecutiveManeuvers = mob:getLocalVar("ConsecutiveManeuvers")
        mob:showText(mob, ID.text.VALKENG_MELEE_KEEP_FRAME, percent)
        if (consecutiveManeuvers < 5) then
            mob:setLocalVar("ConsecutiveManeuvers", consecutiveManeuvers + 1)
            mob:addMod(tpz.mod.DELAY, 200) -- Speed up attack rate
        end
        return
    end

    mob:setLocalVar("ConsecutiveManeuvers", 0)
    mob:showText(mob, ID.text.VALKENG_MELEE_CHANGE_FRAME, percent)
    mob:setLocalVar("CurrentFrame", valoredgeFrameModelId)
    mob:setMod(tpz.mod.UDMGPHYS, -85)
    mob:setMod(tpz.mod.UDMGRANGE, 0)
    mob:setMod(tpz.mod.UDMGMAGIC, 0)
    mob:setBehaviour(0) -- Standback disabled
    mob:setMobMod(tpz.mobMod.SPECIAL_SKILL, 0) -- ranged attacks disabled
    mob:delMobMod(tpz.mobMod.HP_STANDBACK, 50)
    mob:setMod(tpz.mod.DELAY, 2400) -- high attack speed
    mob:setMod(tpz.mod.REGEN, 10) --Weak Auto Regen

    mob:SetMagicCastingEnabled(false)
    mob:useMobAbility(2018)
end

local function changeToStormwaker(mob, percent)
    if(mob:getLocalVar("CurrentFrame") == stormwalkerFrameModelId) then
        local consecutiveManeuvers = mob:getLocalVar("ConsecutiveManeuvers")
        mob:showText(mob, ID.text.VALKENG_MAGIC_KEEP_FRAME, percent)
        if (consecutiveManeuvers < 5) then
            mob:setLocalVar("ConsecutiveManeuvers", consecutiveManeuvers + 1)
                mob:delMobMod(tpz.mobMod.MAGIC_COOL, 1) -- Speed up magic casting
                mob:addMod(tpz.mod.UFASTCAST, 15) -- Speed up fast cast
        end
        return
    end

    mob:setLocalVar("ConsecutiveManeuvers", 0)
    mob:showText(mob, ID.text.VALKENG_MAGIC_CHANGE_FRAME, percent)
    mob:setLocalVar("CurrentFrame", stormwalkerFrameModelId)
    mob:setMod(tpz.mod.UDMGPHYS, 0)
    mob:setMod(tpz.mod.UDMGRANGE, 0)
    mob:setMod(tpz.mod.UDMGMAGIC, -85)
    mob:setSpellList(2) -- generic blm
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 20)
    mob:setMod(tpz.mod.UFASTCAST, 25)
    mob:setBehaviour(0) -- Standback disabled
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, 20)
    mob:setMobMod(tpz.mobMod.SPECIAL_SKILL, 0) -- ranged attacks disabled
    mob:setMod(tpz.mod.DELAY, 0) -- remove high attack speed
    mob:setMod(tpz.mod.REGEN, 0) -- remove weak auto regen

    mob:SetMagicCastingEnabled(false)
    mob:useMobAbility(2018)
end

local function changeToSharpshot(mob, percent)
    if(mob:getLocalVar("CurrentFrame") == sharpshotFrameModelId) then
    local consecutiveManeuvers = mob:getLocalVar("ConsecutiveManeuvers")
        mob:showText(mob, ID.text.VALKENG_RANGED_KEEP_FRAME, percent)
        if (consecutiveManeuvers < 5) then
            mob:setLocalVar("ConsecutiveManeuvers", consecutiveManeuvers + 1)
            mob:delMobMod(tpz.mobMod.SPECIAL_COOL, 2)  -- Speed Up Ranged attacks
        end
        return
    end

    mob:setLocalVar("ConsecutiveManeuvers", 0)
    mob:showText(mob, ID.text.VALKENG_RANGED_CHANGE_FRAME, percent)
    mob:setLocalVar("CurrentFrame", sharpshotFrameModelId)
    mob:setMod(tpz.mod.UDMGPHYS, 25)
    mob:setMod(tpz.mod.UDMGRANGE, -85)
    mob:setMod(tpz.mod.UDMGMAGIC, 0)
    mob:setBehaviour(2) --Standback enabled
    mob:setMobMod(tpz.mobMod.SPECIAL_SKILL, 272) -- ranged attacks enabled
    mob:setMobMod(tpz.mobMod.SPECIAL_COOL, 14) -- ranged attack speed
    mob:setMod(tpz.mod.DELAY, 0) -- remove high attack speed
    mob:setMod(tpz.mod.REGEN, 0) -- remove weak auto regen

    mob:SetMagicCastingEnabled(false)
    mob:useMobAbility(2018)
end


function onMobInitialize(mob)
    mob:setLocalVar("PhysicalDamage", 0)
    mob:setLocalVar("MagicalDamage", 0)
    mob:setLocalVar("RangedDamage", 0)
    mob:setLocalVar("CurrentFrame", harlequinFrameModelId)
    mob:addListener("TAKE_DAMAGE", "VALKENG_TAKE_DAMAGE", function(mob, amount, attacker, attackType, damageType)
        if attackType == tpz.attackType.MAGICAL or mob:getLocalVar("dmgsourceblumagic") == 1 then
            mob:setLocalVar("MagicalDamage", mob:getLocalVar("MagicalDamage") + amount)
        elseif attackType == tpz.attackType.PHYSICAL then
            mob:setLocalVar("PhysicalDamage", mob:getLocalVar("PhysicalDamage") + amount)
        elseif attackType == tpz.attackType.RANGED then
            mob:setLocalVar("RangedDamage", mob:getLocalVar("RangedDamage") + amount)
        else
            -- ignore Untyped Damage
        end

        local sum = mob:getLocalVar("PhysicalDamage") + mob:getLocalVar("MagicalDamage") + mob:getLocalVar("RangedDamage")
        local physicalPercent =  mob:getLocalVar("PhysicalDamage") / sum * 100
        local magicalPercent =  mob:getLocalVar("MagicalDamage") / sum * 100
        local rangedPercent =  mob:getLocalVar("RangedDamage") / sum * 100

        --useful debug output
        --printf(string.format("Physical %d %d Magical %d %d  Ranged %d %d",
        --mob:getLocalVar("PhysicalDamage"), physicalPercent, mob:getLocalVar("MagicalDamage"), magicalPercent, mob:getLocalVar("RangedDamage"), rangedPercent))

    end)
end

function onMobWeaponSkill(target, mob, skill)
    -- Scripting to account for the fact that shield_bash is currently a "special" and therefore does not consume TP
    -- Valkeng (uniquely) treats this as a TP move
    if(skill:getID()==1944) then
        mob:setTP(0)
    end

    if(skill:getID()==2018) then
        mob:timer(2000, function(mob)
            if mob:isAlive() then
                mob:setModelId(mob:getLocalVar("CurrentFrame"))
                mob:sendUpdateToZoneCharsInRange()
                if(mob:getLocalVar("CurrentFrame")==stormwalkerFrameModelId) then
                    mob:SetMagicCastingEnabled(true)
                end
            end
        end)
    end
end

function onMobWeaponSkillPrepare(mob, target)
    local currentFrame = mob:getLocalVar("CurrentFrame")
    if (currentFrame == harlequinFrameModelId or currentFrame == stormwalkerFrameModelId) then
        return 1943 -- slapstick
    elseif (currentFrame == sharpshotFrameModelId) then
        return 1942 -- arcuballista
    else
        local tpMove = math.random(1,3)
        if (tpMove == 1) then
            return 1940 -- chimera_ripper
        elseif (tpMove == 2) then
            return 1941 -- string_clipper
        else
            return 1944 -- shield_bash
        end
    end
end


function onMobFight(mob, target)
    local battleTime = mob:getBattleTime();
    -- calculate leading damage type every 30s
    if(battleTime%30 == 0 and battleTime~=0) then
        if(battleTime == mob:getLocalVar("LastUpdateTime")) then
            -- This function is called (locally) 2-4 times per battleTime second.  Ignore calls after the first
            return
        else
            mob:setLocalVar("LastUpdateTime", battleTime)
        end

        local sum = mob:getLocalVar("PhysicalDamage") + mob:getLocalVar("MagicalDamage") + mob:getLocalVar("RangedDamage")
        local physicalPercent = mob:getLocalVar("PhysicalDamage") / sum * 100
        local magicalPercent = mob:getLocalVar("MagicalDamage") / sum * 100
        local rangedPercent =  mob:getLocalVar("RangedDamage") / sum * 100

        if(physicalPercent > magicalPercent and physicalPercent > rangedPercent) then
            changeToValoredge(mob, physicalPercent)
        elseif (magicalPercent > physicalPercent and magicalPercent > rangedPercent) then
            changeToStormwaker(mob, magicalPercent)
        elseif (rangedPercent > physicalPercent and rangedPercent > magicalPercent) then
            changeToSharpshot(mob, rangedPercent)
        else
            -- if no dmg taken or no leading dmg type - dont trigger a change
        end
    end
end

function onMobSpawn(mob)
    mob:setModelId(harlequinFrameModelId)
    mob:setLocalVar("CurrentFrame", harlequinFrameModelId)
    mob:setMod(tpz.mod.UDMGPHYS, 0)
    mob:setMod(tpz.mod.UDMGRANGE, 0)
    mob:setMod(tpz.mod.UDMGMAGIC, 0)
    mob:SetMagicCastingEnabled(true)
    mob:setSpellList(444)
    mob:setMod(tpz.mod.LULLABYRESTRAIT, 100)
    mob:setMod(tpz.mod.SLEEPRESTRAIT, 100)
    mob:setMod(tpz.mod.SILENCERESTRAIT, 100)
    mob:setMod(tpz.mod.MAIN_DMG_RATING, -20) -- tweaking down melee - was OP on late stage Valoredge
end

function onMobDeath(mob, player, isKiller)
end
