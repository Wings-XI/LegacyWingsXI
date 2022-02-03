-----------------------------------
-- Area: Dynamis - Qufim
--  Mob: Antaeus
-- Note: Mega Boss
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/dynamis")
require("scripts/globals/status")
-----------------------------------

local zone = 41

function onMobSpawn(mob)
    require("scripts/zones/Dynamis-Qufim/dynamis_mobs")
    local mobID = mob:getID()
    dynamis.statueOnSpawn(mob, mobList[zone][mobID] ~= nil and mobList[zone][mobID].eyes or 0)
    dynamis.setMegaBossStats(mob)

    -- Set Removable Mods
    mob:addMod(tpz.mod.REGEN, 1000)
    mob:setLocalVar("AntaeusRegen", 1)
    mob:addMod(tpz.mod.CRITHITRATE, 100)
    mob:setLocalVar("AntaeusCrit", 1)
    mob:addMod(tpz.mod.UDMGRANGE, -99)
    mob:addMod(tpz.mod.UDMGPHYS, -99)
    mob:addMod(tpz.mod.UDMGBREATH, -99)
    mob:setLocalVar("AntaeusDMG", 1)
    mob:addMod(tpz.mod.FIRERES, 1000)
    mob:setLocalVar("AntaeusFire", 1)
    mob:addMod(tpz.mod.ICERES, 1000)
    mob:setLocalVar("AntaeusIce", 1)
    mob:addMod(tpz.mod.WINDRES, 1000)
    mob:setLocalVar("AntaeusWind", 1)
    mob:addMod(tpz.mod.EARTHRES, 1000)
    mob:setLocalVar("AntaeusEarth", 1)
    mob:addMod(tpz.mod.THUNDERRES, 1000)
    mob:setLocalVar("AntaeusThunder", 1)
    mob:addMod(tpz.mod.WATERRES, 1000)
    mob:setLocalVar("AntaeusWater", 1)
    mob:addMod(tpz.mod.LIGHTRES, 1000)
    mob:setLocalVar("AntaeusLight", 1)
    mob:addMod(tpz.mod.DARKRES, 1000)
    mob:setLocalVar("AntaeusDark", 1)

    -- Set Non-Removable Mods
    -- Anateus should not standback and should be able to avoid most RAs via melee range. (https://ffxiclopedia.fandom.com/wiki/Antaeus)
    mob:addMobMod(tpz.mobMod.NO_STANDBACK, 1)
    -- Sleep Res and Lullaby Res are unverified but added in case (https://ffxiclopedia.fandom.com/wiki/Antaeus)
    mob:addMod(tpz.mod.SLEEPRES, 99)
    mob:addMod(tpz.mod.LULLABYRES, 99)
    -- Adding Normal Dynamis Boss Resistances and Regain
    mob:addMod(tpz.mod.GRAVITYRES, 40)
    mob:addMod(tpz.mod.BINDRES, 40)
    mob:addMod(tpz.mod.REGAIN, 50)
end

function onMobDeath(mob, player, isKiller)
    require("scripts/zones/Dynamis-Qufim/dynamis_mobs")
    local ID = require("scripts/zones/Dynamis-Qufim/IDs")
    dynamis.statueOnDeath(mob, player, isKiller)
    dynamis.mobOnDeath(mob, mobList[zone], ID.text.DYNAMIS_TIME_EXTEND)
    local winQM = GetNPCByID(16945639)
    local pos = mob:getPos()
    winQM:setPos(pos.x,pos.y,pos.z,pos.rot)
    winQM:setStatus(tpz.status.NORMAL)
    player:addTitle(tpz.title.DYNAMIS_QUFIM_INTERLOPER)
end

function onMobRoamAction(mob)
    dynamis.mobOnRoamAction(mob)
end

function onMobRoam(mob)
    dynamis.mobOnRoam(mob)
end

function onMobEngaged(mob, target)
    require("scripts/zones/Dynamis-Qufim/dynamis_mobs")
    randomChildrenListArg = nil
    if mobList[zone][mob:getID()].randomChildrenList ~= nil then randomChildrenListArg = randomChildrenList[zone][mobList[zone][mob:getID()].randomChildrenList] end
    dynamis.statueOnEngaged(mob, target, mobList[zone], randomChildrenListArg)
end

function onMobFight(mob)
-- Remove Mods Per NM or Elemental Kill
    -- IDs for Kills
    local scolopendra = GetMobByID(16945287)
    local stringes = GetMobByID(16945320)
    local suttung = GetMobByID(16945320)
    local fireele = GetMobByID(16945641)
    local iceele = GetMobByID(16945635)
    local airele = GetMobByID(16945633)
    local earthele = GetMobByID(16945636)
    local thunderele = GetMobByID(16945632)
    local waterele = GetMobByID(16945629)
    local lightele = GetMobByID(16945634)
    local darkele = GetMobByID(16945642)
    -- Scolopendra Kill Reduces Auto Regen
    if not scolopendra:isAlive() then
        if mob:getLocalVar("AntaeusRegen") == 1 then
            mob:delMod(tpz.mod.REGEN)
            mob:setLocalVar("AntaeusRegen", 0)
        end
    -- Stringes Kill Reduces Crit Hit Rate
    elseif not stringes:isAlive() then
        if mob:getLocalVar("AntaeusCrit") == 1 then
            mob:delMod(tpz.mod.CRITHITRATE)
            mob:setLocalVar("AntaeusCrit", 0)
        end
    -- Suttung Kill Removes Damage Taken Reduction
    elseif not suttung:isAlive() then
        if mob:getLocalVar("AntaeusDMG") == 1 then
            mob:delMod(tpz.mod.UDMGRANGE)
            mob:delMod(tpz.mod.UDMGPHYS)
            mob:delMod(tpz.mod.UDMGBREATH)
            mob:setLocalVar("AntaeusDMG", 0)
        end
    -- Elemental Kills
    elseif not fireele:isAlive() then
        if mob:getLocalVar("AntaeusFire") == 1 then
            mob:setMod(tpz.mod.FIRERES, 0)
            mob:setLocalVar("AntaeusFire", 0)
        end
    elseif not iceele:isAlive() then
        if mob:getLocalVar("AntaeusIce") == 1 then
            mob:setMod(tpz.mod.ICERES, 0)
            mob:setLocalVar("AntaeusIce", 0)
        end
    elseif not airele:isAlive() then
        if mob:getLocalVar("AntaeusWind") == 1 then
            mob:setMod(tpz.mod.WINDRES, 0)
            mob:setLocalVar("AntaeusWind", 0)
        end
    elseif not earthele:isAlive() then
        if mob:getLocalVar("AntaeusEarth") == 1 then
            mob:setMod(tpz.mod.EARTHRES, 0)
            mob:setLocalVar("AntaeusEarth", 0)
        end
    elseif not thunderele:isAlive() then
        if mob:getLocalVar("AntaeusThunder") == 1 then
            mob:setMod(tpz.mod.THUNDERRES, 0)
            mob:setLocalVar("AntaeusThunder", 0)
        end
    elseif not waterele:isAlive() then
        if mob:getLocalVar("AntaeusWater") == 1 then
            mob:setMod(tpz.mod.WATERRES, 0)
            mob:setLocalVar("AntaeusWater", 0)
        end
    elseif not lightele:isAlive() then
        if mob:getLocalVar("AntaeusLight") == 1 then
            mob:setMod(tpz.mod.LIGHTRES, 0)
            mob:setLocalVar("AntaeusLight", 0)
        end
    elseif not darkele:isAlive() then
        if mob:getLocalVar("AntaeusDark") == 1 then
            mob:setMod(tpz.mod.DARKRES, 0)
            mob:setLocalVar("AntaeusDark", 0)
        end
    end
end